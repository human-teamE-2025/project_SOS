package controller;

import utils.DBConnection;
import websocket.ActiveUserWebSocket;
import websocket.NotificationWebSocket;
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import org.json.JSONObject;
import javax.servlet.annotation.WebServlet;


public class LoginServlet extends HttpServlet {

    // ✅ GET 요청: 세션 상태 확인
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        JSONObject jsonResponse = new JSONObject();

        if (session != null && session.getAttribute("userId") != null) {
            jsonResponse.put("status", "loggedIn");
            jsonResponse.put("userId", session.getAttribute("userId"));
            jsonResponse.put("userName", session.getAttribute("userName"));
            jsonResponse.put("userEmail", session.getAttribute("userEmail"));
            jsonResponse.put("loginTime", session.getAttribute("loginTime"));
        } else {
            jsonResponse.put("status", "notLoggedIn");
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse.toString());
    }

    // ✅ POST 요청: 로그인 처리
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        JSONObject jsonResponse = new JSONObject();

        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "⚠ 이메일과 비밀번호를 입력하세요.");
            sendJsonResponse(response, HttpServletResponse.SC_BAD_REQUEST, jsonResponse);
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                throw new SQLException("❌ 데이터베이스 연결 실패!");
            }

            String query = "SELECT id, email, password, name FROM userInfo WHERE email = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String dbPassword = rs.getString("password");
                String hashedInputPassword = hashPassword(password);

                if (hashedInputPassword.equals(dbPassword)) {
                    HttpSession existingSession = request.getSession(false);
                    if (existingSession != null) {
                        try {
                            existingSession.invalidate();
                        } catch (IllegalStateException e) {
                            System.err.println("⚠ 기존 세션이 이미 무효화됨: " + e.getMessage());
                        }
                    }

                    // ✅ 새 세션 생성
                    HttpSession newSession = request.getSession(true);
                    int userId = rs.getInt("id");
                    String userEmail = rs.getString("email");
                    String userName = rs.getString("name");

                    newSession.setAttribute("userId", userId);
                    newSession.setAttribute("userEmail", userEmail);
                    newSession.setAttribute("userName", userName);
                    newSession.setMaxInactiveInterval(30 * 60);

                    // ✅ 로그인 시간 기록
                    String loginTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
                    newSession.setAttribute("loginTime", loginTime);

                    // ✅ 로그인 사용자 수 업데이트
                    SessionInfoServlet.addSession(newSession);
                    ActiveUserWebSocket.broadcastLoggedInUsers();

                    // ✅ 로그인 성공 시 알림 전송 (닉네임, 로그인 시간 포함)
                    NotificationWebSocket.sendLoginNotification(userName);

                    // ✅ JSON 응답 반환
                    jsonResponse.put("status", "success");
                    jsonResponse.put("userId", userId);
                    jsonResponse.put("userName", userName);
                    jsonResponse.put("userEmail", userEmail);
                    jsonResponse.put("loginTime", loginTime);

                    sendJsonResponse(response, HttpServletResponse.SC_OK, jsonResponse);
                } else {
                    jsonResponse.put("status", "error");
                    jsonResponse.put("message", "❌ 이메일 또는 비밀번호가 일치하지 않습니다.");
                    sendJsonResponse(response, HttpServletResponse.SC_UNAUTHORIZED, jsonResponse);
                }
            } else {
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "❌ 해당 이메일이 존재하지 않습니다.");
                sendJsonResponse(response, HttpServletResponse.SC_NOT_FOUND, jsonResponse);
            }
        } catch (SQLException e) {
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "❌ 데이터베이스 오류 발생: " + e.getMessage());
            sendJsonResponse(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, jsonResponse);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            DBConnection.close(conn, pstmt, rs);
        }
    }

    // ✅ JSON 응답 처리
    private void sendJsonResponse(HttpServletResponse response, int statusCode, JSONObject jsonResponse) throws IOException {
        response.setStatus(statusCode);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse.toString());
    }

    // ✅ 비밀번호 암호화 (SHA-256)
    private String hashPassword(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("❌ 암호화 오류 발생!", e);
        }
    }
}

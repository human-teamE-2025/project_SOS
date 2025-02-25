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

public class LoginServlet extends HttpServlet {

    /**
     * ✅ GET 요청: 현재 세션 상태 확인
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        JSONObject jsonResponse = new JSONObject();

        if (session != null && !session.isNew() && session.getAttribute("userId") != null) {
            jsonResponse.put("status", "loggedIn");
            jsonResponse.put("userId", session.getAttribute("userId"));
            jsonResponse.put("userName", session.getAttribute("userName"));
            jsonResponse.put("userEmail", session.getAttribute("userEmail"));
            jsonResponse.put("loginTime", session.getAttribute("loginTime"));
            jsonResponse.put("syncSession", true);
        } else {
            jsonResponse.put("status", "notLoggedIn");
            jsonResponse.put("syncSession", false);
        }

        sendJsonResponse(response, HttpServletResponse.SC_OK, jsonResponse);
    }

    /**
     * ✅ POST 요청: 로그인 처리
     */
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

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement("SELECT id, email, password, name FROM userInfo WHERE email = ?")) {
            
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                String dbPassword = rs.getString("password");
                String hashedInputPassword = hashPassword(password);

                if (hashedInputPassword.equals(dbPassword)) {
                    int userId = rs.getInt("id");
                    String userEmail = rs.getString("email");
                    String userName = rs.getString("name");

                    // ✅ 기존 세션이 있으면 안전하게 삭제
                    HttpSession oldSession = request.getSession(false);
                    if (oldSession != null) {
                        SessionInfoServlet.removeSession(oldSession);
                        oldSession.invalidate();
                    }

                    // ✅ 새로운 세션 생성
                    HttpSession session = request.getSession(true);
                    session.setAttribute("userId", userId);
                    session.setAttribute("userEmail", userEmail);
                    session.setAttribute("userName", userName);
                    session.setMaxInactiveInterval(60 * 60); // ✅ 1시간 유지

                    // ✅ 로그인 시간 기록
                    String loginTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
                    session.setAttribute("loginTime", loginTime);

                    // ✅ 세션 유지 (쿠키 설정)
                    response.addHeader("Set-Cookie", "JSESSIONID=" + session.getId() + "; Path=/; HttpOnly; Secure; SameSite=None");

                    // ✅ `SessionInfoServlet`을 통해 로그인 세션 등록
                    SessionInfoServlet.addSession(session);

                    // ✅ WebSocket을 이용한 실시간 알림 및 접속자 수 갱신
                    NotificationWebSocket.sendLoginNotification(userName);
                    ActiveUserWebSocket.broadcastLoggedInUsers();

                    // ✅ JSON 응답 반환 (로그인 유지 및 WebSocket 즉시 반영)
                    jsonResponse.put("status", "success");
                    jsonResponse.put("userId", userId);
                    jsonResponse.put("userName", userName);
                    jsonResponse.put("userEmail", userEmail);
                    jsonResponse.put("loginTime", loginTime);
                    jsonResponse.put("syncSession", true);
                    
                    // ✅ WebSocket 즉시 업데이트 실행
                    System.out.println("📡 WebSocket 상태 즉시 업데이트 실행");
                } else {
                    jsonResponse.put("status", "error");
                    jsonResponse.put("message", "❌ 이메일 또는 비밀번호가 일치하지 않습니다.");
                }
            } else {
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "❌ 해당 이메일이 존재하지 않습니다.");
            }
        } catch (SQLException | ClassNotFoundException e) {
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "❌ 서버 오류 발생: " + e.getMessage());
        }

        sendJsonResponse(response, HttpServletResponse.SC_OK, jsonResponse);
    }

    /**
     * ✅ JSON 응답 처리
     */
    private void sendJsonResponse(HttpServletResponse response, int statusCode, JSONObject jsonResponse) throws IOException {
        response.setStatus(statusCode);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse.toString());
    }

    /**
     * ✅ 비밀번호 암호화 (SHA-256)
     */
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

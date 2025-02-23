package controller;

import utils.DBConnection;
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

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            response.getWriter().write("error: missing email or password");
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();

            String query = "SELECT id, email, password, name FROM userInfo WHERE email = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String dbPassword = rs.getString("password");
                String hashedInputPassword = hashPassword(password); // ✅ SHA-256 해싱 후 비교

                if (hashedInputPassword.equals(dbPassword)) {
                    HttpSession session = request.getSession();
                    session.setAttribute("userId", rs.getInt("id"));
                    session.setAttribute("userEmail", rs.getString("email"));
                    session.setAttribute("userName", rs.getString("name"));

                    session.setMaxInactiveInterval(30 * 60); // ✅ 세션 유지 30분
                    SessionInfoServlet.incrementOnlineUsers(); // ✅ 접속자 증가
                    
                    // ✅ 로그인 시간 기록
                    String loginTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
                    session.setAttribute("loginTime", loginTime);

                    response.getWriter().write("success");
                    System.out.println("✅ 로그인 성공: " + email);
                } else {
                    response.getWriter().write("error: incorrect password");
                }
            } else {
                response.getWriter().write("error: email not found");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("error: sql exception " + e.getMessage());
        } catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
            DBConnection.close(conn, pstmt, rs);
        }
    }

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

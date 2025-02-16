package controller;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // DB 연결 정보
        String url = "jdbc:mysql://3.25.114.213:3306/userDB?useSSL=false&serverTimezone=UTC";
        String dbUser = "your_user";
        String dbPassword = "your_password";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, dbUser, dbPassword);

            // 사용자가 입력한 이메일 & 비밀번호를 검증하는 SQL
            String query = "SELECT id FROM userInfo WHERE email = ? AND password = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();

            if (rs.next()) {  // 일치하는 사용자가 존재하면 로그인 성공
                HttpSession session = request.getSession();
                session.setAttribute("userEmail", email);  // 세션에 사용자 이메일 저장
                response.getWriter().write("success");
            } else {
                response.getWriter().write("invalid");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("error");
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}

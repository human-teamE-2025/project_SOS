package controller;

import utils.DBConnection;
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CheckEmailServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String email = request.getParameter("email");

        if (email == null || email.trim().isEmpty()) {
            System.out.println("❌ 입력 오류: 이메일 값이 비어 있음");
            response.getWriter().write("error: invalid input");
            return;
        }

        if (!email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
            System.out.println("❌ 입력 오류: 잘못된 이메일 형식 (" + email + ")");
            response.getWriter().write("error: invalid email format");
            return;
        }

        System.out.println("🔍 이메일 중복 확인 요청: " + email);

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();

            String query = "SELECT EXISTS(SELECT 1 FROM userInfo WHERE email = ?)";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                int count = rs.getInt(1);
                if (count > 0) {
                    System.out.println("❌ 이메일 중복됨: " + email);
                    response.getWriter().write("duplicate_email");
                } else {
                    System.out.println("✅ 사용 가능한 이메일: " + email);
                    response.getWriter().write("available");
                }
            } else {
                System.out.println("🚨 이메일 조회 실패: " + email);
                response.getWriter().write("error: query failed");
            }

        } catch (SQLException e) {
            System.err.println("🚨 SQL 오류: " + e.getMessage());
            e.printStackTrace();
            response.getWriter().write("error: database exception");
        } catch (Exception e) {
            System.err.println("🚨 시스템 오류: " + e.getMessage());
            e.printStackTrace();
            response.getWriter().write("error: unknown exception");
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.err.println("🚨 리소스 정리 오류: " + e.getMessage());
            }
        }
    }
}

package controller;

import model.SignUpData;
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/SignUpCompleteServlet")
public class SignUpCompleteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        SignUpData signUpData = (SignUpData) session.getAttribute("signUpData");

        // ✅ 세션 데이터가 없으면 오류 메시지 반환
        if (signUpData == null) {
            response.getWriter().write("error: session data missing");
            return;
        }

        // ✅ 입력 데이터 확인 (디버깅 로그 추가)
        System.out.println("📌 이메일: " + signUpData.getEmail());
        System.out.println("📌 비밀번호: " + signUpData.getPassword());
        System.out.println("📌 닉네임: " + signUpData.getNickname());
        System.out.println("📌 생년월일: " + signUpData.getBirthdate());
        System.out.println("📌 성별: " + signUpData.getGender());

        // ✅ 데이터 누락 확인
        if (signUpData.getEmail() == null || signUpData.getEmail().isEmpty()) {
            response.getWriter().write("error: email missing");
            return;
        }
        if (signUpData.getPassword() == null || signUpData.getPassword().isEmpty()) {
            response.getWriter().write("error: password missing");
            return;
        }
        if (signUpData.getNickname() == null || signUpData.getNickname().isEmpty()) {
            response.getWriter().write("error: nickname missing");
            return;
        }
        if (signUpData.getBirthdate() == null || signUpData.getBirthdate().isEmpty()) {
            response.getWriter().write("error: birthdate missing");
            return;
        }
        if (signUpData.getGender() == null || signUpData.getGender().isEmpty()) {
            response.getWriter().write("error: gender missing");
            return;
        }

        String url = "jdbc:mysql://3.25.114.213:3306/userDB?useSSL=false&serverTimezone=UTC";
        String id = "your_user";
        String pwd = "your_password";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, id, pwd);

            // gender 값 변환 (ENUM 'M', 'F'에 맞게 설정)
            String gender = signUpData.getGender().equals("male") ? "M" : "F";

            // 회원가입 데이터 삽입
            String query = "INSERT INTO userInfo (email, password, name, birthdate, gender, created_at) VALUES (?, ?, ?, ?, ?, NOW())";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, signUpData.getEmail());
            pstmt.setString(2, signUpData.getPassword());
            pstmt.setString(3, signUpData.getNickname());
            pstmt.setString(4, signUpData.getBirthdate());
            pstmt.setString(5, gender);

            int result = pstmt.executeUpdate();
            if (result > 0) {
                response.getWriter().write("success");
                session.removeAttribute("signUpData"); // ✅ 회원가입 완료 후 세션 초기화
            } else {
                response.getWriter().write("error: insert failed");
            }
        } catch (SQLIntegrityConstraintViolationException e) {
            response.getWriter().write("error: duplicate entry");
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("error: sql exception " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("error: unknown " + e.getMessage());
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

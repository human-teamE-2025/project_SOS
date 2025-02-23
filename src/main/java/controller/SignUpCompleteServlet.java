package controller;

import model.SignUpData;
import utils.DBConnection;
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SignUpCompleteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        SignUpData signUpData = (SignUpData) session.getAttribute("signUpData");

        if (signUpData == null) {
            response.getWriter().write("error: session data missing");
            return;
        }

        // ✅ 입력 데이터 확인 (디버깅 로그 추가)
        System.out.println("📌 [회원가입 최종 단계]");
        System.out.println("📩 이메일: " + signUpData.getEmail());
        System.out.println("🔑 비밀번호: " + signUpData.getPassword());
        System.out.println("👤 닉네임: " + signUpData.getNickname());
        System.out.println("📅 생년월일: " + signUpData.getBirthdate());
        System.out.println("⚧ 성별: " + signUpData.getGender());
        System.out.println("🎵 좋아하는 장르: " + signUpData.getGenre());

        // ✅ 데이터 누락 확인
        if (signUpData.getEmail() == null || signUpData.getPassword() == null || 
            signUpData.getNickname() == null || signUpData.getBirthdate() == null || 
            signUpData.getGender() == null) {
            response.getWriter().write("error: missing required data");
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // ✅ 트랜잭션 적용 (롤백 가능)

            String gender = signUpData.getGender().equals("male") ? "M" : "F";

            // ✅ 이메일 중복 확인
            String checkEmailQuery = "SELECT COUNT(*) FROM userInfo WHERE email = ?";
            pstmt = conn.prepareStatement(checkEmailQuery);
            pstmt.setString(1, signUpData.getEmail());
            rs = pstmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                response.getWriter().write("error: duplicate email");
                conn.rollback();
                return;
            }
            rs.close();
            pstmt.close();

            // ✅ 회원가입 데이터 삽입 (genre 추가)
            String insertQuery = "INSERT INTO userInfo (email, password, name, birthdate, gender, genre, created_at) VALUES (?, ?, ?, ?, ?, ?, NOW())";
            pstmt = conn.prepareStatement(insertQuery);
            pstmt.setString(1, signUpData.getEmail());
            pstmt.setString(2, signUpData.getPassword()); // ✅ 비밀번호 암호화 제외
            pstmt.setString(3, signUpData.getNickname());
            pstmt.setString(4, signUpData.getBirthdate());
            pstmt.setString(5, gender);
            pstmt.setString(6, signUpData.getGenre() != null ? signUpData.getGenre() : "null"); // ✅ 장르 저장

            int result = pstmt.executeUpdate();
            if (result > 0) {
                conn.commit(); // ✅ 모든 작업 완료 후 커밋
                response.getWriter().write("success");
                session.removeAttribute("signUpData");
                System.out.println("✅ 회원가입 성공: " + signUpData.getEmail());
            } else {
                conn.rollback();
                response.getWriter().write("error: insert failed");
            }

        } catch (SQLIntegrityConstraintViolationException e) {
            response.getWriter().write("error: duplicate entry");
        } catch (SQLException e) {
            try { if (conn != null) conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            e.printStackTrace();
            response.getWriter().write("error: sql exception " + e.getMessage());
        } catch (Exception e) {
            try { if (conn != null) conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            e.printStackTrace();
            response.getWriter().write("error: unknown " + e.getMessage());
        } finally {
            DBConnection.close(conn, pstmt);
        }
    }
}

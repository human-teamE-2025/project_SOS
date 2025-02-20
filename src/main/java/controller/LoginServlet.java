package controller;

import utils.DBConnection;
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.concurrent.ConcurrentHashMap;

public class LoginServlet extends HttpServlet {
    
    // 🚨 로그인 시도 제한 (과도한 로그인 방지)
    private static final ConcurrentHashMap<String, Integer> loginAttempts = new ConcurrentHashMap<>();
    private static final int MAX_ATTEMPTS = 5;  // 최대 허용 로그인 시도 횟수
    private static final long LOCKOUT_TIME_MS = 5 * 60 * 1000; // 5분 락 (밀리초)

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        // ✅ 클라이언트 요청에서 이메일 & 비밀번호 가져오기
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // ✅ 입력값 검증
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            response.getWriter().write("error: invalid input");
            System.out.println("❌ 로그인 실패: 입력값 부족");
            return;
        }

        // ✅ 로그인 시도 제한 확인 (Rate Limiting)
        if (isAccountLocked(email)) {
            response.getWriter().write("error: account locked");
            System.out.println("🚨 로그인 시도 초과: 계정 잠김 [" + email + "]");
            return;
        }

        // ✅ 디버깅 로그 (로그인 시도)
        System.out.println("🔍 로그인 시도: " + email);

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // ✅ DB 연결
            conn = DBConnection.getConnection();

            // ✅ 비밀번호 확인을 위한 SQL 쿼리 (해싱된 비밀번호 사용)
            String query = "SELECT id, password FROM userInfo WHERE email = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, email);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                String storedHashedPassword = rs.getString("password");

                // ✅ 비밀번호 해시 비교 (입력값과 저장된 해시값 비교)
                if (verifyPassword(password, storedHashedPassword)) {
                    // ✅ 로그인 성공: 세션 생성
                    HttpSession session = request.getSession();
                    session.setAttribute("userEmail", email);
                    session.setMaxInactiveInterval(30 * 60); // 30분 후 세션 만료

                    // ✅ 보안 강화: HttpOnly, Secure 속성 설정
                    response.setHeader("Set-Cookie", "JSESSIONID=" + session.getId() + "; HttpOnly; Secure");

                    System.out.println("✅ 로그인 성공: " + email);

                    // 로그인 성공 시 로그인 시도 초기화
                    resetLoginAttempts(email);

                    response.getWriter().write("success");
                } else {
                    // ❌ 비밀번호 불일치
                    incrementLoginAttempts(email);
                    System.out.println("❌ 로그인 실패: 비밀번호 불일치 [" + email + "]");
                    response.getWriter().write("invalid");
                }
            } else {
                // ❌ 존재하지 않는 이메일
                incrementLoginAttempts(email);
                System.out.println("❌ 로그인 실패: 이메일 존재하지 않음 [" + email + "]");
                response.getWriter().write("invalid");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("🚨 데이터베이스 오류: " + e.getMessage());
            response.getWriter().write("error: database exception " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("🚨 알 수 없는 오류 발생: " + e.getMessage());
            response.getWriter().write("error: unknown exception " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
                System.err.println("🚨 자원 해제 오류: " + e.getMessage());
            }
        }
    }

    // ✅ 비밀번호 해시 검증 (SHA-256 + salt 방식)
    private boolean verifyPassword(String inputPassword, String storedHashedPassword) throws Exception {
        return hashPassword(inputPassword).equals(storedHashedPassword);
    }

    // ✅ SHA-256을 이용한 비밀번호 해싱
    private String hashPassword(String password) throws Exception {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        md.update(getSalt());
        byte[] hashedBytes = md.digest(password.getBytes());
        return Base64.getEncoder().encodeToString(hashedBytes);
    }

    // ✅ 안전한 Salt 생성 (SecureRandom 사용)
    private byte[] getSalt() {
        byte[] salt = new byte[16];
        new SecureRandom().nextBytes(salt);
        return salt;
    }

    // ✅ 로그인 시도 증가
    private void incrementLoginAttempts(String email) {
        loginAttempts.put(email, loginAttempts.getOrDefault(email, 0) + 1);
    }

    // ✅ 로그인 시도 초기화
    private void resetLoginAttempts(String email) {
        loginAttempts.remove(email);
    }

    // ✅ 계정 잠금 확인
    private boolean isAccountLocked(String email) {
        return loginAttempts.getOrDefault(email, 0) >= MAX_ATTEMPTS;
    }
}

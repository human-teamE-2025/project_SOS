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

public class SignInServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // ✅ 세션 유지 및 회원가입 데이터 불러오기
        HttpSession session = request.getSession(true);
        SignUpData signUpData = (SignUpData) session.getAttribute("signUpData");

        if (signUpData == null) {
            signUpData = new SignUpData();
            session.setAttribute("signUpData", signUpData);
        }

        // ✅ 요청 데이터 가져오기
        String step = request.getParameter("step");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String nickname = request.getParameter("nickname");
        String birthdate = request.getParameter("birthdate");
        String gender = request.getParameter("gender");

        // ✅ 디버깅 로그 추가
        System.out.println("🔍 [회원가입 진행 단계] Step: " + step);
        System.out.println("📩 [현재 세션 상태] Email: " + signUpData.getEmail());

        // ✅ Step 1: 이메일 저장
        if ("1".equals(step) && email != null && !email.trim().isEmpty()) {
            signUpData.setEmail(email);
            session.setAttribute("signUpData", signUpData);
            System.out.println("✅ 이메일 저장 완료: " + email);
            response.getWriter().write("success");

        // ✅ Step 2: 비밀번호 저장
        } else if ("2".equals(step) && password != null && !password.trim().isEmpty()) {
            if (signUpData.getEmail() == null || signUpData.getEmail().isEmpty()) {
                System.out.println("❌ 오류: 이메일 정보 없음");
                response.getWriter().write("error: email missing in session");
                return;
            }
            signUpData.setPassword(password);
            session.setAttribute("signUpData", signUpData);
            System.out.println("✅ 비밀번호 저장 완료");
            response.getWriter().write("success");

        // ✅ Step 3: 프로필 정보 저장
        } else if ("3".equals(step) && nickname != null && !nickname.trim().isEmpty() 
                                     && birthdate != null && !birthdate.trim().isEmpty() 
                                     && gender != null && !gender.trim().isEmpty()) {
            if (signUpData.getEmail() == null || signUpData.getPassword() == null) {
                System.out.println("❌ 오류: 이전 단계 데이터 없음");
                response.getWriter().write("error: missing previous data in session");
                return;
            }
            signUpData.setNickname(nickname);
            signUpData.setBirthdate(birthdate);
            signUpData.setGender(gender);
            session.setAttribute("signUpData", signUpData);
            System.out.println("✅ 프로필 정보 저장 완료");
            response.getWriter().write("success");

        // ✅ 오류 처리
        } else {
            System.out.println("❌ 오류: invalid step or missing data");
            response.getWriter().write("error: invalid step or missing data");
        }
    }
}

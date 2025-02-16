package controller;

import model.SignUpData;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/SignInServlet")
public class SignInServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // ✅ 기존 세션 유지 (없으면 새로 생성)
        HttpSession session = request.getSession(true);

        // ✅ 세션에서 기존 데이터 불러오기
        SignUpData signUpData = (SignUpData) session.getAttribute("signUpData");

        // ✅ signUpData가 없으면 새로 생성하여 세션에 저장
        if (signUpData == null) {
            signUpData = new SignUpData();
            session.setAttribute("signUpData", signUpData);
        }

        // ✅ 클라이언트에서 받은 데이터 가져오기
        String step = request.getParameter("step");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String nickname = request.getParameter("nickname");
        String birthdate = request.getParameter("birthdate");
        String gender = request.getParameter("gender");

        // ✅ 서버 로그 출력
        System.out.println("🔍 [회원가입 진행 단계] Step: " + step);
        System.out.println("📩 [현재 세션 상태] Email: " + signUpData.getEmail());

        // ✅ Step 1: 이메일 저장
        if ("1".equals(step) && email != null && !email.isEmpty()) {
            signUpData.setEmail(email);
            session.setAttribute("signUpData", signUpData);
            response.getWriter().write("success");

        // ✅ Step 2: 비밀번호 저장
        } else if ("2".equals(step) && password != null && !password.isEmpty()) {
            if (signUpData.getEmail() == null || signUpData.getEmail().isEmpty()) {
                response.getWriter().write("error: email missing in session");
                return;
            }
            signUpData.setPassword(password);
            session.setAttribute("signUpData", signUpData);
            response.getWriter().write("success");

        // ✅ Step 3: 닉네임 & 생년월일 & 성별 저장
        } else if ("3".equals(step) && nickname != null && !nickname.isEmpty()) {
            if (signUpData.getEmail() == null || signUpData.getPassword() == null) {
                response.getWriter().write("error: missing previous data in session");
                return;
            }
            signUpData.setNickname(nickname);
            signUpData.setBirthdate(birthdate);
            signUpData.setGender(gender);
            session.setAttribute("signUpData", signUpData);
            response.getWriter().write("success");

        // ✅ 오류 처리
        } else {
            response.getWriter().write("error: invalid step or missing data");
        }
    }
}

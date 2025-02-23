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
        String genre = request.getParameter("genre"); // ✅ 추가

        // ✅ Step 1: 이메일 저장
        if ("1".equals(step) && email != null && !email.trim().isEmpty()) {
            signUpData.setEmail(email);
            session.setAttribute("signUpData", signUpData);
            response.getWriter().write("success");

        // ✅ Step 2: 비밀번호 저장
        } else if ("2".equals(step) && password != null && !password.trim().isEmpty()) {
            if (signUpData.getEmail() == null) {
                response.getWriter().write("error: email missing in session");
                return;
            }
            signUpData.setPassword(password);
            session.setAttribute("signUpData", signUpData);
            response.getWriter().write("success");

        // ✅ Step 3: 프로필 정보 저장 (닉네임, 생년월일, 성별, 좋아하는 장르)
        } else if ("3".equals(step) && nickname != null && !nickname.trim().isEmpty() 
                                     && birthdate != null && !birthdate.trim().isEmpty() 
                                     && gender != null && !gender.trim().isEmpty()) {
            if (signUpData.getEmail() == null || signUpData.getPassword() == null) {
                response.getWriter().write("error: missing previous data in session");
                return;
            }
            signUpData.setNickname(nickname);
            signUpData.setBirthdate(birthdate);
            signUpData.setGender(gender);
            signUpData.setGenre(genre != null ? genre : "null"); // ✅ genre가 없으면 null 처리
            session.setAttribute("signUpData", signUpData);
            response.getWriter().write("success");

        } else {
            response.getWriter().write("error: invalid step or missing data");
        }
    }
}

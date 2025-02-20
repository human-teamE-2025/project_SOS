package controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class VerifyCaptchaServlet extends HttpServlet {
    private static final String SECRET_KEY = "6LeKoN0qAAAAAJG7u8ZAuLZamJEhqAo8gTyji2MJ"; // 🔑 캡차 비밀키

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String captchaResponse = request.getParameter("g-recaptcha-response");

        if (captchaResponse == null || captchaResponse.isEmpty()) {
            response.getWriter().write("error: captcha missing");
            return;
        }

        try {
            // ✅ Google reCAPTCHA 검증 요청
            String url = "https://www.google.com/recaptcha/api/siteverify?secret=" + SECRET_KEY + "&response=" + captchaResponse;
            HttpURLConnection conn = (HttpURLConnection) new URL(url).openConnection();
            conn.setRequestMethod("POST");

            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String inputLine;
            StringBuilder result = new StringBuilder();

            while ((inputLine = in.readLine()) != null) {
                result.append(inputLine);
            }
            in.close();

            // ✅ 캡차 검증 결과 확인
            if (result.toString().contains("\"success\": true")) {
                response.getWriter().write("success");
            } else {
                response.getWriter().write("error: captcha failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("error: server exception");
        }
    }
}

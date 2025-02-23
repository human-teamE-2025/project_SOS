package controller;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.concurrent.atomic.AtomicInteger;
import org.json.JSONObject;

public class SessionInfoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // ✅ 현재 접속자 수 (AtomicInteger로 동기화)
    private static final AtomicInteger onlineUsers = new AtomicInteger(0);

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        JSONObject jsonResponse = new JSONObject();

        if (session != null && session.getAttribute("userId") != null) {
            jsonResponse.put("loggedIn", true);
            
            // ✅ 세션 만료 시간 계산 (현재 시간 + 세션 만료까지 남은 시간)
            long expireTime = session.getLastAccessedTime() + (session.getMaxInactiveInterval() * 1000);
            jsonResponse.put("sessionExpireTime", expireTime);

            jsonResponse.put("onlineUsers", onlineUsers.get());
        } else {
            jsonResponse.put("loggedIn", false);
        }

        response.setContentType("application/json");
        response.getWriter().write(jsonResponse.toString());
    }

    // ✅ 로그인 시 접속자 증가
    public static void incrementOnlineUsers() {
        onlineUsers.incrementAndGet();
    }

    // ✅ 로그아웃 시 접속자 감소
    public static void decrementOnlineUsers() {
        onlineUsers.decrementAndGet();
    }
}

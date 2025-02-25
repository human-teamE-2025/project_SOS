package controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import websocket.ActiveUserWebSocket;
import websocket.NotificationWebSocket;

public class LogoutServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            try {
                if (!session.isNew() && session.getAttribute("userId") != null) {
                    // ✅ 로그인한 사용자 정보 가져오기
                    String userName = (String) session.getAttribute("userName");

                    // ✅ 세션에서 사용자 제거
                    SessionInfoServlet.removeSession(session);
                    
                    // ✅ 로그아웃 알림 전송 (닉네임, 로그아웃 시간 포함)
                    NotificationWebSocket.sendLogoutNotification(userName);

                    // ✅ 세션 무효화
                    session.invalidate();
                }
            } catch (IllegalStateException e) {
                System.err.println("⚠ 세션이 이미 무효화됨: " + e.getMessage());
            }

            // ✅ WebSocket에서 사용자 수 갱신
            ActiveUserWebSocket.broadcastLoggedInUsers();
        }

        // ✅ JSON 응답 반환
        response.setContentType("application/json; charset=UTF-8");
        response.getWriter().write("{\"status\": \"success\"}");
    }
}

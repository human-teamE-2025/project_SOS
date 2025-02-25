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
import org.json.JSONObject;

public class LogoutServlet extends HttpServlet {

    /**
     * ✅ POST 요청: 로그아웃 처리
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        JSONObject jsonResponse = new JSONObject();

        if (session == null || session.getAttribute("userId") == null) {
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "세션이 이미 만료되었습니다.");
        } else {
            try {
                String userName = (String) session.getAttribute("userName");
                String logoutTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());

                // ✅ WebSocket 알림 전송 및 사용자 수 갱신
                NotificationWebSocket.sendLogoutNotification(userName);
                ActiveUserWebSocket.broadcastLoggedInUsers();

                // ✅ 세션 무효화
                session.invalidate();

                // ✅ 로그아웃 후 쿠키 삭제
                response.addHeader("Set-Cookie", "JSESSIONID=; Path=/; HttpOnly; Secure; SameSite=None; Max-Age=0");

                jsonResponse.put("status", "success");
                jsonResponse.put("message", userName + "님이 로그아웃하였습니다.");
                jsonResponse.put("logoutTime", logoutTime);
                jsonResponse.put("syncSession", false);  // 클라이언트에서 `sessionStorage.clear();` 실행 유도
            } catch (IllegalStateException e) {
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "세션이 이미 종료되었습니다.");
            }
        }

        sendJsonResponse(response, jsonResponse);
    }

    /**
     * ✅ JSON 응답 처리 (일관된 JSON 반환)
     */
    private void sendJsonResponse(HttpServletResponse response, JSONObject jsonResponse) throws IOException {
        response.setContentType("application/json; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse.toString());
    }
}

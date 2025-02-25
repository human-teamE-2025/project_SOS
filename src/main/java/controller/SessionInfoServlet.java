package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collections;
import java.util.Set;
import java.util.HashSet;
import java.util.HashMap;
import org.json.JSONObject;
import websocket.ActiveUserWebSocket;
import websocket.NotificationWebSocket;


public class SessionInfoServlet extends HttpServlet {
    private static final Set<String> loggedInUsers = Collections.synchronizedSet(new HashSet<>());
    private static final HashMap<String, HttpSession> userSessions = new HashMap<>();

    /**
     * ✅ 클라이언트가 현재 로그인 상태를 확인하는 요청을 보낼 때 처리
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        JSONObject json = new JSONObject();
        
        if (session != null && session.getAttribute("userId") != null) {
            json.put("loggedIn", true);
            json.put("userId", session.getAttribute("userId"));
            json.put("userName", session.getAttribute("userName"));
            json.put("onlineUsers", getLoggedInUsersCount());
        } else {
            json.put("loggedIn", false);
            json.put("onlineUsers", 0);
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(json.toString());
        out.flush();
    }

    /**
     * ✅ 세션을 추가하고, 로그인 알림을 전송하며, WebSocket을 통해 현재 접속자 수 갱신
     */
    public static synchronized void addSession(HttpSession session) {
        String userId = getUserIdFromSession(session);

        if (userId != null && !userSessions.containsKey(userId)) {
            try {
                if (userSessions.containsKey(userId)) {
                    HttpSession oldSession = userSessions.get(userId);
                    if (oldSession != null) oldSession.invalidate();
                    loggedInUsers.remove(userId);
                    userSessions.remove(userId);
                }

                loggedInUsers.add(userId);
                userSessions.put(userId, session);

                String userName = (String) session.getAttribute("userName");
                if (userName != null) {
                    // ✅ 같은 세션에서 중복 호출 방지
                    NotificationWebSocket.sendLoginNotification(userName);
                    ActiveUserWebSocket.broadcastLoggedInUsers();
                }

            } catch (IllegalStateException e) {
                System.err.println("⚠ 세션이 이미 무효화됨: " + e.getMessage());
            }
        }
    }

    /**
     * ✅ 세션을 제거하고, 로그아웃 알림을 전송하며, WebSocket을 통해 현재 접속자 수 갱신
     */
    public static synchronized void removeSession(HttpSession session) {
        String userId = getUserIdFromSession(session);

        if (userId != null && userSessions.containsKey(userId)) {
            loggedInUsers.remove(userId);
            userSessions.remove(userId);

            String userName = (String) session.getAttribute("userName");
            if (userName != null) {
                NotificationWebSocket.sendLogoutNotification(userName);
                ActiveUserWebSocket.broadcastLoggedInUsers();
            }
        }
    }
    public static synchronized void cleanupExpiredSessions() {
        userSessions.entrySet().removeIf(entry -> {
            HttpSession session = entry.getValue();
            return session == null || session.getAttribute("userId") == null;
        });
    }
    
    /**
     * ✅ 현재 로그인된 사용자 수 반환
     */
    public static synchronized int getLoggedInUsersCount() {
        cleanupExpiredSessions();
        return loggedInUsers.size();
    }

    /**
     * ✅ 세션에서 userId를 가져오는 메서드
     */
    private static String getUserIdFromSession(HttpSession session) {
        Object userIdObj = session.getAttribute("userId");

        if (userIdObj instanceof Integer) {
            return Integer.toString((Integer) userIdObj);
        } else if (userIdObj instanceof String) {
            return (String) userIdObj;
        }
        return null;
    }
}

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
import java.util.Map;
import java.util.HashMap;
import java.util.HashSet;

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
        
        System.out.println("🔍 Session check: " + (session != null ? session.getId() : "No session"));

        if (session != null && !session.isNew() && session.getAttribute("userId") != null) {
            String userId = getUserIdFromSession(session);
            json.put("loggedIn", true);
            json.put("userId", userId);
            json.put("userName", session.getAttribute("userName"));
            json.put("onlineUsers", getLoggedInUsersCount());
            json.put("activeUsersList", getActiveUsers());

            // ✅ 클라이언트 세션 스토리지 동기화 (JS에서 `sessionStorage` 유지)
            json.put("syncSession", true);

            System.out.println("✅ 사용자 로그인 유지 확인: " + userId);
        } else {
            json.put("loggedIn", false);
            json.put("onlineUsers", 0);
            json.put("activeUsersList", new HashSet<>());
            json.put("syncSession", false);
            System.out.println("❌ 로그인 정보 없음 (세션 만료 또는 로그아웃)");
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
        System.out.println("🔍 addSession() 호출: " + userId); // 로그 추가

        if (userId != null && session != null && !session.isNew()) {
            try {
                // 기존 세션이 유효한지 확인
                if (userSessions.containsKey(userId)) {
                    HttpSession oldSession = userSessions.get(userId);
                    if (oldSession != null && oldSession.getAttribute("userId") != null) {
                        try {
                            oldSession.invalidate();
                        } catch (IllegalStateException ignored) {
                            System.err.println("⚠ 세션 무효화 시 오류 발생: " + ignored.getMessage());
                        }
                    }
                    loggedInUsers.remove(userId);
                    userSessions.remove(userId);
                }

                loggedInUsers.add(userId);
                userSessions.put(userId, session);
                System.out.println("✅ 로그인 세션 추가됨: " + userId); // 로그 추가

                String userName = (String) session.getAttribute("userName");
                if (userName != null) {
                    System.out.println("🔔 WebSocket 로그인 알림 전송: " + userName);
                    NotificationWebSocket.sendLoginNotification(userName);
                    ActiveUserWebSocket.broadcastLoggedInUsers(); // 접속자 수 갱신
                }

                System.out.println("✅ 로그인 세션 추가됨: " + userId);
            } catch (IllegalStateException e) {
                System.err.println("⚠ 세션이 이미 무효화됨: " + e.getMessage());
            }
        }
    }

    /**
     * ✅ 세션을 제거하고, 로그아웃 알림을 전송하며, WebSocket을 통해 현재 접속자 수 갱신
     */
    public static synchronized void removeSession(HttpSession session) {
        if (session == null || session.getAttribute("userId") == null) return;  // 세션 유효성 체크

        String userId = getUserIdFromSession(session);
        System.out.println("🔍 removeSession() 호출: " + userId); // 로그 추가

        if (userId != null && userSessions.containsKey(userId)) {
            loggedInUsers.remove(userId);
            userSessions.remove(userId);

            String userName = (String) session.getAttribute("userName");
            if (userName != null) {
                System.out.println("❌ WebSocket 로그아웃 알림 전송: " + userName);
                NotificationWebSocket.sendLogoutNotification(userName);
                ActiveUserWebSocket.broadcastLoggedInUsers(); // 접속자 수 갱신
            }

            try {
                session.invalidate();
            } catch (IllegalStateException ignored) {
                System.err.println("⚠ 세션 무효화 시 오류 발생: " + ignored.getMessage());
            }
        }
    }

    /**
     * ✅ 만료된 세션 자동 정리
     */
    public static synchronized void cleanupExpiredSessions() {
        userSessions.entrySet().removeIf(entry -> {
            HttpSession session = entry.getValue();
            return session == null || session.getAttribute("userId") == null;
        });

        loggedInUsers.removeIf(userId -> !userSessions.containsKey(userId));
    }
    
    /**
     * ✅ 현재 로그인된 사용자 수 반환
     */
    public static synchronized int getLoggedInUsersCount() {
        cleanupExpiredSessions(); // 만료된 세션 정리
        int count = loggedInUsers.size();
        System.out.println("🟢 현재 로그인된 사용자 수: " + count);
        return count;
    }
    
    /**
     * ✅ 현재 로그인된 사용자 목록 반환
     */
    public static synchronized Set<Map<String, String>> getActiveUsers() {
        cleanupExpiredSessions(); // 만료된 세션 정리
        Set<Map<String, String>> activeUsers = new HashSet<>();
        for (String userId : loggedInUsers) {
            Map<String, String> userDetails = new HashMap<>();
            HttpSession session = userSessions.get(userId);
            if (session != null) {
                userDetails.put("userId", userId);
                userDetails.put("userName", (String) session.getAttribute("userName"));
                userDetails.put("userEmail", (String) session.getAttribute("userEmail"));
            }
            activeUsers.add(userDetails);
        }
        return activeUsers;
    }

    /**
     * ✅ 세션에서 userId를 가져오는 메서드
     */
    private static String getUserIdFromSession(HttpSession session) {
        if (session == null) return null;

        Object userIdObj = session.getAttribute("userId");
        if (userIdObj instanceof Integer) {
            return Integer.toString((Integer) userIdObj);
        } else if (userIdObj instanceof String) {
            return (String) userIdObj;
        }
        return null;
    }
}

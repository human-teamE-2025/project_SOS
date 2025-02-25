package websocket;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import javax.servlet.http.HttpSession;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.ServerEndpointConfig;
import org.json.JSONObject;
import controller.SessionInfoServlet;

@ServerEndpoint(value = "/activeUsers", configurator = ActiveUserWebSocket.Configurator.class)
public class ActiveUserWebSocket {

    private static final Set<Session> loggedInUserSessions = Collections.synchronizedSet(new HashSet<>());

    @OnOpen
    public void onOpen(Session session, EndpointConfig config) {
        HttpSession httpSession = (HttpSession) config.getUserProperties().get("httpSession");

        if (httpSession != null && httpSession.getAttribute("userId") != null) {
            synchronized (loggedInUserSessions) {
                loggedInUserSessions.add(session);
            }

            System.out.println("✅ WebSocket 연결 성공 (사용자 ID: " + httpSession.getAttribute("userId") + ")");

            // ✅ `SessionInfoServlet`을 통해 세션을 등록하여 동기화
            SessionInfoServlet.addSession(httpSession);

            // ✅ WebSocket을 통해 로그인한 사용자 정보 전송
            broadcastLoggedInUsers();
        } else {
            try {
                System.out.println("⚠ WebSocket 연결 거부됨 (로그인 상태가 아님): " + session.getId());
                session.close(new CloseReason(CloseReason.CloseCodes.NORMAL_CLOSURE, "로그인하지 않은 사용자"));
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    @OnClose
    public void onClose(Session session) {
        synchronized (loggedInUserSessions) {
            loggedInUserSessions.remove(session);
        }

        HttpSession httpSession = (HttpSession) session.getUserProperties().get("httpSession");
        if (httpSession != null) {
            try {
                // ✅ `SessionInfoServlet`을 통해 세션 제거
                SessionInfoServlet.removeSession(httpSession);
            } catch (IllegalStateException ignored) {
                // 세션이 이미 무효화되었을 경우 예외 방지
            }
        }

        System.out.println("❌ WebSocket 연결 종료됨: " + session.getId());

        // ✅ WebSocket을 통해 실시간 접속자 정보 업데이트
        broadcastLoggedInUsers();
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        System.out.println("📩 WebSocket 메시지 수신: " + message);
        if ("update".equals(message)) {
            broadcastLoggedInUsers();
        }
    }

    /**
     * ✅ 현재 로그인한 사용자 목록을 WebSocket을 통해 모든 클라이언트에게 전송
     */
    public static void broadcastLoggedInUsers() {
        int loggedInUsers = SessionInfoServlet.getLoggedInUsersCount();

        JSONObject jsonMessage = new JSONObject();
        jsonMessage.put("type", "activeUsers");
        jsonMessage.put("count", loggedInUsers);
        jsonMessage.put("users", SessionInfoServlet.getActiveUsers());

        System.out.println("📡 WebSocket 브로드캐스트 전송: 현재 접속자 " + loggedInUsers + "명");

        synchronized (loggedInUserSessions) {
            for (Session session : loggedInUserSessions) {
                try {
                    session.getBasicRemote().sendText(jsonMessage.toString());
                } catch (IOException e) {
                    System.err.println("⚠ WebSocket 메시지 전송 실패 (세션 제거): " + session.getId());
                    try {
                        session.close();
                    } catch (IOException ignored) {}
                }
            }
        }
    }

    public static class Configurator extends ServerEndpointConfig.Configurator {
        @Override
        public void modifyHandshake(ServerEndpointConfig config, HandshakeRequest request, HandshakeResponse response) {
            HttpSession httpSession = (HttpSession) request.getHttpSession();
            if (httpSession != null) {
                config.getUserProperties().put("httpSession", httpSession);
            }
        }
    }
}

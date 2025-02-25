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

import controller.SessionInfoServlet;

@ServerEndpoint(value = "/activeUsers", configurator = ActiveUserWebSocket.Configurator.class)
public class ActiveUserWebSocket {

    private static final Set<Session> loggedInUserSessions = Collections.synchronizedSet(new HashSet<>());

    @OnOpen
    public void onOpen(Session session, EndpointConfig config) {
        HttpSession httpSession = (HttpSession) config.getUserProperties().get("httpSession");

        if (httpSession != null && httpSession.getAttribute("userId") != null) {
            loggedInUserSessions.add(session);
            broadcastLoggedInUsers();
        } else {
            try {
                session.close(new CloseReason(CloseReason.CloseCodes.NORMAL_CLOSURE, "로그인하지 않은 사용자"));
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    @OnClose
    public void onClose(Session session) {
        loggedInUserSessions.remove(session);
        HttpSession httpSession = (HttpSession) session.getUserProperties().get("httpSession");
        if (httpSession != null) {
            SessionInfoServlet.removeSession(httpSession);
        }
        broadcastLoggedInUsers();
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        if ("update".equals(message)) {
            broadcastLoggedInUsers();
        }
    }

    // ✅ `public static`으로 변경하여 외부에서 접근 가능하도록 설정
    public static void broadcastLoggedInUsers() {
        int loggedInUsers = SessionInfoServlet.getLoggedInUsersCount();
        String message = String.valueOf(loggedInUsers);

        synchronized (loggedInUserSessions) {
            for (Session session : loggedInUserSessions) {
                try {
                    session.getBasicRemote().sendText(message);
                } catch (IOException e) {
                    e.printStackTrace();
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

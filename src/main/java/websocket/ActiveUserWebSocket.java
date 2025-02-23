package websocket;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/activeUsers")
public class ActiveUserWebSocket {

    private static final Set<Session> userSessions = Collections.synchronizedSet(new HashSet<>());

    @OnOpen
    public void onOpen(Session session) {
        userSessions.add(session);
        broadcastActiveUsers();
    }

    @OnClose
    public void onClose(Session session) {
        userSessions.remove(session);
        broadcastActiveUsers();
    }

    private void broadcastActiveUsers() {
        int activeUsers = userSessions.size();
        String message = String.valueOf(activeUsers);

        synchronized (userSessions) {
            for (Session session : userSessions) {
                try {
                    session.getBasicRemote().sendText(message);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}

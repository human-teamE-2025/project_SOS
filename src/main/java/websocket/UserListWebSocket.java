package websocket;

import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

@ServerEndpoint("/userList")
public class UserListWebSocket {

    private static final Set<Session> sessions = Collections.synchronizedSet(new HashSet<>());

    @OnOpen
    public void onOpen(Session session) {
        sessions.add(session);
        broadcastUserList(); // ✅ 모든 세션에 브로드캐스트
    }

    @OnClose
    public void onClose(Session session) {
        sessions.remove(session);
        broadcastUserList(); // ✅ 모든 세션에 브로드캐스트
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        broadcastUserList(); // ✅ 모든 세션에 브로드캐스트
    }

    static void broadcastUserList() {
        try {
            String userListJson = UserCountWebSocket.getUserListJson();
            for (Session activeSession : sessions) {
                if (activeSession.isOpen()) {
                    activeSession.getBasicRemote().sendText(userListJson);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

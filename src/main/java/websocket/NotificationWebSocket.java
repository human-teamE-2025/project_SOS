package websocket;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
import org.json.JSONObject;

@ServerEndpoint("/notifications")
public class NotificationWebSocket {
    private static final Set<Session> clients = Collections.synchronizedSet(new HashSet<>());

    @OnOpen
    public void onOpen(Session session) {
        clients.add(session);
        System.out.println("✅ WebSocket 연결 성공: " + session.getId());
    }

    @OnClose
    public void onClose(Session session) {
        clients.remove(session);
        System.out.println("❌ WebSocket 연결 종료: " + session.getId());
    }

    @OnMessage
    public void onMessage(String message, Session senderSession) {
        if ("update".equals(message)) {
            broadcastLoggedInUsers(); // 접속자 수 업데이트
        }
    }	


    public static void sendLoginNotification(String userName) {
        JSONObject message = new JSONObject();
        message.put("type", "notification");
        message.put("message", "✅ " + userName + "님이 로그인하였습니다.");
        broadcast(message.toString()); // ✅ JSON 형식으로 전송
    }

    public static void sendLogoutNotification(String userName) {
        JSONObject message = new JSONObject();
        message.put("type", "notification");
        message.put("message", "❌ " + userName + "님이 로그아웃하였습니다.");
        broadcast(message.toString()); // ✅ JSON 형식으로 전송
    }

    private static void broadcast(String message) {
        synchronized (clients) {
            for (Session client : clients) {
                try {
                    client.getBasicRemote().sendText(message);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}

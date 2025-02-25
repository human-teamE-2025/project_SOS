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

@ServerEndpoint(value = "/notifications", configurator = NotificationWebSocket.Configurator.class)
public class NotificationWebSocket {
    private static final Set<Session> clients = Collections.synchronizedSet(new HashSet<>());

    /** ✅ WebSocket 클라이언트가 연결되었을 때 */
    @OnOpen
    public void onOpen(Session session, EndpointConfig config) {
        HttpSession httpSession = (HttpSession) config.getUserProperties().get("httpSession");

        if (httpSession != null && httpSession.getAttribute("userId") != null) {
            synchronized (clients) {
                clients.add(session);
            }
            System.out.println("✅ WebSocket 연결 성공: " + session.getId());

            // ✅ 로그인 후 실시간 접속자 수 업데이트
            ActiveUserWebSocket.broadcastLoggedInUsers();
        } else {
            try {
                System.out.println("⚠ WebSocket 연결 거부됨 (로그인 상태가 아님): " + session.getId());
                session.close(new CloseReason(CloseReason.CloseCodes.NORMAL_CLOSURE, "로그인하지 않은 사용자"));
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    /** ✅ WebSocket 클라이언트가 연결 해제되었을 때 */
    @OnClose
    public void onClose(Session session) {
        synchronized (clients) {
            clients.remove(session);
        }
        System.out.println("❌ WebSocket 연결 종료: " + session.getId());

        // ✅ 현재 접속자 수 업데이트
        ActiveUserWebSocket.broadcastLoggedInUsers();
    }

    /** ✅ WebSocket 클라이언트가 메시지를 보냈을 때 */
    @OnMessage
    public void onMessage(String message, Session senderSession) {
        System.out.println("📩 WebSocket 메시지 수신: " + message);
        if ("update".equals(message)) {
            ActiveUserWebSocket.broadcastLoggedInUsers();
        }
    }

    /** ✅ 로그인 시 알림 전송 */
    public static void sendLoginNotification(String userName) {
        System.out.println("🔔 로그인 알림 전송: " + userName);
        JSONObject message = new JSONObject();
        message.put("type", "notification");
        message.put("message", "✅ " + userName + "님이 로그인하였습니다.");
        broadcast(message.toString());

        // ✅ 로그인 후 실시간 접속자 수 업데이트
        ActiveUserWebSocket.broadcastLoggedInUsers();
    }

    /** ✅ 로그아웃 시 알림 전송 */
    public static void sendLogoutNotification(String userName) {
        System.out.println("❌ 로그아웃 알림 전송: " + userName);
        JSONObject message = new JSONObject();
        message.put("type", "notification");
        message.put("message", "❌ " + userName + "님이 로그아웃하였습니다.");
        broadcast(message.toString());

        // ✅ 로그아웃 후 실시간 접속자 수 업데이트
        ActiveUserWebSocket.broadcastLoggedInUsers();
    }

    /** ✅ 커스텀 알림 전송 */
    public static void sendCustomNotification(String messageContent) {
        JSONObject message = new JSONObject();
        message.put("type", "notification");
        message.put("message", messageContent);
        broadcast(message.toString());
    }

    /** ✅ 메시지를 모든 클라이언트에게 브로드캐스트 */
    private static void broadcast(String message) {
        synchronized (clients) {
            for (Session client : clients) {
                try {
                    System.out.println("📡 WebSocket 브로드캐스트 전송: " + message);
                    client.getBasicRemote().sendText(message);
                } catch (IOException e) {
                    System.err.println("⚠ WebSocket 메시지 전송 실패: " + e.getMessage());
                    try {
                        client.close();
                    } catch (IOException ignored) {}
                }
            }
        }
    }

    /** ✅ WebSocket 핸드셰이크 설정을 위한 Configurator 클래스 */
    public static class Configurator extends ServerEndpointConfig.Configurator {
        @Override
        public void modifyHandshake(ServerEndpointConfig sec, HandshakeRequest request, HandshakeResponse response) {
            HttpSession httpSession = (HttpSession) request.getHttpSession();
            if (httpSession != null) {
                sec.getUserProperties().put("httpSession", httpSession);
            }
        }
    }
}

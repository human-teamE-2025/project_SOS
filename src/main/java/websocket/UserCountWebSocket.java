package websocket;

import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

@ServerEndpoint("/userCount")
public class UserCountWebSocket {

    private static final Set<Session> sessions = Collections.synchronizedSet(new HashSet<>());
    private static final List<Map<String, String>> userRecords = Collections.synchronizedList(new ArrayList<>());
    private static final Map<String, Map<String, String>> sessionInfo = new ConcurrentHashMap<>();
    private static int userCount = 0;
    private static int recordIndex = 0;

    private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    @OnOpen
    public void onOpen(Session session) {
        sessions.add(session);
        userCount++;

        Map<String, String> userData = new HashMap<>();
        userData.put("id", String.valueOf(++recordIndex));
        userData.put("type", "익명");
        userData.put("sessionId", session.getId());
        userData.put("connectedAt", sdf.format(new Date()));
        userData.put("disconnectedAt", "");

        sessionInfo.put(session.getId(), userData);
        userRecords.add(0, userData);

        System.out.println("New connection opened! Current user count: " + userCount);
        broadcastUpdates();
        
        // ✅ UserListWebSocket에도 변경 사항 반영 (메서드 이름 수정)
        broadcastUserCount();
        UserListWebSocket.broadcastUserList();

    }

    @OnClose
    public void onClose(Session session) {
        sessions.remove(session);
        userCount--;

        if (sessionInfo.containsKey(session.getId())) {
            Map<String, String> userData = sessionInfo.get(session.getId());
            userData.put("disconnectedAt", sdf.format(new Date()));

            for (Map<String, String> record : userRecords) {
                if (record.get("sessionId").equals(session.getId())) {
                    record.put("disconnectedAt", userData.get("disconnectedAt"));
                    break;
                }
            }

            sessionInfo.remove(session.getId());
        }

        System.out.println("📢 최신 userRecords: " + getUserListJson());
        broadcastUpdates();
        
        // ✅ UserListWebSocket에도 변경 사항 반영 (메서드 이름 수정)
       broadcastUserCount();
       UserListWebSocket.broadcastUserList();

    }



    // ✅ 현재 접속자 수 브로드캐스트
    private void broadcastUserCount() {
        try {
            for (Session activeSession : sessions) {
                if (activeSession.isOpen()) {
                    activeSession.getBasicRemote().sendText(String.valueOf(userCount));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static String getUserListJson() {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < userRecords.size(); i++) {
            Map<String, String> record = userRecords.get(i);
            sb.append("{")
              .append("\"id\":\"").append(record.getOrDefault("id", "N/A")).append("\",")
              .append("\"type\":\"").append(record.getOrDefault("type", "N/A")).append("\",")
              .append("\"sessionId\":\"").append(record.getOrDefault("sessionId", "N/A")).append("\",")
              .append("\"connectedAt\":\"").append(record.getOrDefault("connectedAt", "N/A")).append("\",")
              .append("\"disconnectedAt\":\"").append(record.getOrDefault("disconnectedAt", "")).append("\"")
              .append("}");
            if (i < userRecords.size() - 1) sb.append(",");
        }
        sb.append("]");
        
        System.out.println("📢 최종 전송할 User List JSON: " + sb.toString()); // ✅ 서버에서 전송되는 JSON 확인
        return sb.toString();
    }



    // ✅ 실시간 사용자 리스트 브로드캐스트
    private void broadcastUpdates() {
        try {
            String userListJson = getUserListJson();
            String userCountJson = String.valueOf(userCount);

            for (Session activeSession : sessions) {
                if (activeSession.isOpen()) {
                    activeSession.getBasicRemote().sendText(userListJson);
                    activeSession.getBasicRemote().sendText(userCountJson);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}

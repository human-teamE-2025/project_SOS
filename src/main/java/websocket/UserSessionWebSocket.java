package websocket;

import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.text.SimpleDateFormat;
import java.util.*;
import org.json.JSONObject;
import org.json.JSONArray;

@ServerEndpoint("/userSessionTracker")
public class UserSessionWebSocket {

    private static final Map<Session, String> userSessions = Collections.synchronizedMap(new HashMap<>());
    private static final List<Map<String, String>> sessionLogs = Collections.synchronizedList(new ArrayList<>());
    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    @OnOpen
    public void onOpen(Session session) {
        String sessionId = session.getId();
        String connectTime = dateFormat.format(new Date());

        Map<String, String> sessionData = new HashMap<>();
        sessionData.put("sessionId", sessionId);
        sessionData.put("connectTime", connectTime);
        sessionData.put("disconnectTime", "접속 중");
        sessionData.put("status", "접속 중임");

        userSessions.put(session, sessionId);
        sessionLogs.add(sessionData);

        System.out.println("✅ User connected: " + sessionId + " at " + connectTime);
        broadcastSessionData();
    }

    @OnClose
    public void onClose(Session session) {
        String sessionId = userSessions.remove(session);
        String disconnectTime = dateFormat.format(new Date());

        for (Map<String, String> log : sessionLogs) {
            if (log.get("sessionId").equals(sessionId)) {
                log.put("disconnectTime", disconnectTime);
                log.put("status", "접속 끊김");
                break;
            }
        }

        System.out.println("❌ User disconnected: " + sessionId + " at " + disconnectTime);
        broadcastSessionData();
    }

    private void broadcastSessionData() {
        try {
            List<Map<String, String>> sortedLogs = new ArrayList<>(sessionLogs);

            // ✅ 정렬 로직 개선
            sortedLogs.sort((a, b) -> {
                if (a.get("status").equals("접속 중임") && !b.get("status").equals("접속 중임")) return -1;
                if (!a.get("status").equals("접속 중임") && b.get("status").equals("접속 중임")) return 1;
                return b.get("connectTime").compareTo(a.get("connectTime"));
            });

            // ✅ 접속자 통계 계산
            int totalRecords = sortedLogs.size();
            int activeCount = (int) sortedLogs.stream().filter(s -> s.get("status").equals("접속 중임")).count();
            int disconnectedCount = totalRecords - activeCount;

            JSONObject data = new JSONObject();
            data.put("sessionLogs", new JSONArray(sortedLogs));
            data.put("totalRecords", totalRecords);
            data.put("activeCount", activeCount);
            data.put("disconnectedCount", disconnectedCount);

            for (Session activeSession : userSessions.keySet()) {
                if (activeSession.isOpen()) {
                    activeSession.getBasicRemote().sendText(data.toString());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

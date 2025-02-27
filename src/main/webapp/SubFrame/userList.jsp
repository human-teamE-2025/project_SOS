<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/userList.css">
<button id="toggle-user-info" class="more-btn" onclick="openCustomModal()">더 보기</button>

<!-- ✅ 현재 접속자 리스트 모달 -->
<div id="custom-user-list-modal" class="custom-modal">
    <div class="custom-modal-content">
        <span class="custom-close-btn" onclick="closeCustomModal()">&times;</span>
        <div><h2 id="session-title">세션 접속 정보</h2>
        </div><div class="custom-table-container">
            <table id="custom-user-list-table" class="custom-table">
                <thead>
                    <tr>
                        <th>일련번호</th>
                        <th>기록 유형</th>
                        <th>세션 ID</th>
                        <th>접속 일시</th>
                        <th>접속 종료 일시</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>
</div>

<script>var userRecordSocket;
var userRecords = [];

//✅ 모달 열 때만 WebSocket 실행
window.openCustomModal = function() {
 document.getElementById("custom-user-list-modal").style.display = "block";

 // ✅ WebSocket이 이미 열려있으면 다시 연결하지 않음
 if (!userRecordSocket || userRecordSocket.readyState === WebSocket.CLOSED) {
	 window.initUserRecordWebSocket();
 }
 setTimeout(() => {
     console.log("🔄 openCustomModal()에서 테이블 업데이트 실행");
     window.updateUserListTable(); // ✅ 모달이 열린 후 테이블 업데이트 실행
 }, 100); // 100ms 지연 추가
}

//✅ 모달 닫기
function closeCustomModal() {
 document.getElementById("custom-user-list-modal").style.display = "none";
}

//✅ WebSocket을 모달이 열릴 때만 실행
window.initUserRecordWebSocket= function(){
 var wsUrl = "ws://localhost:8080${pageContext.request.contextPath}/userList";// ✅ URL 수정
 console.log("🌐 WebSocket 연결 시도: " + wsUrl);

 userRecordSocket = new WebSocket(wsUrl);

 userRecordSocket.onmessage = function(event) {
	    try {
	        let records = JSON.parse(event.data);
	        console.log("📢 WebSocket에서 받은 데이터:", records);

	        if (Array.isArray(records)) {
	            userRecords = records;
	            console.log("🔄 WebSocket 메시지 수신 후 테이블 업데이트 실행");
	            
	            // ✅ 강제 실행으로 즉시 업데이트
	            updateUserListTable();
	        } else {
	            console.error("❌ WebSocket에서 받은 데이터 형식이 잘못되었습니다:", event.data);
	        }
	    } catch (error) {
	        console.error("❌ WebSocket 데이터 처리 오류:", error);
	    }
	};
 userRecordSocket.onclose = function(){
     console.log("🔌 UserRecord WebSocket closed");
 };

 userRecordSocket.onerror = function(error) {
     console.error("❌ UserRecord WebSocket error:", error);
 };
}

//✅ WebSocket 메시지를 테이블에 삽입
window.updateUserListTable= function() {
 try {
     console.log("📌 테이블 업데이트 실행됨, 현재 데이터 개수:", userRecords.length);

     var tbody = document.querySelector("#custom-user-list-table tbody");
     if (!tbody) {
         console.error("❌ 테이블 tbody 요소를 찾을 수 없습니다!");
         return;
     }

     tbody.innerHTML = ""; // 기존 데이터 초기화

     if (userRecords.length === 0) {
         var emptyRow = document.createElement("tr");
         var emptyCell = document.createElement("td");
         emptyCell.setAttribute("colspan", "5");
         emptyCell.style.textAlign = "center";
         emptyCell.textContent = "현재 접속자가 없습니다.";
         emptyRow.appendChild(emptyCell);
         tbody.appendChild(emptyRow);
         return;
     }

     for (var i = 0; i < userRecords.length; i++) {
         var record = userRecords[i];
         console.log("📌 개별 레코드 데이터:", record);

         // 예외 처리 및 데이터 초기화
         var id = "N/A";
         if (record && typeof record.id === "string" && record.id.trim() !== "") {
             id = record.id;
         }

         var type = "N/A";
         if (record && typeof record.type === "string" && record.type.trim() !== "") {
             type = record.type;
         }

         var sessionId = "N/A";
         if (record && typeof record.sessionId === "string" && record.sessionId.trim() !== "") {
             sessionId = record.sessionId;
         }

         var connectedAt = "N/A";
         if (record && typeof record.connectedAt === "string" && record.connectedAt.trim() !== "") {
             connectedAt = record.connectedAt;
         }

         var disconnectedAt = "활성 세션";
         if (record && typeof record.disconnectedAt === "string" && record.disconnectedAt.trim() !== "") {
             disconnectedAt = record.disconnectedAt;
         }

         var row = document.createElement("tr");
         row.innerHTML =
             "<td>" + id + "</td>" +
             "<td>" + type + "</td>" +
             "<td>" + sessionId + "</td>" +
             "<td>" + connectedAt + "</td>" +
             "<td>" + disconnectedAt + "</td>";

         if (disconnectedAt === "활성 세션") {
             row.style.backgroundColor = "darkgreen";
         } else {
             row.style.backgroundColor = "darkred";
         }

         console.log("📢 추가되는 행:", row.innerHTML);
         tbody.appendChild(row);
     }

     console.log("✅ 테이블 업데이트 완료, 최종 행 개수:", tbody.children.length);
 } catch (error) {
     console.error("❌ updateUserListTable() 실행 중 오류 발생:", error);
 }
}


</script>
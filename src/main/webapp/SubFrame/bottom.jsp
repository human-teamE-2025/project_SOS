<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bottom.css">

<section id="bottom">
    <aside id="musicbar">
        <button class="play" id="backplay"><i class="fa-solid fa-backward"></i></button>
        <button class="play" id="play"><i class="fa-solid fa-play"></i></button>
        <button class="play" id="fowardplay"><i class="fa-solid fa-forward"></i></button>
    </aside>

    <footer>
        <span id="user-status">
            로그인 중인 유저: 
            <span id="userInfo">Waiting for user count...</span>
            <button id="toggle-user-info" class="more-btn" onclick="openCustomModal()" >더 보기</button>
        </span>&emsp;|&emsp;
        <a href="${pageContext.request.contextPath}/about.jsp?section=company">about</a>&emsp;|&emsp;
        <a href="${pageContext.request.contextPath}/about.jsp?section=terms">terms</a>&emsp;|&emsp;
        <a href="${pageContext.request.contextPath}/about.jsp?section=privacy">privacy</a>&emsp;
        Copyright © 2025 All rights reserved.
        <div id="session-info"></div>
    </footer>

    <aside id="settingbar">
        <button class="play" id="backplay"><i class="fa-solid fa-volume-high"></i></button>
        <button class="play" id="play"><i class="fa-solid fa-sliders"></i></button>
        <button class="play" id="fowardplay"><i class="fa-solid fa-repeat"></i></button>
    </aside>
</section>

<!-- ✅ 현재 접속자 리스트 모달 -->

    <div id="custom-user-list-modal" class="custom-modal">
        <div class="custom-modal-content">
            <span class="custom-close-btn" onclick="closeCustomModal()">&times;</span>
            <h2 id="session-title">세션 접속 정보</h2>
            <div class="custom-table-container">
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

<!-- ✅ WebSocket 전역 관리 모듈 추가 -->
<script src="${pageContext.request.contextPath}/static/js/globalWebSocket.js"></script>

<script>

var userSocket;
var messageSocket;


document.addEventListener("DOMContentLoaded", function () {
    
    const userCountElement = document.getElementById("active-users-count");
    const toggleUserInfoButton = document.getElementById("toggle-user-info");

    /** ✅ 실시간 사용자 수 업데이트 */
    function updateActiveUsersCount(count, loggedIn) {
        console.log("🔄 사용자 수 업데이트: ", count, " (로그인 상태:", loggedIn, ")");

        if (!userCountElement) return;

        if (loggedIn) {
            userCountElement.textContent = count + "명";
            userCountElement.classList.remove("login-link");
            userCountElement.classList.add("more-btn");
        } else {
            userCountElement.textContent = "로그인 후 확인";
            userCountElement.classList.remove("more-btn");
            userCountElement.classList.add("login-link");
        }
    }

    /** ✅ WebSocket에서 접속자 수 업데이트 */
    function handleActiveUsersUpdate(event) {
        console.log("📢 WebSocket에서 접속자 정보 업데이트 이벤트 수신:", event.detail.count);
        const loggedIn = sessionStorage.getItem("loggedIn") === "true";
        updateActiveUsersCount(event.detail.count, loggedIn);
    }

    /** ✅ 로그인 이벤트 */
    function handleLoginSuccess() {
        if (sessionStorage.getItem("loggedIn") !== "true") {
            sessionStorage.setItem("loggedIn", "true");
            window.globalWebSocketManager.sendUpdate();
            console.log("🔄 로그인 UI 업데이트 실행");

            // ✅ 로그인 후 즉시 현재 접속자 정보 업데이트
            document.dispatchEvent(new CustomEvent("updateActiveUsers", { detail: { count: 1 } }));
        }
    }

    /** ✅ 로그아웃 이벤트 */
    function handleLogoutSuccess() {
        if (sessionStorage.getItem("loggedIn") !== "false") {
            sessionStorage.setItem("loggedIn", "false");
            window.globalWebSocketManager.sendUpdate();
            console.log("🔄 로그아웃 UI 업데이트 실행");

            // ✅ 로그아웃 후 즉시 접속자 정보 0으로 설정
            document.dispatchEvent(new CustomEvent("updateActiveUsers", { detail: { count: 0 } }));
        }
    }

    /** ✅ WebSocket 이벤트 중복 제거 후 리스너 추가 */
    document.removeEventListener("updateActiveUsers", handleActiveUsersUpdate);
    document.addEventListener("updateActiveUsers", handleActiveUsersUpdate);

    document.removeEventListener("loginSuccess", handleLoginSuccess);
    document.addEventListener("loginSuccess", handleLoginSuccess);

    document.removeEventListener("logoutSuccess", handleLogoutSuccess);
    document.addEventListener("logoutSuccess", handleLogoutSuccess);

    /** ✅ "로그인 후 확인" 버튼 클릭 시 로그인 모달 열기 또는 접속자 리스트 표시 */
    toggleUserInfoButton.addEventListener("click", function () {
        let isLoggedIn = sessionStorage.getItem("loggedIn") === "true";

        if (!isLoggedIn) {
            loadLoginModal(); // ✅ 로그인 모달 열기
        } else {
            let modal = $("#user-list-modal");
            modal.fadeToggle(100);

            if (modal.is(":visible")) {
                fetchActiveUsers();
            }
        }
    });

    /** ✅ 현재 접속 중인 유저 리스트 가져오기 */
    function fetchActiveUsers() {
        $.ajax({
            url: "${pageContext.request.contextPath}/SessionInfoServlet",
            type: "GET",
            dataType: "json",
            success: function (data) {
                console.log("📢 서버에서 접속자 목록 응답:", data);
                let tbody = $("#user-list-table tbody").empty();
                if (data.activeUsersList) {
                    data.activeUsersList.forEach(user => {
                        tbody.append(`<tr>
                            <td>${user.userId || "N/A"}</td>
                            <td>${user.userName || "알 수 없음"}</td>
                            <td>${user.userEmail || "이메일 없음"}</td>
                        </tr>`);
                    });
                }
            },
            error: function () {
                console.error("❌ 접속자 정보 가져오기 실패");
            }
        });
    }
});
var socket;

//✅ WebSocket 초기화 및 데이터 수신
function initWebSocket() {
 socket = new WebSocket("ws://localhost:8080/${pageContext.request.contextPath}/userSessionTracker");

 socket.onopen = function(event) {
     console.log("✅ WebSocket 연결 성공!");
 };

 socket.onmessage = function(event) {
     console.log("📢 WebSocket 데이터 수신:", event.data);
     var data = JSON.parse(event.data);
     updateSessionTable(data.sessionLogs);
 };

 socket.onclose = function(event) {
     console.log("🔴 WebSocket 연결 종료.");
 };

 socket.onerror = function(error) {
     console.error("❌ WebSocket 오류 발생:", error);
 };
}

//✅ 테이블 업데이트
function updateSessionTable(sessionLogs) {
    var tableBody = document.getElementById("custom-user-list-table").getElementsByTagName("tbody")[0];
    tableBody.innerHTML = "";

    // ✅ 정렬: 접속 중인 세션을 위로, 종료된 세션을 아래로 정렬
    sessionLogs.sort((a, b) => {
        if (a.status === "접속 중임" && b.status !== "접속 중임") return -1;
        if (a.status !== "접속 중임" && b.status === "접속 중임") return 1;
        return b.connectTime.localeCompare(a.connectTime);
    });

    // ✅ 테이블 행 추가
    sessionLogs.forEach(function(session, index) {
        var row = tableBody.insertRow();
        var statusClass = session.status === "접속 중임" ? "status-connected" : "status-disconnected";
        row.className = statusClass;

        // ✅ disconnectTime 값이 없거나 "접속 중"이면 "-"로 출력
        var disconnectTimeDisplay = (!session.disconnectTime || session.disconnectTime === "접속 중") ? "-" : session.disconnectTime;

        row.innerHTML = `
            <td>${index + 1}</td>
            <td>${session.status}</td>
            <td>${session.sessionId}</td>
            <td>${session.connectTime}</td>
            <td>${disconnectTimeDisplay}</td>
        `;
    });

    // ✅ `N`, `A`, `B` 값 업데이트
    updateSessionStats();
}

//✅ 현재 테이블의 정보를 기반으로 `N`, `A`, `B` 값 계산
function updateSessionStats() {
 const totalRecords = document.querySelectorAll("#custom-user-list-table tbody tr").length;
 const activeCount = document.querySelectorAll("#custom-user-list-table tbody tr.status-connected").length;
 const disconnectedCount = document.querySelectorAll("#custom-user-list-table tbody tr.status-disconnected").length;

 // ✅ "세션 접속 정보" 제목 업데이트
 document.getElementById("session-title").innerText =
     `세션 접속 정보 | 총접속기록 ${totalRecords}개 | 현재 접속 중 ${activeCount} | 접속 종료 ${disconnectedCount}`;

 // ✅ "현재 접속 중" 정보 업데이트
 const userInfoElement = document.getElementById("userInfo");
 if (userInfoElement) {
     userInfoElement.innerHTML = `현재 접속 중: ${activeCount}명 | 접속 종료: ${disconnectedCount}명`;
 }
}

//✅ 모달 열기/닫기 기능
function openCustomModal() {
 document.getElementById("custom-user-list-modal").style.display = "block";
}

function closeCustomModal() {
 document.getElementById("custom-user-list-modal").style.display = "none";
}

//✅ WebSocket 초기화 실행
window.onload = function() {
 initWebSocket();
};


</script>

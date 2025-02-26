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
            <span id="userCount">Waiting for user count...</span>
                        <span id="active-users-count" style="display:none;">?</span>
            <button id="toggle-user-info" class="login-link" style="display:none;">로그인 후 확인</button>
            <%@ include file="./userList.jsp" %>
        </span>
        Copyright © 2025 All rights reserved.<div id="session-info"></div>
    </footer>

    <aside id="settingbar">
        <button class="play" id="backplay"><i class="fa-solid fa-volume-high"></i></button>
        <button class="play" id="play"><i class="fa-solid fa-sliders"></i></button>
        <button class="play" id="fowardplay"><i class="fa-solid fa-repeat"></i></button>
    </aside>
</section>

<!-- ✅ WebSocket 전역 관리 모듈 추가 -->
<script src="${pageContext.request.contextPath}/static/js/globalWebSocket.js"></script>

<script>

var userCountSocket;

function initUserCountWebSocket() {
    userCountSocket = new WebSocket("ws://localhost:8080/${pageContext.request.contextPath}/userCount");

    userCountSocket.onmessage = function(event) {
        let countData = event.data;
        
        // ✅ 숫자인 경우만 카운트 업데이트 (JSON 데이터가 들어오지 않도록 방지)
        if (!isNaN(countData)) {
            document.getElementById("userCount").innerText = "현재 접속자 수: " + countData;
        }
    };

    userCountSocket.onclose = function() {
        console.log("UserCount WebSocket closed");
    };

    userCountSocket.onerror = function(error) {
        console.log("UserCount WebSocket error: " + error);
    };
}

// ✅ 페이지 로드 시 userCount WebSocket 실행 (모달 관련 WebSocket 실행 X)
window.onload = function() {
    initUserCountWebSocket();
};

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

</script>

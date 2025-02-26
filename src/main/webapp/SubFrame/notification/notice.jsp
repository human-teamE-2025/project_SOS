<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/SubFrame/notification/notice.css">

<div id="popup">    
    <div id="popup-header">
        <span id="popup-title">알림</span>
        <button id="settings-btn">설정</button>
    </div>
    <ul id="nav-item"></ul>
</div>

<!-- ✅ WebSocket 전역 관리 모듈 추가 -->
<script src="${pageContext.request.contextPath}/static/js/globalWebSocket.js"></script>

<script>
document.addEventListener("DOMContentLoaded", function () {
    const userCountElement = document.getElementById("active-users-count");
    const navItem = document.getElementById("nav-item");

    let idCounter = 1;
    let lastNotification = "";

    // 알림 팝업 보이기/숨기기
    document.getElementById("b1").addEventListener("click", function () {
        document.getElementById("popup").classList.toggle("visible");
    });

    // 새로운 알림 추가 (중복 방지)
    function addListItem(message) {
        if (!message || message === lastNotification) return;
        lastNotification = message;

        const listItem = document.createElement("li");
        listItem.textContent = message;
        navItem.prepend(listItem);
        idCounter++;
    }

    // WebSocket 알림 처리
    function handleNotificationUpdate(event) {
        addListItem(event.detail.message);
    }

    // WebSocket 사용자 수 처리
    function updateActiveUsersCount(count, loggedIn) {
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

    // 로그인 성공
    function handleLoginSuccess() {
        sessionStorage.setItem("loggedIn", "true");
        window.globalWebSocketManager.sendUpdate();
        updateActiveUsersCount(1, true); // 서버에서 상태 확인
    }

    // 로그아웃 성공
    function handleLogoutSuccess() {
        sessionStorage.setItem("loggedIn", "false");
        window.globalWebSocketManager.sendUpdate();
        updateActiveUsersCount(0, false); // 서버에서 상태 확인
    }

    // 회원가입 성공
    function handleSignUpSuccess() {
        const userName = sessionStorage.getItem("userName") || "사용자";
        const signUpMessage = `🎉 ${userName}님이 회원가입을 완료하였습니다.`;
        document.dispatchEvent(new CustomEvent("updateNotification", { detail: { message: signUpMessage } }));
    }

    // 이벤트 리스너 설정
    document.removeEventListener("updateNotification", handleNotificationUpdate);
    document.addEventListener("updateNotification", handleNotificationUpdate);
    document.removeEventListener("updateActiveUsers", updateActiveUsersCount);
    document.addEventListener("updateActiveUsers", updateActiveUsersCount);
    document.removeEventListener("loginSuccess", handleLoginSuccess);
    document.addEventListener("loginSuccess", handleLoginSuccess);
    document.removeEventListener("logoutSuccess", handleLogoutSuccess);
    document.addEventListener("logoutSuccess", handleLogoutSuccess);
    document.removeEventListener("signUpSuccess", handleSignUpSuccess);
    document.addEventListener("signUpSuccess", handleSignUpSuccess);

    // 서버에서 로그인 상태 확인
    function checkLoginStatus() {
        fetch("${pageContext.request.contextPath}/SessionInfoServlet")
            .then(response => response.json())
            .then(data => {
                sessionStorage.setItem("loggedIn", data.loggedIn ? "true" : "false");
                updateActiveUsersCount(data.onlineUsers, data.loggedIn);
            })
            .catch(error => console.error("❌ 세션 정보 확인 실패:", error));
    }

    // 초기 실행 시 로그인 상태 확인
    checkLoginStatus();
});
</script>




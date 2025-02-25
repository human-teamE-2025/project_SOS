<%@ page language="java" contentType="text/html; charset=UTF-8"%>
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
document.addEventListener("DOMContentLoaded", function() {
    const button = document.getElementById("b1");
    const popup = document.getElementById("popup");
    const navItem = document.getElementById("nav-item");

    let idCounter = 1; // ID 카운터 초기화
    let lastNotification = ""; // 마지막 알림 메시지 저장

    /** ✅ 알림 팝업 보이기/숨기기 */
    button.addEventListener("click", function() {
        popup.classList.toggle("visible");
    });

    /** ✅ 리스트 아이템 삭제 기능 추가 */
    function addDeleteEvent(icon) {
        icon.addEventListener("click", function(event) {
            event.target.closest("li").remove();
        });
    }

    /** ✅ 새로운 알림 추가 (중복 방지) */
    function addListItem(message) {
        if (!message) {
            message = "새로운 알림이 도착했습니다!";
        }
        if (message === lastNotification) {
            console.warn("⚠️ 중복 알림 감지, 추가하지 않음:", message);
            return;
        }
        lastNotification = message; // 마지막 메시지 업데이트

        const listItem = document.createElement("li");
        listItem.setAttribute("data-id", idCounter);

        const itemContent = document.createElement("div");
        itemContent.classList.add("item-content");

        const img = document.createElement("img");
        img.src = "${pageContext.request.contextPath}/static/img/fav.ico";
        img.alt = "icon";

        const text = document.createElement("span");
        text.textContent = message;

        const buttonContent = document.createElement("div");
        buttonContent.classList.add("button-content");

        const deleteIcon = document.createElement("i");
        deleteIcon.classList.add("fa-solid", "fa-xmark", "delete-icon");

        addDeleteEvent(deleteIcon);

        // ✅ 요소 조립
        itemContent.appendChild(img);
        itemContent.appendChild(text);
        buttonContent.appendChild(deleteIcon);

        listItem.appendChild(itemContent);
        listItem.appendChild(buttonContent);

        navItem.prepend(listItem);
        idCounter++;
    }

    /** ✅ WebSocket을 통한 알림 추가 */
    function handleNotificationUpdate(event) {
        console.log("🔔 새로운 알림 추가:", event.detail.message);
        addListItem(event.detail.message);
    }

    /** ✅ WebSocket을 통한 사용자 수 업데이트 */
    function handleActiveUsersUpdate(event) {
        console.log("📢 WebSocket에서 접속자 정보 업데이트 이벤트 수신:", event.detail.count);
        const loggedIn = sessionStorage.getItem("loggedIn") === "true";
        updateActiveUsersCount(event.detail.count, loggedIn);
    }

    function updateActiveUsersCount(count, loggedIn) {
        const userCountElement = document.getElementById("active-users-count");
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

    /** ✅ 로그인 성공 이벤트 */
    function handleLoginSuccess() {
        sessionStorage.setItem("loggedIn", "true");
        window.globalWebSocketManager.sendUpdate();
        console.log("🔄 로그인 UI 업데이트 실행");

        // ✅ 로그인 후 즉시 알림 추가
        const userName = sessionStorage.getItem("userName") || "사용자";
        const loginMessage = `✅ ${userName}님이 로그인하였습니다.`;
        document.dispatchEvent(new CustomEvent("updateNotification", { detail: { message: loginMessage } }));
    }

    /** ✅ 로그아웃 성공 이벤트 */
    function handleLogoutSuccess() {
        sessionStorage.setItem("loggedIn", "false");
        window.globalWebSocketManager.sendUpdate();
        console.log("🔄 로그아웃 UI 업데이트 실행");

        // ✅ 로그아웃 후 즉시 알림 추가
        const userName = sessionStorage.getItem("userName") || "사용자";
        const logoutMessage = `❌ ${userName}님이 로그아웃하였습니다.`;
        document.dispatchEvent(new CustomEvent("updateNotification", { detail: { message: logoutMessage } }));
    }

    /** ✅ 이벤트 리스너 중복 제거 후 재등록 */
    document.removeEventListener("updateNotification", handleNotificationUpdate);
    document.addEventListener("updateNotification", handleNotificationUpdate);

    document.removeEventListener("updateActiveUsers", handleActiveUsersUpdate);
    document.addEventListener("updateActiveUsers", handleActiveUsersUpdate);

    document.removeEventListener("loginSuccess", handleLoginSuccess);
    document.addEventListener("loginSuccess", handleLoginSuccess);

    document.removeEventListener("logoutSuccess", handleLogoutSuccess);
    document.addEventListener("logoutSuccess", handleLogoutSuccess);
});
</script>

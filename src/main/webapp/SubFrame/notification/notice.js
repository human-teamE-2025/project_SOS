document.addEventListener("DOMContentLoaded", function () {
    const userCountElement = document.getElementById("active-users-count");
    
    /** ✅ 전역 알림 추가 함수 (중복 실행 방지) */
    if (!window.addNotification) {
        window.addNotification = function (message) {
            console.log("🔔 새로운 알림 추가:", message);
            const navItem = document.getElementById("nav-item");
            if (!navItem) {
                console.error("❌ 알림 리스트(nav-item)를 찾을 수 없음.");
                return;
            }
            const listItem = document.createElement("li");
            listItem.textContent = message;
            navItem.prepend(listItem);
        };
    }

    /** ✅ 실시간 접속자 수 업데이트 */
    if (!window.updateActiveUsersCount) {
        window.updateActiveUsersCount = function (count, loggedIn) {
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
        };
    }

    /** ✅ WebSocket 이벤트 핸들러 정의 */
    function handleNotificationUpdate(event) {
        window.addNotification(event.detail.message);
    }

    function handleActiveUsersUpdate(event) {
        window.updateActiveUsersCount(event.detail.count, event.detail.loggedIn);
    }

    function handleLoginSuccess() {
        console.log("🔄 로그인 UI 업데이트 실행");
        sessionStorage.setItem("loggedIn", "true");
        window.globalWebSocketManager.sendUpdate();
        checkLoginStatus(); // ✅ 서버에서 로그인 상태 확인
    }

    function handleLogoutSuccess() {
        console.log("🔄 로그아웃 UI 업데이트 실행");
        sessionStorage.setItem("loggedIn", "false");
        window.globalWebSocketManager.sendUpdate();
        checkLoginStatus(); // ✅ 서버에서 로그인 상태 확인
    }

    /** ✅ WebSocket 이벤트 리스너 설정 (중복 방지) */
    document.removeEventListener("updateNotification", handleNotificationUpdate);
    document.addEventListener("updateNotification", handleNotificationUpdate);

    document.removeEventListener("updateActiveUsers", handleActiveUsersUpdate);
    document.addEventListener("updateActiveUsers", handleActiveUsersUpdate);

    document.removeEventListener("loginSuccess", handleLoginSuccess);
    document.addEventListener("loginSuccess", handleLoginSuccess);

    document.removeEventListener("logoutSuccess", handleLogoutSuccess);
    document.addEventListener("logoutSuccess", handleLogoutSuccess);

    /** ✅ 서버에서 로그인 상태 확인 */
    function checkLoginStatus() {
        fetch("/E_web/SessionInfoServlet")
            .then(response => response.json())
            .then(data => {
                if (data.loggedIn) {
                    sessionStorage.setItem("loggedIn", "true");
                    window.updateActiveUsersCount(data.onlineUsers, true);
                } else {
                    sessionStorage.setItem("loggedIn", "false");
                    window.updateActiveUsersCount(0, false);
                }
            })
            .catch(error => console.error("❌ 세션 정보 확인 실패:", error));
    }

    // ✅ 초기 실행 시 로그인 상태 확인
    checkLoginStatus();
});

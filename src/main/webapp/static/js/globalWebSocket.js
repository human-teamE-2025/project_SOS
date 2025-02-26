window.globalWebSocketManager = (function () {

    let socket = null;
    let isConnected = false;
    let connectAttempts = 0;
    const MAX_RECONNECT_ATTEMPTS = 5;

    function connectWebSocket() {
        if (socket && socket.readyState === WebSocket.OPEN) {
            console.warn("⚠️ WebSocket이 이미 연결되어 있음.");
            return;
        }

        if (connectAttempts >= MAX_RECONNECT_ATTEMPTS) {
            console.error("🚨 WebSocket 재연결 시도 초과. 연결 중단.");
            return;
        }

        connectAttempts++;
        console.log("🔄 WebSocket 연결 시도 (시도 횟수:", connectAttempts, ")");

        if (socket) {
            socket.close();
        }

        socket = new WebSocket("ws://" + window.location.host + "/E_web/notifications");

        socket.onopen = function () {
            console.log("✅ WebSocket 연결 성공: 알림 시스템");
            isConnected = true;
            connectAttempts = 0;
            sendUpdate();
        };

        socket.onmessage = function (event) {
            try {
                const notificationData = JSON.parse(event.data);

                if (notificationData.type === "notification") {
                    console.log("🔔 새로운 알림:", notificationData.message);
                    if (typeof window.addNotification === "function") {
                        window.addNotification(notificationData.message); // 알림 추가
                    } else {
                        console.warn("⚠️ `addNotification` 함수가 아직 정의되지 않음.");
                    }
                    const notificationEvent = new CustomEvent("updateNotification", {
                        detail: { message: notificationData.message }
                    });
                    document.dispatchEvent(notificationEvent);
                } else if (notificationData.type === "activeUsers") {
                    console.log("👥 현재 접속자 수 업데이트:", notificationData.count);
                    if (typeof window.updateActiveUsersCount === "function") {
                        window.updateActiveUsersCount(notificationData.count, true);
                    } else {
                        console.warn("⚠️ `updateActiveUsersCount` 함수가 아직 정의되지 않음.");
                    }

                    if (prevActiveUsers !== notificationData.count) {
                        prevActiveUsers = notificationData.count;
                        const userEvent = new CustomEvent("updateActiveUsers", {
                            detail: { count: notificationData.count }
                        });
                        document.dispatchEvent(userEvent);
                    }
                }
            } catch (error) {
                console.error("🚨 WebSocket JSON 파싱 오류:", error);
            }
        };

        socket.onerror = function (error) {
            console.error("⚠️ WebSocket 오류 발생:", error);
        };

        socket.onclose = function () {
            console.warn("❌ WebSocket 연결 종료됨. 5초 후 재연결 시도...");
            isConnected = false;
            setTimeout(connectWebSocket, 5000);
        };
    }

    // `addNotification` 함수 정의 (알림을 추가하는 함수)
    window.addNotification = function (message) {
        const navItem = document.getElementById("nav-item");
        if (!navItem) {
            console.error("❌ 알림 리스트(nav-item)를 찾을 수 없음.");
            return;
        }
        const listItem = document.createElement("li");
        listItem.textContent = message;
        navItem.prepend(listItem); // 알림을 리스트에 추가
    };

    function sendUpdate() {
        if (isConnected && socket.readyState === WebSocket.OPEN) {
            console.log("📡 WebSocket 상태 확인 후 `update` 요청 실행!");
            socket.send("update");
        } else {
            console.warn("⚠️ WebSocket이 아직 연결되지 않음. `update` 요청 대기 중...");
            setTimeout(sendUpdate, 500);
        }
    }

    // 로그인 성공 시
    function handleLoginSuccess() {
        if (sessionStorage.getItem("loggedIn") !== "true") {
            sessionStorage.setItem("loggedIn", "true");
            sendUpdate();
            console.log("🔄 로그인 후 WebSocket 업데이트 요청 전송");

            document.dispatchEvent(new CustomEvent("updateActiveUsers", { detail: { count: prevActiveUsers || 1 } }));
        }
    }

    // 로그아웃 성공 시
    function handleLogoutSuccess() {
        if (sessionStorage.getItem("loggedIn") !== "false") {
            sessionStorage.clear();
            sendUpdate();
            console.log("🔄 로그아웃 후 WebSocket 업데이트 요청 전송");

            setTimeout(() => {
                document.dispatchEvent(new CustomEvent("updateActiveUsers", { detail: { count: 0 } }));
            }, 500);
        }
    }

    // 세션 상태 체크
    function checkSessionStatus() {
        fetch("/E_web/LoginServlet", {
            method: "GET",
            credentials: "include"
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === "loggedIn") {
                sessionStorage.setItem("loggedIn", "true");
                sessionStorage.setItem("userId", data.userId);
                sessionStorage.setItem("userName", data.userName);
                sessionStorage.setItem("userEmail", data.userEmail);
                sessionStorage.setItem("loginTime", data.loginTime);
                console.log("🔄 서버에서 로그인 상태 확인 → WebSocket 업데이트 실행");
                sendUpdate();
            } else {
                sessionStorage.clear();
                console.log("❌ 서버에서 로그인 만료 감지 → `sessionStorage` 초기화");
            }
        })
        .catch(error => {
            console.error("⚠️ 로그인 상태 확인 중 오류 발생:", error);
        });
    }

    document.removeEventListener("loginSuccess", handleLoginSuccess);
    document.addEventListener("loginSuccess", handleLoginSuccess);

    document.removeEventListener("logoutSuccess", handleLogoutSuccess);
    document.addEventListener("logoutSuccess", handleLogoutSuccess);

    return {
        connect: connectWebSocket,
        sendUpdate: sendUpdate,
        isReady: () => isConnected,
    };
})();

window.globalWebSocketManager.connect();

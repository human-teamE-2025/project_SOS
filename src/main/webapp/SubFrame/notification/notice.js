document.addEventListener("DOMContentLoaded", function () {
    const popup = document.getElementById("popup");
    const navItem = document.getElementById("nav-item");
    const userCountElement = document.getElementById("active-users-count");

    let socket; // WebSocket 객체

    /** ✅ 웹소켓 연결 함수 */
    function connectWebSocket() {
        socket = new WebSocket("ws://" + window.location.host + "/E_web/notifications");

        socket.onopen = function () {
            console.log("✅ WebSocket 연결 성공: 알림 시스템");
            socket.send("update"); // ✅ 접속하자마자 최신 접속자 정보 요청
        };

		socket.onmessage = function (event) {
		    console.log("📩 WebSocket 메시지 수신:", event.data);

		    try {
		        // JSON이 아닌 경우를 감지하고 무시
		        if (event.data === "update") return;

		        const notificationData = JSON.parse(event.data);

		        if (notificationData.type === "activeUsers") {
		            updateActiveUsersCount(notificationData.count, notificationData.loggedIn);
		        } else if (notificationData.type === "notification") {
		            addNotification(notificationData.message);
		        }
		    } catch (error) {
		        console.error("🚨 WebSocket JSON 파싱 오류:", error);
		    }
		};

        socket.onclose = function () {
            console.log("❌ WebSocket 연결 종료됨. 재연결 시도 중...");
            setTimeout(connectWebSocket, 3000); // 3초 후 재연결
        };

        socket.onerror = function (error) {
            console.error("⚠️ WebSocket 오류 발생:", error);
        };
    }

    /** ✅ 새로운 알림 추가 함수 */
    function addNotification(message) {
        const listItem = document.createElement("li");
        listItem.textContent = message;
        navItem.prepend(listItem);
    }

    /** ✅ 실시간 접속자 수 업데이트 */
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

    /** ✅ 로그인 시 WebSocket에 업데이트 요청 */
    document.addEventListener("loginSuccess", function () {
        if (socket && socket.readyState === WebSocket.OPEN) {
            socket.send("update"); // ✅ 로그인 성공 후 서버에 업데이트 요청
        }
    });

    /** ✅ 로그아웃 시 WebSocket에 업데이트 요청 */
    document.addEventListener("logoutSuccess", function () {
        if (socket && socket.readyState === WebSocket.OPEN) {
            socket.send("update"); // ✅ 로그아웃 후 서버에 업데이트 요청
        }
    });

    /** ✅ 웹소켓 연결 실행 */
    connectWebSocket();
});

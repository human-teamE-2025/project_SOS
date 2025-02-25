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
            <span id="active-users-count">?</span>
            <button id="toggle-user-info" class="login-link">로그인 후 확인</button>
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
<div id="user-list-modal" class="modal">
    <div class="modal-content">
        <span class="close-btn">&times;</span>
        <h2>현재 접속자</h2>
        <table id="user-list-table">
            <thead>
                <tr>
                    <th>사용자 ID</th>
                    <th>이름</th>
                    <th>이메일</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
    </div>
</div>

<script>
$(document).ready(function () {
    let socket;
    let wsUrl = "ws://" + window.location.host + "/E_web/activeUsers";

    /** ✅ 실시간 접속자 수 업데이트 함수 추가 */
    function updateUserStatus(count, loggedIn) {
        const userCountElement = document.getElementById("active-users-count");

        if (loggedIn) {
            userCountElement.textContent = count + "명";
            userCountElement.style.color = "black";
        } else {
            userCountElement.textContent = "로그인 후 확인";
            userCountElement.style.color = "blue";
        }
    }

    /** ✅ 웹소켓 연결 및 데이터 실시간 반영 */
    function connectWebSocket() {
        socket = new WebSocket(wsUrl);

        socket.onopen = function () {
            console.log("✅ WebSocket 연결 성공:", wsUrl);
            socket.send("update"); // 접속하자마자 서버에 접속자 수 요청
        };

        socket.onmessage = function (event) {
            console.log("📩 WebSocket 메시지 수신:", event.data);

            try {
                if (event.data.trim() === "update") {
                    console.log("🔄 서버에서 접속자 수 업데이트 요청 수신.");
                    return;
                }

                const notificationData = JSON.parse(event.data);
                
                if (notificationData.type === "activeUsers") {
                    updateUserStatus(notificationData.count, notificationData.loggedIn);
                } else if (notificationData.type === "notification") {
                    addNotification(notificationData.message);
                }
            } catch (error) {
                console.error("🚨 WebSocket JSON 파싱 오류:", error, "데이터:", event.data);
            }
        };

        socket.onclose = function () {
            console.log("❌ WebSocket 연결 종료됨. 5초 후 재연결 시도...");
            setTimeout(connectWebSocket, 5000);
        };

        socket.onerror = function (error) {
            console.error("⚠️ WebSocket 오류 발생:", error);
        };
    }

    /** ✅ 페이지 최초 로드 시 로그인 여부 확인 */
    function checkLoginStatus() {
        $.ajax({
            url: "/E_web/SessionInfoServlet",
            type: "GET",
            dataType: "json",
            success: function (data) {
                if (data.loggedIn) {
                    updateLoginUI(data.userName, data.loginTime);
                    loadLogoutPopup();
                    updateUserStatus(data.onlineUsers, true); // ✅ 로그인한 경우
                } else {
                    resetLoginUI();
                    updateUserStatus(0, false); // ✅ 로그아웃한 경우 "로그인 후 확인" 표시
                }
            },
            error: function () {
                console.error("❌ 세션 정보 가져오기 실패");
            }
        });
    }

    /** ✅ 페이지 최초 로드 시 실행 */
    checkLoginStatus();
    connectWebSocket();

    /** ✅ 버튼 클릭 이벤트 (로그인 모달 or 접속자 리스트) */
    $("#toggle-user-info").click(function () {
        if ($(this).hasClass("login-link")) {
            $.ajax({
                url: "SubFrame/Modal/Login.jsp",
                type: "GET",
                dataType: "html",
                success: function (data) {
                    if ($("#login-modal").length === 0) {
                        $("body").append(data);
                    }
                    $("#login-modal").fadeIn(100);

                    // ✅ 로그인 성공 시 UI 즉시 업데이트
                    $(document).on("loginSuccess", function () {
                        updateUserStatus(data.onlineUsers, true);
                    });
                },
                error: function (xhr, status, error) {
                    console.error("모달을 불러오는 중 오류 발생:", error);
                }
            });
        } else {
            $("#user-list-modal").fadeToggle(100);
            $.ajax({
                url: "${pageContext.request.contextPath}/SessionInfoServlet",
                type: "GET",
                dataType: "json",
                success: function (data) {
                    let tbody = $("#user-list-table tbody").empty();
                    if (data.loggedInUsers) {
                        data.loggedInUsers.forEach(user => {
                            tbody.append(`<tr>
                                <td>${user.userId}</td>
                                <td>${user.userName}</td>
                                <td>${user.userEmail}</td>
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

    /** ✅ 로그아웃 성공 이벤트 */
    $(document).on("logoutSuccess", function () {
        updateUserStatus(0, false);
    });

    $(".close-btn").click(function () {
        $("#user-list-modal").fadeOut(100);
    });
});
</script>


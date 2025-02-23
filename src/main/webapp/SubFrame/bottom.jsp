<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bottom.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
var socket = new WebSocket("ws://" + window.location.host + "/E_web/activeUsers");

socket.onmessage = function(event) {
    $("#active-users-count").text(event.data);
};

socket.onclose = function(event) {
    console.warn("WebSocket closed: ", event);
};
</script>
<section id="bottom">
    <aside id="musicbar">
        <button class="play" id="backplay"><i class="fa-solid fa-backward"></i></button>
        <button class="play" id="play"><i class="fa-solid fa-play"></i></button>
        <button class="play" id="fowardplay"><i class="fa-solid fa-forward"></i></button>
    </aside>

    <footer>
    	<span>현재 접속자: <span id="active-users-count">0</span>명</span>&emsp;|&emsp;
        <a href="${pageContext.request.contextPath}/about.jsp?section=company">회사소개</a>&emsp;|&emsp;
        <a href="${pageContext.request.contextPath}/about.jsp?section=terms">이용약관</a>&emsp;|&emsp;
        <a href="${pageContext.request.contextPath}/about.jsp?section=privacy">개인정보처리방침</a>&emsp;
        Copyright © 2025 All rights reserved.&emsp;
        <div id="session-info">
            <span style="display:none;">👥 현재 접속자: <span id="online-users" >0</span>명</span>
            <span>|&emsp;⏳ 세션 만료까지: <span id="session-timer">-</span></span>
        </div>
    </footer>

    <aside id="settingbar">
        <button class="play" id="backplay"><i class="fa-solid fa-volume-high"></i></button>
        <button class="play" id="play"><i class="fa-solid fa-sliders"></i></button>
        <button class="play" id="fowardplay"><i class="fa-solid fa-repeat"></i></button>
    </aside>
</section>

<script>
$(document).ready(function () {
    // ✅ 세션 남은 시간 카운트다운
    function startSessionTimer(expireTime) {
        function updateTimer() {
            let now = new Date().getTime();
            let timeLeft = expireTime - now;

            if (timeLeft <= 0) {
                $("#session-timer").text("세션 종료됨");
                clearInterval(timer);
            } else {
                let minutes = Math.floor(timeLeft / (1000 * 60));
                let seconds = Math.floor((timeLeft % (1000 * 60)) / 1000);
                $("#session-timer").text(`${minutes}분 ${seconds}초`);
            }
        }

        let timer = setInterval(updateTimer, 1000);
        updateTimer(); // 즉시 실행
    }

    // ✅ 로그인한 경우 서버에서 세션 만료 시간 & 접속자 수 가져오기
    $.ajax({
        url: "${pageContext.request.contextPath}/SessionInfoServlet",
        type: "GET",
        dataType: "json",
        success: function (data) {
            if (data.loggedIn) {
                startSessionTimer(data.sessionExpireTime);
                $("#online-users").text(data.onlineUsers);
            }
        },
        error: function () {
            console.error("❌ 세션 정보 가져오기 실패");
        }
    });
});
</script>

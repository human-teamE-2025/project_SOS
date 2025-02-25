<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat, java.util.Date" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/Logout.css">

<%
    HttpSession sessionObj = request.getSession();
    String nickname = (String) sessionObj.getAttribute("userName");
    String loginTime = (String) sessionObj.getAttribute("loginTime");

    if (nickname == null) {
        nickname = "사용자";
    }
    if (loginTime == null) {
        loginTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
        sessionObj.setAttribute("loginTime", loginTime);
    }
%>

<div id="user-popup" class="user-popup">
    <p><strong id="user-name"><%= nickname %></strong>님, 환영합니다!</p>
    <p class="login-time">🕒 로그인 시간: <span id="login-time"><%= loginTime %></span></p>
    <button id="logout-btn">로그아웃</button>
</div>

<script>
$(document).ready(function() {
    let wsUrl = "ws://" + window.location.host + "/E_web/activeUsers";
    let socket = new WebSocket(wsUrl);

    socket.onopen = function () {
        console.log("✅ WebSocket 연결 성공:", wsUrl);
        socket.send("update");
    };

    socket.onmessage = function (event) {
        console.log("📩 현재 접속중인 유저:", event.data);
    };

    socket.onclose = function () {
        console.log("❌ WebSocket 연결 종료");
    };

    socket.onerror = function (error) {
        console.error("⚠️ WebSocket 오류 발생:", error);
    };

    // 동적으로 로드된 로그아웃 버튼에 대해 이벤트 위임 방식으로 바인딩
    $("#b2").click(function() {
        if ($("#user-popup").hasClass("show")) {
            $("#user-popup").removeClass("show").addClass("hide");
            setTimeout(() => { $("#user-popup").hide(); }, 200); // 애니메이션 후 숨김 처리
        } else {
            $("#user-popup").removeClass("hide").addClass("show").show();
        }
    });

    // 다른 곳을 클릭하면 팝업 닫기
    $(document).click(function(event) {
        if (!$(event.target).closest("#user-popup, #b2").length) {
            $("#user-popup").removeClass("show").addClass("hide");
            setTimeout(() => { $("#user-popup").hide(); }, 200);
        }
    });

    // ✅ 로그아웃 버튼 클릭 이벤트
    $("#logout-btn").click(function() {
        $.ajax({
            url: "/E_web/LogoutServlet",
            type: "POST",
            dataType: "json",
            success: function(response) {
                if (response.status === "success") {
                    sessionStorage.clear();
                    $("#b2 i").removeClass("fa-circle-user").addClass("fa-sign-in-alt");
                    $("#user-popup").remove();
                    socket.send("update"); // ✅ 로그아웃 후 접속자 수 갱신
                }
            },
            error: function() {
                alert("❌ 로그아웃 실패!");
            }
        });
    });

    
    });
</script>

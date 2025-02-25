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
    // ✅ 로그아웃 버튼 클릭 이벤트
    $("#logout-btn").click(function() {
        $.ajax({
            url: "/E_web/LogoutServlet",
            type: "POST",
            dataType: "json",
            success: function(response) {
                if (response.status === "success") {
                    console.log("✅ 로그아웃 성공!");
                    
                    // ✅ 세션 초기화
                    sessionStorage.clear();

                    // ✅ UI 초기화 (전역 함수 호출)
                    if (typeof window.updateLoginUI === "function") {
                        window.updateLoginUI(null, null);
                    } else {
                        console.warn("⚠ `updateLoginUI` 함수가 정의되지 않음.");
                    }

                    // ✅ WebSocket 업데이트 요청
                    if (window.globalWebSocketManager && window.globalWebSocketManager.isReady()) {
                        window.globalWebSocketManager.sendUpdate();
                    }

                    // ✅ `logoutSuccess` 이벤트 트리거 (헤더 및 푸터 동기화)
                    document.dispatchEvent(new Event("logoutSuccess"));

                    // ✅ 로그아웃 후 팝업 제거
                    $("#user-popup").fadeOut(100, function() {
                        $(this).remove();
                    });
                } else {
                    alert(response.message || "❌ 로그아웃 실패!");
                }
            },
            error: function() {
                alert("❌ 로그아웃 실패!");
            }
        });
    });

    // ✅ 팝업 표시/숨기기
    $("#b2").click(function() {
        $("#user-popup").fadeToggle(100);
    });

    // ✅ 다른 곳 클릭 시 팝업 닫기
    $(document).click(function(event) {
        if (!$(event.target).closest("#user-popup, #b2").length) {
            $("#user-popup").fadeOut(100);
        }
    });
});
</script>

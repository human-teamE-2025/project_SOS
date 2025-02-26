<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/header.css">

<header>
    <div id="left-header">
        <button class="menu"><i class="fa-solid fa-bars"></i></button>
        <div id="titles">
            <button class="logo-btn logo" onclick="window.location.href='${pageContext.request.contextPath}/index.jsp';"></button>
            <h1 id="title" onclick="window.location.href='${pageContext.request.contextPath}/index.jsp';">Song of Senses</h1>
        </div>
    </div>

    <div id="right-header">
        <div class="search-container">
            <input id="search" type="text" placeholder="Search...">
            <button class="search-submit"><i class="fa-solid fa-magnifying-glass"></i></button>
        </div>

        <div class="nav-button">
            <button id="b1"><i class="fa-solid fa-bell"></i></button>
            <button id="b2"><i class="fas fa-sign-in-alt"></i></button>
        </div>
    </div>
</header>

<!-- ✅ WebSocket 전역 관리 모듈 추가 -->
<script src="${pageContext.request.contextPath}/static/js/globalWebSocket.js"></script>

<script>

$(document).ready(function () {
    const userCountElement = document.getElementById("active-users-count");

    /** ✅ 로그인 UI 업데이트 함수 (전역) */
    window.updateLoginUI = function (userName, loginTime) {
        console.log("✅ 로그인 UI 업데이트: ", userName, loginTime);
        $("#b2 i").removeClass("fas fa-sign-in-alt").addClass("fa-solid fa-circle-user");

        if ($("#user-popup").length === 0) {
            loadLogoutPopup();
        }
    };

    /** ✅ 로그아웃 UI 초기화 */
function resetLoginUI() {
    console.log("🔄 로그아웃 UI 초기화");
    $("#b2 i").removeClass("fa-solid fa-circle-user").addClass("fas fa-sign-in-alt");
    sessionStorage.clear();  // sessionStorage 초기화
}

    /** ✅ 로그인 상태 확인 */
function checkLoginStatus() {
    $.ajax({
        url: "${pageContext.request.contextPath}/LoginServlet", // 로그인 상태 확인하는 서블릿
        type: "GET",
        dataType: "json",
        success: function (data) {
            if (data.status === "loggedIn") {
                sessionStorage.setItem("loggedIn", "true");
                sessionStorage.setItem("userName", data.userName);
                updateLoginUI(data.userName, data.loginTime);
            } else {
                sessionStorage.setItem("loggedIn", "false");
                resetLoginUI();
            }
        },
        error: function () {
            console.error("❌ 세션 정보 가져오기 실패");
            // 세션 만료 처리: 세션이 만료된 경우 UI 초기화
            sessionStorage.setItem("loggedIn", "false");
            resetLoginUI();
        },
    });
}


    /** ✅ 로그인/로그아웃 버튼 클릭 이벤트 */
    $("#b2").off("click").on("click", function (event) {
        event.preventDefault();
        let isLoggedIn = sessionStorage.getItem("loggedIn") === "true";

        if (isLoggedIn) {
            if ($("#user-popup").length === 0) {
                loadLogoutPopup();
            } else {
                $("#user-popup").fadeToggle(100);
            }
        } else {
            if ($("#login-modal").length === 0) {
                loadLoginModal();
            } else {
                $("#login-modal").fadeIn(100);
            }
        }
    });

    /** ✅ 로그아웃 팝업 로드 */
    function loadLogoutPopup() {
        $.ajax({
            url: "${pageContext.request.contextPath}/SubFrame/Modal/Logout.jsp",
            type: "GET",
            dataType: "html",
            success: function (data) {
                $("#user-popup").remove();
                $("body").append(data);
                $("#user-popup").fadeIn(100);
            },
        });
    }

    /** ✅ 로그인 모달 로드 */
    function loadLoginModal() {
        $.ajax({
            url: "${pageContext.request.contextPath}/SubFrame/Modal/Login.jsp",
            type: "GET",
            dataType: "html",
            success: function (data) {
                $("body").append(data);
                $("#login-modal").fadeIn(100);
            },
        });
    }

    /** ✅ 로그인/로그아웃 이벤트 리스너 */
    document.addEventListener("loginSuccess", function () {
        sessionStorage.setItem("loggedIn", "true");
        updateLoginUI(sessionStorage.getItem("userName") || "사용자", new Date().toLocaleTimeString());
        console.log("🔄 로그인 UI 업데이트 실행");

        // ✅ WebSocket 업데이트 요청
        if (window.globalWebSocketManager && window.globalWebSocketManager.isReady()) {
            window.globalWebSocketManager.sendUpdate();
        }
    });

    document.addEventListener("logoutSuccess", function () {
        sessionStorage.setItem("loggedIn", "false");
        resetLoginUI();
        console.log("🔄 로그아웃 UI 업데이트 실행");

        // WebSocket 업데이트 요청
        if (window.globalWebSocketManager && window.globalWebSocketManager.isReady()) {
            window.globalWebSocketManager.sendUpdate();
        }

        // 새로고침하여 세션 만료 후 로그인 전 상태로 되돌리기
         // 로그아웃 후 페이지 새로고침
    });


    /** ✅ 초기 실행 */
    checkLoginStatus();
});
</script>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

<script>
$(document).ready(function() {
    window.resetLoginUI = function() {
        console.log("🔄 로그인 UI 초기화");
        $("#b2 i").removeClass("fa-solid fa-circle-user").addClass("fas fa-sign-in-alt");
        sessionStorage.clear();
        $("#user-popup").fadeOut(100, function() {
            $(this).remove();
        });
    };
    checkLoginStatus();
    
    initWebSocket();
   

    
    window.checkLoginStatus = function() {
        $.ajax({
            url: "/E_web/SessionInfoServlet",
            type: "GET",
            dataType: "json",
            success: function(data) {
                if (data.loggedIn) {
                    window.updateLoginUI(data.userName, data.loginTime); // ✅ 전역 함수 호출
                    window.loadLogoutPopup(); // ✅ 전역 함수 호출
                } else {
                    window.resetLoginUI(); // ✅ 전역 함수 호출
                }
            },
            error: function() {
                console.error("❌ 세션 정보 가져오기 실패");
            }
        });
    };

    /** ✅ 로그인 UI 업데이트 (전역 등록) */
    window.updateLoginUI = function(userName, loginTime) {
        console.log("✅ 로그인 UI 업데이트: ", userName, loginTime);
        $("#b2 i").removeClass("fas fa-sign-in-alt").addClass("fa-solid fa-circle-user");

        if ($("#user-popup").length === 0) {
            loadLogoutPopup();
        }
    };

    /** ✅ 로그인 UI 초기화 (전역 등록) */



$("#b2").click(function() {
    let isLoggedIn = sessionStorage.getItem("loggedIn") === "true";

    if (isLoggedIn) {
        if ($("#user-popup").length === 0) {
            loadLogoutPopup();
        } else {
            $("#user-popup").fadeToggle(100);
        }
    } else {
        loadLoginModal();
    }
});


    function loadLogoutPopup() {
        $.ajax({
            url: "/E_web/SubFrame/Modal/Logout.jsp",
            type: "GET",
            dataType: "html",
            success: function(data) {
                $("#user-popup").remove();
                $("body").append(data);
                $("#user-popup").fadeIn(100);
            },
            error: function(xhr, status, error) {
                console.error("로그아웃 팝업 로드 오류:", error);
            }
        });
    }

    function loadLoginModal() {
        $.ajax({
            url: "SubFrame/Modal/Login.jsp",
            type: "GET",
            dataType: "html",
            success: function(data) {
                if ($("#login-modal").length === 0) {
                    $("body").append(data);
                }
                $("#login-modal").fadeIn();
            },
            error: function(xhr, status, error) {
                console.error("로그인 모달 로드 오류:", error);
            }
        });
    }

    function initWebSocket() {
    	let socket = new WebSocket("ws://" + window.location.host + "/E_web/activeUsers");

    	socket.onopen = function () {
    	    socket.send("update"); // ✅ 접속하자마자 최신 접속자 정보 요청
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

        socket.onerror = function (error) {
            console.error("⚠️ WebSocket 오류 발생:", error);
        };
    

    function updateUserStatus(count, loggedIn) {
        console.log("✅ 사용자 상태 업데이트:", count, loggedIn);
        const userStatusElement = document.getElementById("active-users-count");

        if (loggedIn) {
            userStatusElement.textContent = count + "명";
            userStatusElement.style.color = "black";
        } else {
            userStatusElement.textContent = "로그인 후 확인";
            userStatusElement.style.color = "blue";
        }
    }
}
    }
</script>

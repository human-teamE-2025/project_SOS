<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/SingIn.css">

<script>
    var contextPath = "<%= request.getContextPath() %>"; 
    console.log("🔍 현재 contextPath:", contextPath);
</script>

<div class="modal-overlay"></div>
<div class="modal" id="login-modal">
    <h1>Song of Senses<br>로그인</h1>
    <form id="login-form">
        <input type="email" id="login-email" placeholder="이메일 주소" class="email-input" required />
        <input type="password" id="login-password" placeholder="비밀번호" class="password-input" required />
        <p id="login-warning" class="password-warning hidden"></p>
        <button type="button" class="next-btn" id="login-button">로그인</button>
        <button type="button" class="next-btn" id="signup-link">회원가입</button>
    </form>

    <div class="separator"><span>또는</span></div>

    <div class="social-buttons">
        <button type="button" class="social-btn naver-btn" onclick="loginWith('naver')">N</button>
        <button type="button" class="social-btn kakao-btn" onclick="loginWith('kakao')">K</button>
        <button type="button" class="social-btn google-btn" onclick="loginWith('google')">G</button>
    </div>

    <p class="forgot-password"><a href="#">비밀번호를 잊으셨나요?</a></p>
</div>

<script>
$(document).ready(function() {
    $("#login-button").click(function(event) {
        event.preventDefault();
        const email = $("#login-email").val().trim();
        const password = $("#login-password").val().trim();

        if (email === "" || password === "") {
            showErrorMessage("⚠ 이메일과 비밀번호를 입력하세요.");
            return;
        }

        $.ajax({
            url: contextPath + "/LoginServlet",
            type: "POST",
            data: { email: email, password: password },
            success: function(response) {
                console.log("🔍 로그인 응답:", response);

                if (response.trim() === "success") {
                    alert("✅ 로그인 성공!");
                    
                    // ✅ 로그인 UI 변경
                    $("#b2 i").removeClass("fas fa-sign-in-alt").addClass("fa-solid fa-circle-user");
                    loadUserInfo();

                    $("#login-modal").fadeOut(200);
                } else {
                    showErrorMessage("❌ 이메일 또는 비밀번호가 일치하지 않습니다.");
                }
            },
            error: function(xhr, status, error) {
                console.error("🚨 AJAX 요청 오류:", status, error);
                showErrorMessage("❌ 서버 오류 발생. 다시 시도해주세요.");
            }
        });
    });

    $("#signup-link").click(function(event) {
        event.preventDefault();
        $.ajax({
            url: "SubFrame/Modal/SignIn_1.jsp",
            type: "GET",
            dataType: "html",
            success: function(data) {
                $("#login-modal").fadeOut(200, function() {
                    $("body").append(data);
                    $("#email-modal").fadeIn(200);
                });
            },
            error: function(xhr, status, error) {
                console.error("🚨 회원가입 모달 오류:", error);
            }
        });
    });

    function showErrorMessage(message) {
        $("#login-warning").text(message).removeClass("hidden");
    }

    function loadUserInfo() {
        $.ajax({
            url: "SubFrame/Modal/LoginSuccessPopup.jsp",
            type: "GET",
            success: function(data) {
                $("body").append(data);
            }
        });
    }
});

function loginWith(provider) {
    alert(provider + "로 로그인 시도");
}
</script>

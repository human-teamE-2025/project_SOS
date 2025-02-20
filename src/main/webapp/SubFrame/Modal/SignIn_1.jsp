<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/SignIn.css">

<div class="modal-overlay"></div>
<div class="modal" id="email-modal">
    <h1>Song of Senses</h1>
    <p>가입 이후<br>다양한 컨텐츠와 음악을<br>감상하세요</p>

    <form id="email-form">
        <input type="email" id="email-input" placeholder="이메일 주소" class="email-input" required />
        <p id="email-warning" class="password-warning hidden"></p> <!-- 중복 체크 메시지 -->

        <div class="separator">
            <span>또는</span>
        </div>

        <div class="social-buttons">
            <button type="button" class="social-btn naver-btn">N</button>
            <button type="button" class="social-btn kakao-btn">K</button>
            <button type="button" class="social-btn google-btn">G</button>
        </div>

        <button type="button" class="next-btn" id="next-btn">다음</button>
    </form>
</div>

<script>
$(document).ready(function() {
    var contextPath = "<%= request.getContextPath() %>";
    
    $("#next-btn").click(function(event) {
        event.preventDefault();
        var email = $("#email-input").val().trim();
        var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

        if (email === "" || !emailPattern.test(email)) {
            showErrorMessage("⚠ 유효한 이메일을 입력하세요.");
            return;
        }

        $.ajax({
            url: contextPath + "/CheckEmailServlet",
            type: "POST",
            data: { email: email },
            success: function(response) {
                console.log("🔍 서버 응답:", response);

                if (response.trim() === "duplicate_email") {
                    showErrorMessage("❌ 이미 존재하는 이메일입니다. 다른 이메일을 입력하세요.");
                    $("#email-input").val("").focus();
                } else if (response.trim() === "available") {
                    saveEmail(email);
                } else {
                    showErrorMessage("❌ 서버 오류 발생: " + response);
                }
            },
            error: function(xhr, status, error) {
                console.error("🚨 AJAX 요청 오류:", status, error);
                showErrorMessage("❌ 서버 요청 중 문제가 발생했습니다.");
            }
        });
    });

    function saveEmail(email) {
        $.ajax({
            url: contextPath + "/SignInServlet",
            type: "POST",
            data: { step: "1", email: email },
            success: function(response) {
                console.log("📩 이메일 저장 응답:", response);

                if (response.trim() === "success") {
                    loadPasswordModal();
                } else {
                    showErrorMessage("❌ 이메일 저장 실패: " + response);
                }
            }
        });
    }

    function loadPasswordModal() {
        $.ajax({
            url: "SubFrame/Modal/SignIn_2.jsp",
            type: "GET",
            success: function(data) {
                console.log("✅ 비밀번호 입력 모달 로드 성공");

                $("#email-modal").fadeOut(200, function() {
                    $(this).remove();
                    $("body").append(data);
                    $("#password-modal").fadeIn(200);
                });
            },
            error: function(xhr, status, error) {
                console.error("🚨 비밀번호 모달 AJAX 요청 오류:", status, error);
            }
        });
    }

    function showErrorMessage(message) {
        $("#email-warning").text(message).removeClass("hidden");
    }
});
</script>

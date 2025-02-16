<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/SingIn.css">

<div class="modal" id="password-modal">
    <h1>Song of Senses</h1>
    <p>1/3단계<br>비밀번호 생성</p>
    <form id="password-form">
        <input type="password" name="password" placeholder="비밀번호" class="password-input" id="password-input" oninput="validatePassword()" required />
        <input type="password" name="password-confirm" placeholder="비밀번호 재확인" class="password-input" id="password-confirm" oninput="checkPasswordMatch()" required />
        
        <p id="password-warning" class="password-warning hidden"></p> 
        
        <p class="password-info">비밀번호에는 다음 조건이 충족되어야 합니다.</p>
        <ul class="password-criteria">
            <li><input type="checkbox" id="criteria-letter" disabled> 문자 1개 이상</li>
            <li><input type="checkbox" id="criteria-special" disabled> 숫자 또는 특수 문자 1개 이상 (예: !, @, # 등)</li>
            <li><input type="checkbox" id="criteria-length" disabled> 10자 이상</li>
        </ul>
        <button type="button" class="next-btn">다음</button>
    </form>
</div>

<script>
$(document).ready(function() {
    $(".next-btn").click(function(event) {
        event.preventDefault();
        const password = $("#password-input").val();
        const confirmPassword = $("#password-confirm").val();

        if (password === "" || confirmPassword === "") {
            alert("비밀번호를 입력해주세요.");
            return;
        }

        if (password !== confirmPassword) {
            alert("❌ 비밀번호가 일치하지 않습니다. 다시 확인하세요.");
            return;
        }

        $.ajax({
            url: "${pageContext.request.contextPath}/SignInServlet",
            type: "POST",
            data: { step: "2", password: password }, // ✅ step 추가!
            success: function(response) {
                console.log("🔍 서버 응답:", response);
                
                if (response.trim() === "success") {
                    $("#password-modal").fadeOut(200, function() {
                        $.ajax({
                            url: "SubFrame/Modal/SignIn_3.jsp",
                            type: "GET",
                            success: function(data) {
                                $("body").append(data);
                                $("#profile-modal").fadeIn(200);
                            }
                        });
                    });
                } else if (response.trim() === "error: email missing in session") {
                    alert("❌ 세션 오류: 이메일 정보가 사라졌습니다. 다시 시작해주세요.");
                    window.location.reload(); // 세션 초기화 시 새로고침
                } else {
                    alert("❌ 비밀번호 저장 실패: " + response);
                }
            },
            error: function(xhr, status, error) {
                console.error("🚨 AJAX 요청 오류:", status, error);
                alert("❌ 서버 요청 중 문제가 발생했습니다.");
            }
        });

    });
});

function validatePassword() {
    const password = $("#password-input").val();
    $("#criteria-letter").prop("checked", /[a-zA-Z]/.test(password));
    $("#criteria-special").prop("checked", /[\d!@#$%^&*]/.test(password));
    $("#criteria-length").prop("checked", password.length >= 10);
}

function checkPasswordMatch() {
    const password = $("#password-input").val();
    const confirmPassword = $("#password-confirm").val();
    const warningMessage = $("#password-warning");

    if (password === "" || confirmPassword === "") {
        warningMessage.addClass("hidden").text("");
        return;
    }

    if (password === confirmPassword) {
        warningMessage.removeClass("hidden").removeClass("password-warning").addClass("password-success").text("✅ 비밀번호가 일치합니다.");
    } else {
        warningMessage.removeClass("hidden").removeClass("password-success").addClass("password-warning").text("❌ 비밀번호가 일치하지 않습니다.");
    }
}
</script>

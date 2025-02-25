<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/SingIn.css">

<div class="modal" id="password-modal">
    <button class="close-modal-btn" id="close-modal3">&times;</button>


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
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script>
<script>
$(document).ready(function() {
    var contextPath = "<%= request.getContextPath() %>";

    $("#close-modal3").click(function() {
        $("#password-modal, .modal-overlay").fadeOut(100);
    });

    // ✅ ESC 키 입력 시 모달 닫기
    $(document).keydown(function(event) {
        if (event.key === "Escape") {
            $("#password-modal, .modal-overlay").fadeOut(100);
        }
    });

    function validatePassword() {
        const password = $("#password-input").val();
        const confirmPassword = $("#password-confirm").val();
        let isValid = true;

        // 🔍 검증 조건
        const hasLetter = /[a-zA-Z]/.test(password);
        const hasSpecialOrNumber = /[\d!@#$%^&*]/.test(password);
        const hasMinLength = password.length >= 10;
        const isMatch = password === confirmPassword;

        // ✅ 체크박스 업데이트
        $("#criteria-letter").prop("checked", hasLetter);
        $("#criteria-special").prop("checked", hasSpecialOrNumber);
        $("#criteria-length").prop("checked", hasMinLength);

        // ✅ 비밀번호 일치 확인
        if (password === "" || confirmPassword === "") {
            $("#password-warning").addClass("hidden").text("");
        } else if (isMatch) {
            $("#password-warning")
                .removeClass("hidden password-warning")
                .addClass("password-success")
                .text("✅ 비밀번호가 일치합니다.");
        } else {
            $("#password-warning")
                .removeClass("hidden password-success")
                .addClass("password-warning")
                .text("❌ 비밀번호가 일치하지 않습니다.");
            isValid = false;
        }

        // ✅ 모든 조건을 만족해야 `다음` 버튼 활성화
        $(".next-btn").prop("disabled", !(hasLetter && hasSpecialOrNumber && hasMinLength && isMatch));
    }

    $("#password-input, #password-confirm").on("input", validatePassword);

    $(".next-btn").click(function(event) {
        event.preventDefault();
        const password = $("#password-input").val();
        const confirmPassword = $("#password-confirm").val();

        if (!password || !confirmPassword) {
            alert("❌ 비밀번호를 입력해주세요.");
            return;
        }

        if (password !== confirmPassword) {
            alert("❌ 비밀번호가 일치하지 않습니다. 다시 확인하세요.");
            return;
        }

        // ✅ SHA-256 해싱 적용
        const hashedPassword = CryptoJS.SHA256(password).toString();

        $.ajax({
            url: contextPath + "/SignInServlet",
            type: "POST",
            data: { step: "2", password: hashedPassword },
            success: function(response) {
                console.log("🔍 서버 응답:", response);

                if (response.trim() === "success") {
                    $("#password-modal").fadeOut(100, function() {
                        $.ajax({
                            url: "SubFrame/Modal/SignIn_3.jsp",
                            type: "GET",
                            success: function(data) {
                                $("body").append(data);
                                $("#profile-modal").fadeIn(100);
                            }
                        });
                    });
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
</script>


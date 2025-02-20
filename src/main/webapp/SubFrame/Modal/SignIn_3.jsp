<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/SingIn.css">

<div class="modal-overlay"></div>
<div class="modal" id="profile-modal">
    <h1>Song of Senses</h1>
    <p>2/3단계: 자신을 소개</p>
    <form id="profile-form">
        <input type="text" id="nickname-input" placeholder="닉네임" class="input-field" required />
        <p id="nickname-warning" class="input-warning hidden">❌ 닉네임을 2자 이상 입력하세요.</p>
        
        <input type="date" id="birthdate-input" class="input-field" required />
        <p id="birthdate-warning" class="input-warning hidden">❌ 생년월일을 선택하세요.</p>

        <div class="gender-options">
            <label><input type="radio" name="gender" value="male"> 남자</label>
            <label><input type="radio" name="gender" value="female"> 여자</label>
        </div>
        <p id="gender-warning" class="input-warning hidden">❌ 성별을 선택하세요.</p>

        <button type="button" class="next-btn">다음</button>
    </form>
</div>

<script>
$(document).ready(function() {
	var contextPath = "";
	
    $(".next-btn").click(function(event) {
        event.preventDefault();
        const nickname = $("#nickname-input").val().trim();
        const birthdate = $("#birthdate-input").val();
        const gender = $("input[name='gender']:checked").val();

        let isValid = true;

        // 닉네임 검증
        if (!nickname || nickname.length < 2) {
            $("#nickname-warning").removeClass("hidden");
            isValid = false;
        } else {
            $("#nickname-warning").addClass("hidden");
        }

        // 생년월일 검증
        if (!birthdate) {
            $("#birthdate-warning").removeClass("hidden");
            isValid = false;
        } else {
            $("#birthdate-warning").addClass("hidden");
        }

        // 성별 검증
        if (!gender) {
            $("#gender-warning").removeClass("hidden");
            isValid = false;
        } else {
            $("#gender-warning").addClass("hidden");
        }

        if (!isValid) return;

        // AJAX 요청을 통해 서버로 데이터 전송
        $.ajax({
            url: contextPath + "/SignInServlet",
            type: "POST",
            data: { nickname: nickname, birthdate: birthdate, gender: gender },
            success: function(response) {
                console.log("🔍 서버 응답:", response);

                if (response.trim() === "success") {
                    $("#profile-modal").fadeOut(200, function() {
                        $.ajax({
                            url: "SubFrame/Modal/SignIn_4.jsp",
                            type: "GET",
                            success: function(data) {
                                $("body").append(data);
                                $("#terms-modal").fadeIn(200);
                            }
                        });
                    });
                } else {
                    alert("❌ 회원 정보 저장 실패: " + response);
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

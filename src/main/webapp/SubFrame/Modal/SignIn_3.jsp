<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/SingIn.css">
 <!-- 이름 입력 및 생년월일 모달 -->
    <div class="modal" id="profile-modal">
        <h1>Song of Senses</h1>
        <form id="password-form" action="SingIn_4.jsp" onsubmit="showProfileModal(event)">
        <div class="step-title">2/3단계: 자신을 소개</div>
        <input type="text" class="input-field" placeholder="이름" id="name-input" required>
        <p>이 이름이 프로필에 표시됩니다.</p>
        <input type="date" class="input-field" id="date-input" required>
        <div class="gender-options">
            <label><input type="radio" name="gender" value="male"> 남자</label>
            <label><input type="radio" name="gender" value="female"> 여자</label>
        </div>
        <button class="next-btn" onclick="showTermsModal()">다음</button>
        </form>
    </div>

<script>
    $(document).ready(function() {
        // 회원가입 버튼 클릭 이벤트
        $(".next-btn").click(function(event) {
            event.preventDefault();  // 기본 링크 이동 방지

            $.ajax({
                url: "SubFrame/Modal/SignIn_4.jsp",  // 회원가입 모달 경로
                type: "GET",
                dataType: "html",
                success: function(data) {
                    $("#profile-modal").fadeOut(200, function() {
                        $(this).replaceWith(data); // 로그인 모달을 회원가입 모달로 교체
                        $("#terms-modal").show(); 	// 새 모달 표시
                    });
                },
                error: function(xhr, status, error) {
                    console.error("회원가입 모달을 불러오는 중 오류 발생:", error);
                }
            });
        });
        
        $(document).on("click", function(event) {
            if ($(event.target).closest("#profile-modal").length === 0) {
                $("#profile-modal").fadeOut();
            }
        });
        
    });
</script>
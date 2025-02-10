<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/SingIn.css">

    <!-- 이메일 입력 모달 -->
    <div class="modal" id="email-modal">
        <h1>Song of Senses</h1>
        <p>가입 이후<br>다양한 컨텐츠와 음악을<br>감상하세요</p>
        <form id="email-form" action="" method="post">
            <input type="email" name="email" placeholder="이메일 주소" class="email-input" required />
            <div class="separator">
                <span>또는</span>
            </div>
            <div class="social-buttons">
                <button type="button" class="social-btn naver-btn">N</button>
                <button type="button" class="social-btn kakao-btn">K</button>
                <button type="button" class="social-btn google-btn">G</button>
            </div>
            <button type="submit" class="next-btn">다음</button>
        </form>
    </div>

    
    <script>
    $(document).ready(function() {
        // 회원가입 버튼 클릭 이벤트
        $(".next-btn").click(function(event) {
            event.preventDefault();  // 기본 링크 이동 방지

            $.ajax({
                url: "SubFrame/Modal/SignIn_2.jsp",  // 회원가입 모달 경로
                type: "GET",
                dataType: "html",
                success: function(data) {
                    $("#email-modal").fadeOut(200, function() {
                        $(this).replaceWith(data); // 로그인 모달을 회원가입 모달로 교체
                        $("#password-modal").show(); 	// 새 모달 표시
                    });
                },
                error: function(xhr, status, error) {
                    console.error("회원가입 모달을 불러오는 중 오류 발생:", error);
                }
            });
        });
    });
</script>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/Login.css">
<!-- 로그인 모달 -->
    <div class="modal" id="login-modal" >
        <h1>Song of Senses<br>로그인</h1>
        <form id="login-form" onsubmit="processLogin(event)">
            <input type="email" name="login-email" placeholder="이메일 주소" class="email-input" required />
            <input type="password" name="login-password" placeholder="비밀번호" class="password-input" required />
            <button type="submit" class="next-btn">로그인</button>
        </form>
        
        <div class="separator">
            <span>또는</span>
        </div>
        
        <div class="social-buttons">
            <button type="button" class="social-btn naver-btn" onclick="loginWith('naver')">N</button>
            <button type="button" class="social-btn kakao-btn" onclick="loginWith('kakao')">K</button>
            <button type="button" class="social-btn google-btn" onclick="loginWith('google')">G</button>
        </div>
        
        <p class="forgot-password"><a href="#">비밀번호를 잊으셨나요?</a></p>
        <a href="#" id="signup-link">회원가입하기</a>
    </div>

    <script>
        function processLogin(event) {
            event.preventDefault();
            const email = document.querySelector('input[name="login-email"]').value;
            const password = document.querySelector('input[name="login-password"]').value;

            if (email && password) {
                alert('로그인 성공');
                // 추가 로그인 처리 로직 필요
            } else {
                alert('이메일과 비밀번호를 입력해 주세요.');
            }
        }

        function loginWith(provider) {
            alert(provider + '로 로그인 시도');
            // 소셜 로그인 연동 로직 추가 필요
        }
    </script>
    
<script>
    $(document).ready(function() {
        // 회원가입 버튼 클릭 이벤트
        $("#signup-link").click(function(event) {
            event.preventDefault();  // 기본 링크 이동 방지

            $.ajax({
                url: "SubFrame/Modal/SignIn_1.jsp",  // 회원가입 모달 경로
                type: "GET",
                dataType: "html",
                success: function(data) {
                    $("#login-modal").fadeOut(200, function() {
                        $(this).replaceWith(data); // 로그인 모달을 회원가입 모달로 교체
                        $("#email-modal").show(); 	// 새 모달 표시
                    });
                },
                error: function(xhr, status, error) {
                    console.error("회원가입 모달을 불러오는 중 오류 발생:", error);
                }
            });
        });
    });
</script>
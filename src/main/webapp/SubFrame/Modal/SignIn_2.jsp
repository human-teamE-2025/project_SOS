<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/SingIn.css">
 <!-- 비밀번호 생성 모달 -->
    <div class="modal" id="password-modal">
        <h1>Song of Senses</h1>
        <p>1/3단계<br>비밀번호 생성</p>
        <form id="password-form" action="SingIn_3.jsp" onsubmit="showProfileModal(event)">
            <input type="password" name="password" placeholder="비밀번호" class="password-input" id="password-input" oninput="validatePassword()" required />
            <input type="password" name="password-confirm" placeholder="비밀번호 재확인" class="password-input" id="password-confirm" required />
            
            <p id="password-warning" class="password-warning hidden">비밀번호가 일치하지 않습니다.</p>
            <p class="password-info">비밀번호에는 다음 조건이 충족되어야 합니다.</p>
            <ul class="password-criteria">
                <li><input type="checkbox" id="criteria-letter" disabled> 문자 1개 이상</li>
                <li><input type="checkbox" id="criteria-special" disabled> 숫자 또는 특수 문자 1개 이상 (예: !, @, # 등)</li>
                <li><input type="checkbox" id="criteria-length" disabled> 10자 이상</li>
            </ul>
            <button type="submit" class="next-btn">다음</button>
        </form>
    </div>
    
    
  <script>
        function showPasswordModal(event) {
            event.preventDefault();
            document.getElementById('email-modal').classList.add('hidden');
            document.getElementById('password-modal').classList.remove('hidden');
        }

        function showProfileModal(event) {
            event.preventDefault();
            const password = document.getElementById('password-input').value;
            const confirmPassword = document.getElementById('password-confirm').value;

            if (password !== confirmPassword) {
                document.getElementById('password-warning').classList.remove('hidden');
                return;
            }

            document.getElementById('password-warning').classList.add('hidden');
            document.getElementById('password-modal').classList.add('hidden');
            document.getElementById('profile-modal').classList.remove('hidden');
        }

        function validatePassword() {
            const password = document.getElementById('password-input').value;

            const hasLetter = /[a-zA-Z]/.test(password);
            const hasSpecialOrNumber = /[\d!@#$%^&*]/.test(password);
            const hasMinLength = password.length >= 10;

            document.getElementById('criteria-letter').checked = hasLetter;
            document.getElementById('criteria-special').checked = hasSpecialOrNumber;
            document.getElementById('criteria-length').checked = hasMinLength;
        }

        function showTermsModal() {
            document.getElementById('profile-modal').classList.add('hidden');
            document.getElementById('terms-modal').classList.remove('hidden');
        }

        document.getElementById('agree-terms').addEventListener('change', function() {
            document.getElementById('complete-button').disabled = !this.checked;
        });
    </script>
    
    
        <script>
    $(document).ready(function() {
        // 회원가입 버튼 클릭 이벤트
        $(".next-btn").click(function(event) {
            event.preventDefault();  // 기본 링크 이동 방지

            $.ajax({
                url: "SubFrame/Modal/SignIn_3.jsp",  // 회원가입 모달 경로
                type: "GET",
                dataType: "html",
                success: function(data) {
                    $("#password-modal").fadeOut(200, function() {
                        $(this).replaceWith(data); // 로그인 모달을 회원가입 모달로 교체
                        $("#profile-modal").show(); 	// 새 모달 표시
                    });
                },
                error: function(xhr, status, error) {
                    console.error("회원가입 모달을 불러오는 중 오류 발생:", error);
                }
            });
        });
        $(document).on("click", function(event) {
            if ($(event.target).closest("#password-modal").length === 0) {
                $("#password-modal").fadeOut();
            }
        });
        
    });
</script>
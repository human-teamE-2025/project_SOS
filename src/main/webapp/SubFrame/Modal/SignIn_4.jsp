<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Song of Senses</title>
</head>
<body>
    <!-- 이용 약관 모달 -->
    <div class="modal" id="terms-modal">
        <h1>Song of Senses</h1>
        <div class="step-title">3/3단계: 이용 약관 동의</div>
        <div class="terms-content">
            <h2>이용 약관</h2>
            <p>본 사이트는 사용자에게 음악 및 컨텐츠 서비스를 제공합니다. 서비스를 이용함에 있어 다음 사항에 동의해야 합니다.</p>
            <ul>
                <li>서비스의 저작권 및 지적 재산권을 준수합니다.</li>
                <li>부적절한 콘텐츠 업로드 및 배포를 금지합니다.</li>
                <li>개인정보 처리 방침에 따라 개인정보가 처리됩니다.</li>
                <li>기타 사이트 운영 정책에 동의합니다.</li>
            </ul>
        </div>
        <div class="terms-agree">
            <label><input type="checkbox" id="agree-terms"> 모든 약관에 동의합니다.</label>
        </div>
        <button class="next-btn" id="complete-button" >회원가입 완료</button>
    </div>

    <script>
/*         function showPasswordModal(event) {
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
 */
        document.getElementById('complete-button').addEventListener('click', function() {
            alert('회원가입이 완료되었습니다.');
            // 추가 로직: 회원가입 완료 후 페이지 이동 또는 서버로 데이터 전송
        });
 $(document).ready(function() {
 $(document).on("click", function(event) {
     if ($(event.target).closest("#terms-modal").length === 0) {
         $("#terms-modal").fadeOut();
     }
 });
 });
 
    </script>
</body>
</html>
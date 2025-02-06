<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Song of Senses</title>
    <link rel="stylesheet" href="Login.css">
</head>
<body>
    <!-- 첫 번째 모달 (이메일 입력) -->
    <div class="modal" id="email-modal">
        <h1>Song of Senses</h1>
        <p>가입 이후<br>다양한 컨텐츠와 음악을<br>감상하세요</p>

        <form id="email-form" onsubmit="showPasswordModal(event)">
            <input type="email" name="email" placeholder="이메일 주소" class="email-input" required />
            <div class="separator">
                <span>또는</span>
            </div>

            <!-- 소셜 로그인 버튼 -->
            <div class="social-buttons">
                <button type="button" class="social-btn naver-btn">N</button>
                <button type="button" class="social-btn kakao-btn">K</button>
                <button type="button" class="social-btn google-btn">G</button>
            </div>

            <button type="submit" class="next-btn">다음</button>
        </form>
    </div>

    <!-- 두 번째 모달 (비밀번호 생성) -->
    <div class="modal hidden" id="password-modal">
        <h1>Song of Senses</h1>
        <p>1/3단계<br>비밀번호 생성</p>
        <form id="password-form" onsubmit="validatePasswords(event)">
            <input type="password" name="password" placeholder="비밀번호" class="password-input" id="password-input" oninput="validatePassword()" required />
            <input type="password" name="password-confirm" placeholder="비밀번호 재확인" class="password-input" id="password-confirm" required />
            
            <!-- 경고 메시지 -->
            <p id="password-warning" class="password-warning hidden">비밀번호가 일치하지 않습니다.</p>

            <p class="password-info">비밀번호에는 다음과 같은 조건이 충족되어야 합니다.</p>
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

        function validatePassword() {
            const password = document.getElementById('password-input').value;

            // 조건 검증
            const hasLetter = /[a-zA-Z]/.test(password);
            const hasSpecialOrNumber = /[\d!@#\$%\^&\*]/.test(password);
            const hasMinLength = password.length >= 10;

            // 체크박스 업데이트
            document.getElementById('criteria-letter').checked = hasLetter;
            document.getElementById('criteria-special').checked = hasSpecialOrNumber;
            document.getElementById('criteria-length').checked = hasMinLength;
        }

        function validatePasswords(event) {
            const password = document.getElementById('password-input').value;
            const confirmPassword = document.getElementById('password-confirm').value;

            // 비밀번호가 일치하지 않을 경우 경고 메시지를 표시하고 제출을 막음
            if (password !== confirmPassword) {
                event.preventDefault();
                document.getElementById('password-warning').classList.remove('hidden');
            } else {
                document.getElementById('password-warning').classList.add('hidden');
            }
        }
    </script>
</body>
</html>

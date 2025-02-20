<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Song of Senses</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/SingIn.css">
</head>
<body>

<div class="modal-overlay"></div>
<div class="modal" id="terms-modal">
    <h1>Song of Senses</h1>
    <p>3/3단계: 이용 약관 동의</p>
    <div class="terms-content">
        <h2>이용 약관</h2>
        <p>본 사이트는 사용자에게 음악 및 컨텐츠 서비스를 제공합니다.</p>
        <label><input type="checkbox" id="agree-terms"> 모든 약관에 동의합니다.</label>
    </div>
    <button class="next-btn" id="complete-button" disabled>회원가입 완료</button>
</div>

<script>
$(document).ready(function() {
	var contextPath = "";
	
    $("#agree-terms").change(function() {
        $("#complete-button").prop("disabled", !this.checked);
    });

    $("#complete-button").click(function(event) {
        event.preventDefault(); // 기본 이벤트 방지
        $("#complete-button").prop("disabled", true); // 중복 클릭 방지

        $.ajax({
            url: contextPath + "/SignUpCompleteServlet",
            type: "POST",
            success: function(response) {
                console.log("🔍 서버 응답:", response);
                
                if (response.trim() === "success") {
                    alert("🎉 회원가입이 완료되었습니다!");
                    window.location.href = "index.jsp";
                } else if (response.trim() === "duplicate_email") {
                    alert("❌ 이미 존재하는 이메일입니다! 다른 이메일을 입력하세요.");
                    $("#complete-button").prop("disabled", false); // 다시 활성화
                } else {
                    alert("❌ 회원가입 실패: " + response);
                    $("#complete-button").prop("disabled", false); // 다시 활성화
                }
            },
            error: function(xhr, status, error) {
                console.error("🚨 AJAX 요청 오류:", status, error);
                alert("❌ 서버 요청 중 문제가 발생했습니다.");
                $("#complete-button").prop("disabled", false); // 다시 활성화
            }
        });
    });
});
</script>

</body>
</html>

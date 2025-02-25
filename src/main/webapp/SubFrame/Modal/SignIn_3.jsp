<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/SignIn.css">

<div class="modal-overlay"></div>
<div class="modal" id="profile-modal">
    <button class="close-modal-btn" id="close-modal4">&times;</button>
    
    <h1>Song of Senses</h1>
    <p>2/3단계: 자신을 소개</p>
    
    <form id="profile-form">
        <!-- ✅ 닉네임 입력 -->
        <input type="text" id="nickname-input" placeholder="닉네임" class="input-field" required />
        <p id="nickname-warning" class="input-warning hidden">❌ 닉네임을 2자 이상 입력하세요.</p>

        <!-- ✅ 생년월일 입력 -->
        <input type="date" id="birthdate-input" class="input-field" required />
        <p id="birthdate-warning" class="input-warning hidden">❌ 생년월일을 선택하세요.</p>

        <!-- ✅ 성별 선택 -->
        <div class="gender-options">
            <label><input type="radio" name="gender" value="male"> 남자</label>
            <label><input type="radio" name="gender" value="female"> 여자</label>
        </div>
        <p id="gender-warning" class="input-warning hidden">❌ 성별을 선택하세요.</p>

        <!-- ✅ 좋아하는 노래 장르 선택 -->
        <select id="favorite-genre" class="input-field">
            <option value="">-- 좋아하는 장르 선택 (선택 안 함) --</option>
            <option value="pop">팝 (Pop)</option>
            <option value="rock">록 (Rock)</option>
            <option value="hiphop">힙합 (Hip-Hop)</option>
            <option value="jazz">재즈 (Jazz)</option>
            <option value="classical">클래식 (Classical)</option>
            <option value="edm">EDM (Electronic Dance Music)</option>
        </select>

        <!-- ✅ 버튼 -->
        <button type="button" class="next-btn">다음</button>
    </form>
</div>

<script>
$(document).ready(function() {
    var contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));

    $("#close-modal4").click(function() {
        $("#profile-modal, .modal-overlay").fadeOut(100);
    });

    // ✅ ESC 키 입력 시 모달 닫기
    $(document).keydown(function(event) {
        if (event.key === "Escape") {
            $("#profile-modal, .modal-overlay").fadeOut(100);
        }
    });

    $(".next-btn").click(function(event) {
        event.preventDefault();

        // ✅ 입력값 가져오기
        const nickname = $("#nickname-input").val().trim();
        const birthdate = $("#birthdate-input").val();
        const gender = $("input[name='gender']:checked").val();
        const genre = $("#favorite-genre").val();

        let isValid = true;

        // ✅ 입력값 검증 및 경고 표시
        if (!nickname || nickname.length < 2) {
            $("#nickname-warning").removeClass("hidden");
            isValid = false;
        } else {
            $("#nickname-warning").addClass("hidden");
        }

        if (!birthdate) {
            $("#birthdate-warning").removeClass("hidden");
            isValid = false;
        } else {
            $("#birthdate-warning").addClass("hidden");
        }

        if (!gender) {
            $("#gender-warning").removeClass("hidden");
            isValid = false;
        } else {
            $("#gender-warning").addClass("hidden");
        }

        if (!isValid) {
            console.error("❌ 입력값 검증 실패 (유효하지 않음)");
            return;
        }

        // ✅ 데이터 확인 (콘솔 출력)
        console.log("🔍 전송할 데이터:", {
            step: "2",
            nickname: nickname,
            birthdate: birthdate,
            gender: gender,
            genre: genre || "null" // 선택 안 하면 null로 저장
        });

        // ✅ AJAX 요청을 통해 서버로 데이터 전송
        $.ajax({
            url: contextPath + "/SignInServlet",
            type: "POST",
            data: { 
                step: "3",
                nickname: nickname,
                birthdate: birthdate,
                gender: gender,
                genre: genre || "null"
            },
            success: function(response) {
                console.log("✅ 서버 응답:", response);

                if (response.trim() === "success") {
                    $("#profile-modal").fadeOut(100, function() {
                        $.ajax({
                            url: "SubFrame/Modal/SignIn_4.jsp",
                            type: "GET",
                            success: function(data) {
                                $("body").append(data);
                                $("#terms-modal").fadeIn(100);
                            }
                        });
                    });
                } else {
                    alert("❌ 회원 정보 저장 실패: " + response);
                    console.error("🚨 서버 오류:", response);
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

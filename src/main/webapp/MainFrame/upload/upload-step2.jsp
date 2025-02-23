<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    String uploadedFileName = (String) session.getAttribute("uploadedFileName");
    String songTitle = (String) session.getAttribute("songTitle");
    String artist = (String) session.getAttribute("artist");
    String genre = (String) session.getAttribute("genre");
%>

<div id="upload-step2">
    <h2>📸 추가 정보 입력 (2단계)</h2>
    <form id="music-upload-step2">
        <p>🎵 파일: <%= uploadedFileName %></p>
        <p>🎶 제목: <%= songTitle %></p>
        <p>👤 아티스트: <%= artist %></p>
        <p>🎼 장르: <%= genre %></p>

        <label for="description">설명 (선택사항):</label>
        <textarea id="description" name="description" rows="5"></textarea>

        <button type="submit">최종 업로드</button>
    </form>
</div>



<style>
/* ✅ Step1과 유사한 폭 조정 */
#upload-step2 {
    background: #222;
    padding: 20px;
    border-radius: 10px;
    color: white;
    max-width: 600px;
    margin: auto;
}

/* ✅ 제목 스타일 */
#upload-step2 h2 {
    text-align: center;
}

/* ✅ 썸네일 & 설명을 나란히 배치 */
.thumbnail-desc-container {
    display: flex;
    gap: 15px; /* ✅ 여백 증가 */
    align-items: flex-start;
    justify-content: space-between;
}

/* ✅ 썸네일을 정사각형으로 유지 */
.thumbnail-preview {
    width: 150px;
    height: 150px;
    border-radius: 10px;
    display: flex;
    justify-content: center;
    align-items: center;
    overflow: hidden;
    transition: background 0.5s ease;
    background: linear-gradient(45deg, #ff9a9e, #fad0c4); /* ✅ 기본 그라데이션 */
}

/* ✅ 썸네일 내부 이미지가 정확히 들어가도록 설정 */
.thumbnail-preview img {
    width: 100%;
    height: 100%;
    object-fit: cover; /* ✅ 업로드 시 꽉 차게 */
    display: none;
}

/* ✅ 설명 입력란이 남은 공간을 차지 */
.description-container {
    flex-grow: 1;
}

/* ✅ 입력 필드 스타일 */
#music-upload-step2 input,
#music-upload-step2 textarea {
    padding: 10px;
    border-radius: 5px;
    border: 1px solid #555;
    background: #333;
    color: white;
    font-size: 16px;
    width: 100%;
    transition: 0.3s ease;
}

/* ✅ 버튼 스타일 */
#music-upload-step2 button {
    background: #FFC107;
    color: black;
    padding: 12px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
}

/* ✅ 버튼 호버 */
#music-upload-step2 button:hover {
    background: #FFB300;
}

#prev-step {
    background: #555;
    color: white;
}

/* ✅ 분위기 태그 스타일 */
.mood-tags {
    display: flex;
    gap: 10px; /* ✅ 태그 간격 증가 */
    flex-wrap: wrap;
    margin-top: 10px;
}

/* ✅ 태그 버튼 스타일 */
.mood-tags label {
    background: #444;
    padding: 10px 14px;
    border-radius: 6px;
    color: white;
    cursor: pointer;
    font-size: 14px;
    transition: 0.3s ease;
}

/* ✅ 태그 선택 시 */
.mood-tags input:checked + label {
    background: #FFB300;
    color: black;
    font-weight: bold;
}

/* ✅ 태그 hover 효과 */
.mood-tags label:hover {
    background: #FFC107;
    color: black;
}

/* ✅ 숨김처리된 input */
.mood-tags input {
    display: none;
}

/* ✅ 버튼 영역 간격 조정 */
.form-buttons {
    display: flex;
    gap: 10px; /* ✅ 버튼 간격 증가 */
    margin-top: 15px; /* ✅ 태그와 버튼 사이 여백 추가 */
}

/* ✅ 모바일 대응 (작은 화면에서는 세로 배치) */
@media (max-width: 600px) {
    .thumbnail-desc-container {
        flex-direction: column;
        align-items: center;
    }
    
    .thumbnail-preview {
        width: 120px;
        height: 120px;
    }
}
</style>

<div id="upload-step2">
    <h2>📸 썸네일 & 설명 추가 (2단계)</h2>
    <form id="music-upload-step2">

        <!-- ✅ 썸네일 & 설명 컨테이너 -->
        <div class="thumbnail-desc-container">
            <!-- ✅ 썸네일 미리보기 박스 -->
            <div class="thumbnail-preview" id="thumbnail-preview">
                <img id="thumbnail-img" alt="썸네일 미리보기">
            </div>

            <!-- ✅ 설명 입력 -->
            <div class="description-container">
                <label for="description">설명 (선택사항):</label>
                <textarea id="description" name="description" rows="5" placeholder="자동 생성된 설명이 여기에 표시됩니다.">(업로드 시간: ${currentTime})</textarea>
            </div>
        </div>

        <!-- ✅ 썸네일 파일 업로드 -->
        <label for="thumbnail">썸네일 이미지 (선택사항):</label>
        <input type="file" id="thumbnail" name="thumbnail" accept="image/*">

        <!-- ✅ 분위기 태그 선택 -->
        <label>분위기 태그 선택:</label>
        <div class="mood-tags">
            <% String[] moodTags = {
                "새벽 감성 음악", "여름 바닷가 감성", "영화 주제 음악", "드라마 OST", "피아노로 연주된", 
                "기타로 연주된", "바이올린 연주곡", "오케스트라 편곡", "잔잔한 카페 분위기", 
                "활기찬 분위기", "침울한 분위기", "몽환적인 느낌의 곡", "사랑스러운 로맨틱송", 
                "운동할 때 듣기 좋은", "공부할 때 집중되는 음악", "새벽 감성 음악", "신나는 댄스곡", 
                "잔잔한 어쿠스틱", "90년대 레트로 감성", "Lo-Fi 힙합 스타일"
            };
            for (int i = 0; i < moodTags.length; i++) { %>
                <input type="checkbox" id="mood<%=i%>" name="mood" value="<%=moodTags[i]%>">
                <label for="mood<%=i%>"><%=moodTags[i]%></label>
            <% } %>
        </div>

        <!-- ✅ 버튼 컨테이너 -->
        <div class="form-buttons">
            <button type="submit">최종 업로드</button>
            <button type="button" id="prev-step">이전 단계</button>
        </div>
    </form>
</div>

<script>
function initUploadStep2Events() {
    console.log("🚀 Step2 이벤트 리스너 등록 완료");
	
    const form = document.getElementById("music-upload-step2");
    const thumbnailInput = document.getElementById("thumbnail");
    const thumbnailPreview = document.getElementById("thumbnail-preview");
    const thumbnailImg = document.getElementById("thumbnail-img");
    const descriptionInput = document.getElementById("description");
    const prevStepButton = document.getElementById("prev-step"); // ✅ 이전 단계 버튼
    const submitButton = form.querySelector("button[type='submit']"); // ✅ 최종 업로드 버튼



    
    // ✅ 랜덤한 그라데이션 적용
    function getRandomGradient() {
        const colors = ["#ff9a9e", "#fad0c4", "#a1c4fd", "#c2e9fb", "#d4fc79", "#96e6a1"];
        return `linear-gradient(45deg, ${colors[Math.floor(Math.random() * colors.length)]}, ${colors[Math.floor(Math.random() * colors.length)]})`;
    }

    // ✅ 기본 썸네일 배경 설정
    thumbnailPreview.style.background = getRandomGradient();

    // ✅ 썸네일 미리보기 기능
    thumbnailInput.addEventListener("change", function () {
        if (thumbnailInput.files.length > 0) {
            const reader = new FileReader();
            reader.onload = function (e) {
                thumbnailImg.src = e.target.result;
                thumbnailImg.style.display = "block";
                thumbnailPreview.style.background = "none"; // ✅ 기존 배경 제거
            };
            reader.readAsDataURL(thumbnailInput.files[0]);
        }
    });

    // ✅ 설명 placeholder 자동 생성
    const now = new Date().toLocaleString();
    descriptionInput.placeholder = `- (업로드 시간: ${now})\n이 곡은 특별한 분위기를 가지고 있습니다.`;

    // ✅ "이전 단계" 버튼 클릭 시 step1.jsp로 이동 (AJAX로 로드)
    prevStepButton.addEventListener("click", function () {
        console.log("🔄 이전 단계 로드 중...");
        fetch("<%= request.getContextPath() %>/MainFrame/upload-step1.jsp")
            .then(response => {
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                return response.text();
            })
            .then(data => {
                document.getElementById("upload-step2").innerHTML = data;
            })
            .catch(error => console.error("❌ 이전 단계 로드 오류:", error));
    });

    // ✅ "최종 업로드" 버튼 클릭 시 처리
    document.getElementById("music-upload-step2").addEventListener("submit", function (event) {
        event.preventDefault();

        const formData = new FormData();
        formData.append("description", document.getElementById("description").value);

        fetch("UploadFinalServlet", {
            method: "POST",
            body: formData
        })
        .then(response => response.text())
        .then(data => {
            document.body.innerHTML = "<h2>✅ 업로드 완료!</h2><p>" + data + "</p>";
        })
        .catch(error => console.error("❌ 업로드 오류:", error));
    });

}

// ✅ AJAX로 step2가 로드될 때 자동 실행
initUploadStep2Events();

</script>

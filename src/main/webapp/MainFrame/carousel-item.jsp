<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
    String title = request.getParameter("title") != null ? request.getParameter("title") : "제목 없음";
    String thumbnail = request.getParameter("thumbnail");

    // 🚀 thumbnail 값이 null, 빈 문자열, "null", "undefined"인 경우 그라데이션 적용
    boolean useGradient = (thumbnail == null || thumbnail.trim().isEmpty() || "null".equals(thumbnail) || "undefined".equals(thumbnail));

    // 랜덤 그라데이션 색상 생성 (더 다양한 색상 포함)
    String[][] gradients = {
        {"#ff9a9e", "#fad0c4"}, {"#a1c4fd", "#c2e9fb"},
        {"#fbc2eb", "#a6c1ee"}, {"#fdcbf1", "#e6dee9"},
        {"#ff9966", "#ff5e62"}, {"#6a11cb", "#2575fc"},
        {"#ff758c", "#ff7eb3"}, {"#2193b0", "#6dd5ed"},
        {"#ff512f", "#dd2476"}, {"#1d2b64", "#f8cdda"}
    };

    // 랜덤 색상 선택
    int randomIndex = (int) (Math.random() * gradients.length);
    String randomGradient = "linear-gradient(135deg, " + gradients[randomIndex][0] + ", " + gradients[randomIndex][1] + ")";
%>

<style>
/* 캐러셀 아이템 */
.carousel-item {
    position: relative;
    width: 180px;
    height: 180px;
    display: flex;
    align-items: center;
    justify-content: center;
    border: 3px solid #ddd;
    border-radius: 8px;
    overflow: hidden;
    flex-shrink: 0;
    transition: transform 0.3s ease-in-out;
}

/* hover 시 4개 요소만 표시 */
.carousel-item:hover .carousel-heart,
.carousel-item:hover .carousel-title,
.carousel-item:hover .carousel-buttons {
    opacity: 1;
}

/* ❤️ 하트 버튼 (기본 빈 하트 🤍) */
.carousel-heart {
    position: absolute;
    top: 8px;
    left: 8px;
    background: rgba(0, 0, 0, 0.6);
    color: white;
    padding: 5px 8px;
    border-radius: 5px;
    font-size: 14px;
    cursor: pointer;
    opacity: 0;
    transition: opacity 0.3s ease-in-out;
}

/* 🎵 제목 버튼 */
.carousel-title {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: rgba(0, 0, 0, 0.7);
    color: white;
    padding: 8px 12px;
    border-radius: 5px;
    font-size: 14px;
    opacity: 0;
    transition: opacity 0.3s ease-in-out;
}

/* ▶️ 재생 & 더보기 버튼 */
.carousel-buttons {
    position: absolute;
    bottom: 8px;
    right: 8px;
    display: flex;
    gap: 5px;
    opacity: 0;
    transition: opacity 0.3s ease-in-out;
}

.carousel-buttons button {
    background: rgba(0, 0, 0, 0.7);
    color: white;
    border: none;
    cursor: pointer;
    padding: 5px 8px;
    font-size: 12px;
    border-radius: 5px;
}

.carousel-buttons button:hover {
    background: rgba(0, 0, 0, 1);
}
#carousel-3 .carousel-item{
	border-radius:50%;
}
</style>

<!-- 캐러셀 아이템 -->

<div class="carousel-item" style="background: <%= (thumbnail != null && !thumbnail.isEmpty()) ? "url(" + thumbnail + ") center/cover" : randomGradient %>;">
    <div class="carousel-heart" onclick="toggleHeart(this)">🤍</div>
    <div class="carousel-title"><%= title %></div>
	    <div class="carousel-buttons">
        <button onclick="viewDetail('<%= title %>')">더보기</button>
        <button onclick="alert('재생 클릭: <%= title %>')">▶</button>
    </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function () {
    function getRandomGradient() {
        // ✅ 대비가 명확한 랜덤 색상 조합을 생성
        function randomColor() {
            const h = Math.floor(Math.random() * 360);  // 색상 (Hue) 0~360도 랜덤
            const s = Math.floor(Math.random() * 40) + 60;  // 채도 (Saturation) 60~100%
            const l = Math.floor(Math.random() * 30) + 50;  // 밝기 (Lightness) 50~80%
            return `hsl(${h}, ${s}%, ${l}%)`;
        }

        const color1 = randomColor();
        const color2 = randomColor();
        return `linear-gradient(135deg, ${color1}, ${color2})`;
    }

    document.querySelectorAll(".carousel-item").forEach(item => {
        let thumbnail = item.getAttribute("data-thumbnail");

        // ✅ Null 또는 빈 문자열("")일 경우 그라데이션 적용
        if (!thumbnail || thumbnail.trim() === "" || thumbnail === "null" || thumbnail === "undefined") {
            item.style.background = getRandomGradient();
        } else {
            item.style.background = `url(${thumbnail}) center/cover no-repeat`;
        }
    });
});

/* ❤️ 하트 버튼 토글 기능 */
function toggleHeart(element) {
    if (element.textContent === "🤍") {
        element.textContent = "❤️"; // 클릭 시 빨간 하트로 변경
    } else {
        element.textContent = "🤍"; // 다시 클릭하면 빈 하트로 돌아감
    }
}
function viewDetail(title) {
    const encodedTitle = encodeURIComponent(title); // URL 인코딩 처리
    location.href = `view-detail.jsp?title=${encodedTitle}`;
}
</script>

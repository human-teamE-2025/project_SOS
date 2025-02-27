<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // 🔹 캐러셀 목록 (각 섹션별 제목과 아이템 배열)
String[][] carousels = {
    {"유행중인", "노래 제목 1", "노래 제목 2", "노래 제목 3", "노래 제목 4", "노래 제목 5", "노래 제목 6", "노래 제목 7", "노래 제목 8", "노래 제목 9", "노래 제목 10"},
    {"추천곡", "추천곡 1", "추천곡 2", "추천곡 3", "추천곡 4", "추천곡 5", "추천곡 6", "추천곡 7", "추천곡 8", "추천곡 9", "추천곡 10", "추천곡 11", "추천곡 12"},
    {"아티스트", "아티스트 1", "아티스트 2", "아티스트 3", "아티스트 4", "아티스트 5", "아티스트 6", "아티스트 7", "아티스트 8", "아티스트 9", "아티스트 10"},
    {"최신곡", "최신곡 1", "최신곡 2", "최신곡 3", "최신곡 4", "최신곡 5", "최신곡 6", "최신곡 7", "최신곡 8", "최신곡 9", "최신곡 10", "최신곡 11"},
    {"발라드", "발라드 1", "발라드 2", "발라드 3", "발라드 4", "발라드 5", "발라드 6", "발라드 7", "발라드 8", "발라드 9"},
    {"댄스", "댄스 1", "댄스 2", "댄스 3", "댄스 4", "댄스 5", "댄스 6", "댄스 7", "댄스 8", "댄스 9", "댄스 10"},
    {"힙합", "힙합 1", "힙합 2", "힙합 3", "힙합 4", "힙합 5", "힙합 6", "힙합 7", "힙합 8", "힙합 9"},
    {"클래식", "클래식 1", "클래식 2", "클래식 3", "클래식 4", "클래식 5", "클래식 6", "클래식 7"},
    {"재즈", "재즈 1", "재즈 2", "재즈 3", "재즈 4", "재즈 5", "재즈 6", "재즈 7", "재즈 8"},
    {"OST", "영화 OST 1", "영화 OST 2", "드라마 OST 1", "드라마 OST 2", "게임 OST 1", "게임 OST 2", "애니 OST 1", "애니 OST 2"}
};

%>

<style>
/* 캐러셀 컨테이너 */
.carousel-container {
    position: relative;
    width: 96%;
    max-width: 95vw;
    background: #3D3D3D;
    border: 1px solid black;
    border-radius: 10px;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 15px;
    padding: 10px;
}

/* 캐러셀 버튼 */
.carousel-btn {
	display:none;
    position: relative;    
    background: none;
    color: white;
    border: none;
    cursor: pointer;
    padding: 10px;
    border-radius: 50%;
    font-size: 18px;
    font-weight: bold;
    z-index: 10;
}

.carousel-btn:hover {
    opacity: 0.4;
}

.carousel-btn-left {
    left: 4px;
}

.carousel-btn-right {
    right: 4px;
}

/* 가로 스크롤 적용 */
.carousel-track-container {
    width: 85%;
    overflow-x: hidden;   /* 수정 */
    white-space: nowrap;
    display: flex;
    align-items: center;
    scroll-behavior: smooth;
}

/* 캐러셀 아이템 배치 */
.carousel-wrapper {
	overflow-x: visible;
    display: flex;
    flex-direction: row;
    flex-wrap: nowrap;
    gap: 15px;
    width: max-content;
    height: 100%;
    align-items: center;
}

#song {
    writing-mode: vertical-lr;
    font-size: 1.8rem;
    margin-right: 12px;
    color: #F4A261;
    text-decoration: none;
    font-weight: bold;
}
</style>

<% 
// 🔄 반복문을 사용하여 캐러셀 컨테이너 생성
for (int i = 0; i < carousels.length; i++) {
    String sectionTitle = carousels[i][0]; // 섹션 제목
%>
    <div class="carousel-container" id="carousel-container-<%= i+1 %>">

        <a href="/" id="song"><%= sectionTitle %></a>
        <button class="carousel-btn carousel-btn-left" onclick="moveCarousel('<%= i+1 %>', -1)">&#9665;</button>
        
        <div class="carousel-track-container" id="carousel-track-container-<%= i+1 %>">
            <div class="carousel-wrapper" id="carousel-<%= i+1 %>">
                <% 
                // 🔹 각 캐러셀 내 아이템 생성
                for (int j = 1; j < carousels[i].length; j++) { 
                    String title = carousels[i][j];
                %>
                    <jsp:include page="/MainFrame/carousel-item.jsp">
                        <jsp:param name="title" value="<%= title %>"/>
                        <jsp:param name="thumbnail" value=""/>
                    </jsp:include>
                <% } %>
            </div>
        </div>
<button class="carousel-btn carousel-btn-right" onclick="moveCarousel('<%= i+1 %>', 1)">&#9655;</button>
 </div>
 
<% } %>
<script>

document.addEventListener("DOMContentLoaded", function () {
	
	document.querySelectorAll(".carousel-track-container").forEach(track => {
        let parent = track.parentElement;
        let leftBtn = parent.querySelector(".carousel-btn-left");
        let rightBtn = parent.querySelector(".carousel-btn-right");

        // 기본적으로 버튼 숨김

        // 마우스를 올리면 버튼 보이게 함
        parent.addEventListener("mouseenter", function () {
            if (leftBtn) leftBtn.style.display = "block";
            if (rightBtn) rightBtn.style.display = "block";
        });

        // 마우스를 벗어나면 다시 숨김
        parent.addEventListener("mouseleave", function () {
            if (leftBtn) leftBtn.style.display = "none";
            if (rightBtn) rightBtn.style.display = "none";
        });
    });
	
    console.log("📢 DOMContentLoaded 이벤트 감지! 캐러셀 초기화 시작...");
    
    document.querySelectorAll(".carousel-wrapper").forEach((wrapper, index) => {
        console.log(`📌 캐러셀 ${index + 1} ID: ${wrapper.id} → 아이템 개수: ${wrapper.children.length}`);
    });

    setTimeout(() => {
        document.querySelectorAll(".carousel-wrapper").forEach((wrapper, index) => {
            console.log(`✅ [2초 후] 캐러셀 ${index + 1} ID: ${wrapper.id} → 아이템 개수: ${wrapper.children.length}`);
        });
    }, 2000);
});

window.moveCarousel = function (carouselIndex, direction) {
	carouselIndex = parseInt(carouselIndex, 10);
	direction = parseInt(direction, 10); // 수정
    // 🚨 예외 처리: carouselIndex가 유효한 값인지 확인
    if (!carouselIndex || isNaN(carouselIndex)) {
        console.error(`❌ 오류: 올바른 'carouselIndex'가 전달되지 않았습니다. (${carouselIndex})`);
        return;
    }

    const carouselWrapper = document.getElementById("carousel-" + carouselIndex);
    const carouselListWrapper = document.getElementById("carousel-track-container-" + carouselIndex);
    
/*     const carouselWrapper = document.getElementById(`carousel-${carouselIndex}`); */

    if (!carouselWrapper) {
        console.error(`❌ 오류: ID 'carousel-${carouselIndex}' 요소를 찾을 수 없습니다.`);
        return;
    }

    const item = carouselWrapper.querySelector(".carousel-item");
    
    if (!item) {
        console.warn(`⚠️ 경고: 'carousel-${carouselIndex}' 내부에 아이템이 존재하지 않습니다.`);
        return;
    }

    const itemWidth = item.offsetWidth + 15; // 아이템 너비 + gap
    const maxScrollLeft = carouselWrapper.scrollWidth - carouselListWrapper.clientWidth;

    if (carouselWrapper.scrollWidth <= carouselListWrapper.clientWidth) {
        console.warn(`⚠️ 경고: 'carousel-${carouselIndex}'은(는) 스크롤할 필요가 없습니다.`);
        return;
    }
    let newScrollLeft = carouselListWrapper.scrollLeft + (itemWidth * direction);

    // 이동 제한 (왼쪽 끝 또는 오른쪽 끝)
    if (newScrollLeft < 0) {
        newScrollLeft = 0;
        console.warn(`🚫 왼쪽 끝입니다. 더 이상 이동할 수 없습니다.`);
    } else if (maxScrollLeft - newScrollLeft <= 10) {
        newScrollLeft = maxScrollLeft;
        console.warn(`🚫 오른쪽 끝입니다. 더 이상 이동할 수 없습니다.`);
    }

    console.log("📢 carousel-" + carouselIndex + "0이동 → newScrollLeft: " + newScrollLeft);

    // 부드러운 이동 적용
    smoothScroll(carouselListWrapper, newScrollLeft);
};

function smoothScroll(element, target) {
    let start = element.scrollLeft;
    let change = target - start;
    let duration = 100; // 이동 시간 (ms)
    let startTime = performance.now();

    function animateScroll(currentTime) {
        let elapsedTime = currentTime - startTime;
        let progress = Math.min(elapsedTime / duration, 1); // 0~1 사이 값 유지

        element.scrollLeft = start + (change * progress); // 선형 이동 적용

        if (progress < 1) {
            requestAnimationFrame(animateScroll);
        }
    }

    requestAnimationFrame(animateScroll);
}


</script>



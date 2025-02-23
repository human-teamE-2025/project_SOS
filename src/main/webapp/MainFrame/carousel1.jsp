	<%@ page language="java" contentType="text/html; charset=UTF-8"%>
	
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
	    overflow: hidden;
	    padding: 10px;
	}
	
	/* 캐러셀 버튼 */
	.carousel-btn {
	    position: absolute;
	    top: 50%;
	    transform: translateY(-50%);
		background:none;
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
	    opacity:0.4;
	}
	
	.carousel-btn-left {
	    left: 5px;
	}
	
	.carousel-btn-right {
	    right: 5px;
	}
	
	/* 가로 스크롤을 적용 */
	.carousel-track-container {
	    width: 85%;
	    overflow-x: hidden;
	    white-space: nowrap;
	    display: flex;
	    align-items: center;
	    scroll-behavior: smooth;
	}
	
	/* 캐러셀 아이템을 가로 배치 */
	.carousel-wrapper {
	    display: flex;
	    flex-direction: row;
	    flex-wrap: nowrap;
	    gap: 15px;
	    width: max-content;
	    height: 100%;
	    align-items: center;
	}
	
	/* 개별 캐러셀 아이템 */
	.carousel-item {
	    position: relative;
	    width: 180px;
	    height: 180px;
	    background: white;
	    display: flex;
	    align-items: center;
	    justify-content: center;
	    border: 3px solid #ddd;
	    border-radius: 8px;
	    overflow: hidden;
	    flex-shrink: 0;
	    transition: transform 0.3s ease-in-out;
	}
	
	/* 이미지 */
	.carousel-item img {
	    width: 100%;
	    height: 100%;
	    object-fit: cover;
	    transition: opacity 0.3s ease-in-out;
	}
	
	/* 설명(디스크립션) */
	.carousel-description {
	    position: absolute;
	    top: 50%;
	    left: 50%;
	    transform: translate(-50%, -50%);
	    background: rgba(0, 0, 0, 0.7);
	    color: white;
	    padding: 10px;
	    border-radius: 5px;
	    text-align: center;
	    font-size: 14px;
	    opacity: 0;
	    transition: opacity 0.3s ease-in-out;
	}
	
	/* 우측 하단의 더보기 & 재생 버튼 */
	.carousel-buttons {
	    position: absolute;
	    bottom: 10px;
	    right: 10px;
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
	
	/* 마우스 오버 시 효과 */
	.carousel-item:hover img {
	    opacity: 0.5;
	}
	
	.carousel-item:hover .carousel-description,
	.carousel-item:hover .carousel-buttons {
	    opacity: 1;
	}
	
	/* 해시태그 스타일 */
	#song {
	    writing-mode: vertical-lr;
	    font-size: 1.8rem;
	    margin-right: 12px;
	    color: #F4A261;;
	    text-decoration: none;
	    font-weight: bold;
	}
	
	.carousel-views {
	    position: absolute;
	    bottom: 8px;
	    left: 8px;
	    background: rgba(0, 0, 0, 0.6);
	    color: white;
	    padding: 4px 10px;
	    border-radius: 5px;
	    font-size: 12px;
	    display: flex;
	    align-items: center;
	    gap: 6px;  /* 아이콘과 숫자 간격 추가 */
	    white-space: nowrap; /* 텍스트 줄바꿈 방지 */
	    opacity: 0;
	    transition: opacity 0.3s ease-in-out;
	}
	
	.carousel-views i {
	    font-size: 14px;
	    color: white;
	    min-width: 16px;  /* 아이콘 최소 크기 보장 */
	}
	
	
	/* 게시 시간 (오른쪽 상단) */
	.carousel-date {
	    position: absolute;
	    top: 8px;
	    right: 8px;
	    background: rgba(0, 0, 0, 0.6);
	    color: white;
	    padding: 4px 8px;
	    border-radius: 5px;
	    font-size: 12px;
	    opacity: 0;
	    transition: opacity 0.3s ease-in-out;
	}
	
	/* 중앙 설명 (hover 시) */
	.carousel-description {
	    position: absolute;
	    top: 50%;
	    left: 50%;
	    transform: translate(-50%, -50%);
	    background: rgba(0, 0, 0, 0.7);
	    color: white;
	    padding: 10px;
	    border-radius: 5px;
	    text-align: center;
	    font-size: 14px;
	    opacity: 0;
	    transition: opacity 0.3s ease-in-out;
	    width: 80%;
	    max-width: 180px;
	}
	
	/* hover 효과 */
	.carousel-item:hover .carousel-description,
	.carousel-item:hover .carousel-buttons,
	.carousel-item:hover .carousel-views,
	.carousel-item:hover .carousel-date {
	    opacity: 1;
	}
	
	.carousel-container {
    flex-shrink: 0; /* 크기가 줄어들지 않도록 설정 */
    height: auto; /* 높이 자동 조절 */
    max-height: 50vh; /* 필요하면 최대 높이 설정 */
}

/* ✅ 캐러셀 내부 아이템 크기 자동 조절 */
.carousel-item {
    /* 요소가 내용에 맞춰 커지도록 설정 */
    min-height: 100%;
}

/* ✅ 필요하면 추가: 캐러셀 내부 요소에 고정 높이 제거 */
.carousel-content {
    height: auto !important;
    max-height: unset !important;
}
	</style>
	
	<!-- 캐러셀 컨테이너 -->
	<!-- 캐러셀 1 (유행중인) -->
	
	<div class="carousel-container" id="carousel-container-1">
	    <button class="carousel-btn carousel-btn-left" id="carousel1-btn-left">&#9665;</button>
	    <a href="/" id="song">#유행중인</a>
	    <div class="carousel-track-container">
	        <div class="carousel-wrapper" id="carousel1"></div>
	    </div>
	    <button class="carousel-btn carousel-btn-right" id="carousel1-btn-right">&#9655;</button>
	</div>
	
	<!-- 캐러셀 2 (추천곡) -->
	<div class="carousel-container" id="carousel-container-2">
	    <button class="carousel-btn carousel-btn-left" id="carousel2-btn-left">&#9665;</button>
	    <a href="/" id="song">#추천곡</a>
	    <div class="carousel-track-container">
	        <div class="carousel-wrapper" id="carousel2"></div>
	    </div>
	    <button class="carousel-btn carousel-btn-right" id="carousel2-btn-right">&#9655;</button>
	</div>
	
	<script>
	
document.addEventListener("DOMContentLoaded", function () {
    console.log("📢 DOMContentLoaded 이벤트 감지! 캐러셀 초기화 시작...");

    function setupCarousel(carouselId, leftBtnId, rightBtnId, data) {
        if (!carouselId) {
            console.error(`❌ setupCarousel 호출 시 carouselId가 없음`);
            return;
        }

        console.log("🚀 캐러셀 초기화 시작: ", carouselId);

        const carouselWrapper = document.getElementById(carouselId);
        if (!carouselWrapper) {
            console.error(`❌ 오류: ID '${carouselId}' 를 가진 요소를 찾을 수 없습니다.`);
            return;
        }

        const btnLeft = document.getElementById(leftBtnId);
        const btnRight = document.getElementById(rightBtnId);

        if (!btnLeft || !btnRight) {
            console.error(`❌ 오류: 캐러셀 버튼을 찾을 수 없습니다. (${leftBtnId}, ${rightBtnId})`);
            return;
        }

        console.log(`📌 받은 데이터 (${carouselId}):`, data);
        console.log(`🎯 총 아이템 개수: ${data.length}`);

        function initializeCarousel() {
            try {
                carouselWrapper.innerHTML = "";

                if (!data || data.length === 0) {
                    console.warn(`⚠️ 데이터 없음: ${carouselId}`);
                    let noDataMessage = document.createElement("p");
                    noDataMessage.style.color = "white";
                    noDataMessage.style.textAlign = "center";
                    noDataMessage.textContent = "데이터가 없습니다.";
                    carouselWrapper.appendChild(noDataMessage);
                    return;
                }

                data.forEach((item, index) => {
                    console.log(`🎯 [${carouselId}] 아이템 ${index + 1}:`, item);
                    console.log(`🔍 title 값:`, item.title, typeof item.title);
                    console.log(`🔍 artist 값:`, item.artist, typeof item.artist);
                    console.log(`🛠 item 객체의 키 목록:`, Object.keys(item));

                    let newItem = document.createElement("div");
                    newItem.classList.add("carousel-item");

                    let img = document.createElement("img");
                    img.src = item.thumbnail || "default.jpg";
                    img.alt = item.title || "제목 없음";

                    let description = document.createElement("div");
                    description.classList.add("carousel-description");

                    let titleText = document.createElement("b");
                    let safeTitle = (item.title && typeof item.title === "string") ? item.title : "제목 없음";
                    let safeArtist = (item.artist && typeof item.artist === "string") ? item.artist : "아티스트 없음";

                    // 🔹 `document.createTextNode()`로 값 강제 변환 (HTML 엔터티 오류 방지)
                    let titleNode = document.createTextNode(`${safeTitle} : ${safeArtist}`);
                    titleText.appendChild(titleNode);

                    let descText = document.createElement("p");
                    descText.textContent = item.description ? item.description : "설명 없음";

                    description.appendChild(titleText);
                    description.appendChild(descText);

                    let views = document.createElement("div");
                    views.classList.add("carousel-views");
                    let eyeIcon = document.createElement("i");
                    eyeIcon.classList.add("fa-solid", "fa-eye");
                    let viewsText = document.createElement("span");
                    viewsText.textContent = item.views !== undefined ? item.views.toLocaleString() : "0";
                    views.appendChild(eyeIcon);
                    views.appendChild(viewsText);

                    let date = document.createElement("div");
                    date.classList.add("carousel-date");
                    date.textContent = item.date || "날짜 없음";

                    let buttonContainer = document.createElement("div");
                    buttonContainer.classList.add("carousel-buttons");

                    let moreButton = document.createElement("button");
                    moreButton.textContent = "더보기";
                    moreButton.onclick = () => alert(`더보기 클릭: ${item.title}`);

                    let playButton = document.createElement("button");
                    playButton.textContent = "▶";
                    playButton.onclick = () => alert(`재생 클릭: ${item.title}`);

                    buttonContainer.appendChild(moreButton);
                    buttonContainer.appendChild(playButton);

                    newItem.appendChild(img);
                    newItem.appendChild(description);
                    newItem.appendChild(views);
                    newItem.appendChild(date);
                    newItem.appendChild(buttonContainer);

                    carouselWrapper.appendChild(newItem);
                });

                console.log(`🔎 ${carouselId} 최종 DOM 구조:`, carouselWrapper);

            } catch (error) {
                console.error(`🔥 오류 발생: ${error.message}`, error);
            }
        }

        initializeCarousel();
    }

    const trendingSongs = [
        { title: "노래 제목 1", artist: "아티스트 1", description: "이 노래는 정말 좋아요!", views: 125000, date: "2024-02-20", thumbnail: "picture1.jpg" },
        { title: "노래 제목 2", artist: "아티스트 2", description: "이 곡은 감성적인 분위기가 매력적이에요.", views: 89000, date: "2024-02-18", thumbnail: "picture2.jpg" }
    ];

    const recommendedSongs = [
        { title: "추천곡 1", artist: "가수 1", description: "이 곡을 추천합니다!", views: 68000, date: "2024-02-15", thumbnail: "picture3.jpg" },
        { title: "추천곡 2", artist: "가수 2", description: "감동적인 가사가 좋아요!", views: 54000, date: "2024-02-10", thumbnail: "picture4.jpg" }
    ];

    console.log("🔍 JSON 데이터 로드 확인:");
    console.log("📌 trendingSongs:", trendingSongs);
    console.log("📌 recommendedSongs:", recommendedSongs);

    setupCarousel("carousel1", "carousel1-btn-left", "carousel1-btn-right", trendingSongs);
    setupCarousel("carousel2", "carousel2-btn-left", "carousel2-btn-right", recommendedSongs);
});

</script>




<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    /* 캐러셀4 컨테이너 */
    .carousel-container4 {
        position: absolute;
        margin-top: 672px; /* 캐러셀3 아래에 배치 */
        width: 55vw;
        height: 180px;
        overflow: hidden;
        border: 1px solid black;
        padding: 10px;
        border-radius: 10px;
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
        display: flex;
        align-items: center;
        justify-content: center;
    }

    /* 슬라이드 컨테이너 */
    .carousel-track-container {
        width: 680px;
        overflow: hidden;
    }

    /* 슬라이드 래퍼 */
    .carousel-wrapper4 {
        display: flex;
        gap: 10px;
        transition: transform 0.5s ease-in-out;
        width: max-content;
    }

    /* 개별 캐러셀 아이템 */
    .carousel-item4 {
        width: 160px;
        height: 160px;
        background: white;
        display: flex;
        align-items: center;
        justify-content: center;
        border: 3px solid #fff;
        border-radius: 120px;
        overflow: hidden;
        flex-shrink: 0;
    }

    /* 이미지 크기 조정 */
    .carousel-item4 img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    /* 네비게이션 버튼 - 기본적으로 숨김 */
    .carousel-btn4 {
        position: absolute;
        background: rgba(255, 255, 255, 0.8);
        border: none;
        cursor: pointer;
        padding: 10px;
        border-radius: 50%;
        font-size: 18px;
        font-weight: bold;
        z-index: 10;
        display: none;
    }

    .carousel-btn4:hover {
        background: rgba(255, 255, 255, 1);
    }

    /* 왼쪽 버튼 */
    .carousel-btn-left4 {
        left: 10px;
    }

    /* 오른쪽 버튼 */
    .carousel-btn-right4 {
        right: 10px;
    }

    /* 캐러셀 컨테이너에 마우스를 올리면 버튼 표시 */
    .carousel-container4:hover .carousel-btn4,
    .carousel-container4:focus-within .carousel-btn4 {
        display: block;
    }

    /* 해시태그 스타일 */
    #artist4 {
        writing-mode: vertical-lr;
        font-size: 2rem;
        position: fixed;
        margin-left: 50%;
        color: black;
    }
</style>

<!-- 캐러셀4 컨테이너 -->
<div class="carousel-container4" id="carouselContainer4">
    <a href="/" id="artist4">#겨울</a>

    <button class="carousel-btn4 carousel-btn-left4" onclick="prevSlide4()">&#9665;</button>
    <div class="carousel-track-container">
        <div class="carousel-wrapper4" id="carousel4">
            <div class="carousel-item4"><img src="${pageContext.request.contextPath}/picture1.jpg" alt="Image 1"></div>
            <div class="carousel-item4"><img src="${pageContext.request.contextPath}/picture2.jpg" alt="Image 2"></div>
            <div class="carousel-item4"><img src="${pageContext.request.contextPath}/picture3.jpg" alt="Image 3"></div>
            <div class="carousel-item4"><img src="${pageContext.request.contextPath}/picture4.jpg" alt="Image 4"></div>
            <div class="carousel-item4"><img src="${pageContext.request.contextPath}/picture5.jpg" alt="Image 5"></div>
            <div class="carousel-item4"><img src="${pageContext.request.contextPath}/picture6.jpg" alt="Image 6"></div>
        </div>
    </div>
    <button class="carousel-btn4 carousel-btn-right4" onclick="nextSlide4()">&#9655;</button>
</div>

<script>
    let isAnimating4 = false;
    const carousel4 = document.getElementById("carousel4");
    const itemWidth4 = 170; // 아이템 크기 + gap(10px)

    function nextSlide4() {
        if (isAnimating4) return;
        isAnimating4 = true;

        carousel4.style.transition = "transform 0.5s ease-in-out";
        carousel4.style.transform = `translateX(-${itemWidth4}px)`;

        setTimeout(() => {
            let firstItem = carousel4.children[0];
            carousel4.appendChild(firstItem);
            carousel4.style.transition = "none";
            carousel4.style.transform = "translateX(0)";

            requestAnimationFrame(() => {
                isAnimating4 = false;
            });
        }, 500);
    }

    function prevSlide4() {
        if (isAnimating4) return;
        isAnimating4 = true;

        let lastItem = carousel4.children[carousel4.children.length - 1];
        carousel4.insertBefore(lastItem, carousel4.firstChild);

        carousel4.style.transition = "none";
        carousel4.style.transform = `translateX(-${itemWidth4}px)`;

        requestAnimationFrame(() => {
            carousel4.style.transition = "transform 0.5s ease-in-out";
            carousel4.style.transform = "translateX(0)";

            setTimeout(() => {
                isAnimating4 = false;
            }, 500);
        });
    }
</script>

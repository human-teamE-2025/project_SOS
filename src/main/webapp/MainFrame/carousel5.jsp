<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    /* 캐러셀5 컨테이너 */
    .carousel-container5 {
        position: absolute;
        margin-top: 912px; /* 캐러셀4 아래에 배치 */
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
    .carousel-wrapper5 {
        display: flex;
        gap: 10px;
        transition: transform 0.5s ease-in-out;
        width: max-content;
    }

    /* 개별 캐러셀 아이템 */
    .carousel-item5 {
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
    .carousel-item5 img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    /* 네비게이션 버튼 - 기본적으로 숨김 */
    .carousel-btn5 {
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

    .carousel-btn5:hover {
        background: rgba(255, 255, 255, 1);
    }

    /* 왼쪽 버튼 */
    .carousel-btn-left5 {
        left: 10px;
    }

    /* 오른쪽 버튼 */
    .carousel-btn-right5 {
        right: 10px;
    }

    /* 캐러셀 컨테이너에 마우스를 올리면 버튼 표시 */
    .carousel-container5:hover .carousel-btn5,
    .carousel-container5:focus-within .carousel-btn5 {
        display: block;
    }

    /* 해시태그 스타일 */
    #artist5 {
        writing-mode: vertical-lr;
        font-size: 2rem;
        position: fixed;
        margin-left: 50%;
        color: black;
    }
</style>

<!-- 캐러셀5 컨테이너 -->
<div class="carousel-container5" id="carouselContainer5">
    <a href="/" id="artist5">#봄</a>

    <button class="carousel-btn5 carousel-btn-left5" onclick="prevSlide5()">&#9665;</button>
    <div class="carousel-track-container">
        <div class="carousel-wrapper5" id="carousel5">
            <div class="carousel-item5"><img src="${pageContext.request.contextPath}/picture1.jpg" alt="Image 1"></div>
            <div class="carousel-item5"><img src="${pageContext.request.contextPath}/picture2.jpg" alt="Image 2"></div>
            <div class="carousel-item5"><img src="${pageContext.request.contextPath}/picture3.jpg" alt="Image 3"></div>
            <div class="carousel-item5"><img src="${pageContext.request.contextPath}/picture4.jpg" alt="Image 4"></div>
            <div class="carousel-item5"><img src="${pageContext.request.contextPath}/picture5.jpg" alt="Image 5"></div>
            <div class="carousel-item5"><img src="${pageContext.request.contextPath}/picture6.jpg" alt="Image 6"></div>
        </div>
    </div>
    <button class="carousel-btn5 carousel-btn-right5" onclick="nextSlide5()">&#9655;</button>
</div>

<script>
    let isAnimating5 = false;
    const carousel5 = document.getElementById("carousel5");
    const itemWidth5 = 170; // 아이템 크기 + gap(10px)

    function nextSlide5() {
        if (isAnimating5) return;
        isAnimating5 = true;

        carousel5.style.transition = "transform 0.5s ease-in-out";
        carousel5.style.transform = `translateX(-${itemWidth5}px)`;

        setTimeout(() => {
            let firstItem = carousel5.children[0];
            carousel5.appendChild(firstItem);
            carousel5.style.transition = "none";
            carousel5.style.transform = "translateX(0)";

            requestAnimationFrame(() => {
                isAnimating5 = false;
            });
        }, 500);
    }

    function prevSlide5() {
        if (isAnimating5) return;
        isAnimating5 = true;

        let lastItem = carousel5.children[carousel5.children.length - 1];
        carousel5.insertBefore(lastItem, carousel5.firstChild);

        carousel5.style.transition = "none";
        carousel5.style.transform = `translateX(-${itemWidth5}px)`;

        requestAnimationFrame(() => {
            carousel5.style.transition = "transform 0.5s ease-in-out";
            carousel5.style.transform = "translateX(0)";

            setTimeout(() => {
                isAnimating5 = false;
            }, 500);
        });
    }
</script>

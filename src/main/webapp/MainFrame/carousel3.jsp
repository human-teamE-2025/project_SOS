<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    /* 캐러셀3 컨테이너 */
    .carousel-container3 {
        position: absolute;
        margin-top: 468px; /* 캐러셀2 아래에 배치 */
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
    .carousel-wrapper3 {
        display: flex;
        gap: 10px;
        transition: transform 0.5s ease-in-out;
        width: max-content;
    }

    /* 개별 캐러셀 아이템 */
    .carousel-item3 {
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
    .carousel-item3 img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    /* 네비게이션 버튼 - 기본적으로 숨김 */
    .carousel-btn3 {
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

    .carousel-btn3:hover {
        background: rgba(255, 255, 255, 1);
    }

    /* 왼쪽 버튼 */
    .carousel-btn-left3 {
        left: 10px;
    }

    /* 오른쪽 버튼 */
    .carousel-btn-right3 {
        right: 10px;
    }

    /* 캐러셀 컨테이너에 마우스를 올리면 버튼 표시 */
    .carousel-container3:hover .carousel-btn3,
    .carousel-container3:focus-within .carousel-btn3 {
        display: block;
    }

    /* 해시태그 스타일 */
    #artist3 {
        writing-mode: vertical-lr;
        font-size: 2rem;
        position: fixed;
        margin-left: 50%;
        color: black;
    }
</style>

<!-- 캐러셀3 컨테이너 -->
<div class="carousel-container3" id="carouselContainer3">
    <a href="/" id="artist3">#가을</a>

    <button class="carousel-btn3 carousel-btn-left3" onclick="prevSlide3()">&#9665;</button>
    <div class="carousel-track-container">
        <div class="carousel-wrapper3" id="carousel3">
            <div class="carousel-item3"><img src="${pageContext.request.contextPath}/picture1.jpg" alt="Image 1"></div>
            <div class="carousel-item3"><img src="${pageContext.request.contextPath}/picture2.jpg" alt="Image 2"></div>
            <div class="carousel-item3"><img src="${pageContext.request.contextPath}/picture3.jpg" alt="Image 3"></div>
            <div class="carousel-item3"><img src="${pageContext.request.contextPath}/picture4.jpg" alt="Image 4"></div>
            <div class="carousel-item3"><img src="${pageContext.request.contextPath}/picture5.jpg" alt="Image 5"></div>
            <div class="carousel-item3"><img src="${pageContext.request.contextPath}/picture6.jpg" alt="Image 6"></div>
        </div>
    </div>
    <button class="carousel-btn3 carousel-btn-right3" onclick="nextSlide3()">&#9655;</button>
</div>

<script>
    let isAnimating3 = false;
    const carousel3 = document.getElementById("carousel3");
    const itemWidth3 = 170; // 아이템 크기 + gap(10px)

    function nextSlide3() {
        if (isAnimating3) return;
        isAnimating3 = true;

        carousel3.style.transition = "transform 0.5s ease-in-out";
        carousel3.style.transform = `translateX(-${itemWidth3}px)`;

        setTimeout(() => {
            let firstItem = carousel3.children[0];
            carousel3.appendChild(firstItem);
            carousel3.style.transition = "none";
            carousel3.style.transform = "translateX(0)";

            requestAnimationFrame(() => {
                isAnimating3 = false;
            });
        }, 500);
    }

    function prevSlide3() {
        if (isAnimating3) return;
        isAnimating3 = true;

        let lastItem = carousel3.children[carousel3.children.length - 1];
        carousel3.insertBefore(lastItem, carousel3.firstChild);

        carousel3.style.transition = "none";
        carousel3.style.transform = `translateX(-${itemWidth3}px)`;

        requestAnimationFrame(() => {
            carousel3.style.transition = "transform 0.5s ease-in-out";
            carousel3.style.transform = "translateX(0)";

            setTimeout(() => {
                isAnimating3 = false;
            }, 500);
        });
    }
</script>

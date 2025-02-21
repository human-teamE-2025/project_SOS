<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    /* 캐러셀2 컨테이너 */
    .carousel-container2 {
        position: absolute;
        margin-top: 264px;
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
    .carousel-wrapper2 {
        display: flex;
        gap: 10px;
        transition: transform 0.5s ease-in-out;
        width: max-content;
    }

    /* 개별 캐러셀 아이템 */
    .carousel-item2 {
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
    .carousel-item2 img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    /* 네비게이션 버튼 - 기본적으로 숨김 */
    .carousel-btn2 {
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

    .carousel-btn2:hover {
        background: rgba(255, 255, 255, 1);
    }

    /* 왼쪽 버튼 */
    .carousel-btn-left2 {
        left: 10px;
    }

    /* 오른쪽 버튼 */
    .carousel-btn-right2 {
        right: 10px;
    }

    /* 캐러셀 컨테이너에 마우스를 올리면 버튼 표시 */
    .carousel-container2:hover .carousel-btn2,
    .carousel-container2:focus-within .carousel-btn2 {
        display: block;
    }
    
            #artist{
        	writing-mode: vertical-lr;
        	font-size:2rem;
        	position:fixed;
        	margin-left: 50%;
        	color:black;
        }
</style>

<!-- 캐러셀2 컨테이너 -->
<div class="carousel-container2" id="carouselContainer2">
	<a href="/" id="artist">#여름</a>
	
    <button class="carousel-btn2 carousel-btn-left2" onclick="prevSlide2()">&#9665;</button>
    <div class="carousel-track-container">
        <div class="carousel-wrapper2" id="carousel2">
            <div class="carousel-item2"><img src="${pageContext.request.contextPath}/picture1.jpg" alt="Image 1"></div>
            <div class="carousel-item2"><img src="${pageContext.request.contextPath}/picture2.jpg" alt="Image 2"></div>
            <div class="carousel-item2"><img src="${pageContext.request.contextPath}/picture3.jpg" alt="Image 3"></div>
            <div class="carousel-item2"><img src="${pageContext.request.contextPath}/picture4.jpg" alt="Image 4"></div>
            <div class="carousel-item2"><img src="${pageContext.request.contextPath}/picture5.jpg" alt="Image 5"></div>
            <div class="carousel-item2"><img src="${pageContext.request.contextPath}/picture6.jpg" alt="Image 6"></div>
        </div>
    </div>
    <button class="carousel-btn2 carousel-btn-right2" onclick="nextSlide2()">&#9655;</button>
</div>

<script>
    let isAnimating2 = false;
    const carousel2 = document.getElementById("carousel2");
    const itemWidth2 = 170; // 아이템 크기 + gap(10px)

    function nextSlide2() {
        if (isAnimating2) return;
        isAnimating2 = true;

        carousel2.style.transition = "transform 0.5s ease-in-out";
        carousel2.style.transform = `translateX(-${itemWidth2}px)`;

        setTimeout(() => {
            let firstItem = carousel2.children[0];
            carousel2.appendChild(firstItem);
            carousel2.style.transition = "none";
            carousel2.style.transform = "translateX(0)";

            requestAnimationFrame(() => {
                isAnimating2 = false;
            });
        }, 500);
    }

    function prevSlide2() {
        if (isAnimating2) return;
        isAnimating2 = true;

        let lastItem = carousel2.children[carousel2.children.length - 1];
        carousel2.insertBefore(lastItem, carousel2.firstChild);

        carousel2.style.transition = "none";
        carousel2.style.transform = `translateX(-${itemWidth2}px)`;

        requestAnimationFrame(() => {
            carousel2.style.transition = "transform 0.5s ease-in-out";
            carousel2.style.transform = "translateX(0)";

            setTimeout(() => {
                isAnimating2 = false;
            }, 500);
        });
    }
</script>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <style>
        /* 캐러셀 컨테이너 */
        .carousel-container {
            position: absolute;
            margin-top: 60px;
            width: 55vw;
            height: 180px;
            overflow: hidden;
            background: transparent;
            border : 1px solid black;
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
        .carousel-wrapper {
            display: flex;
            gap: 10px;
            transition: transform 0.5s ease-in-out;
            width: max-content;
        }

        /* 개별 캐러셀 아이템 */
        .carousel-item {
            width: 160px;
            height: 160px;
            background: white;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 3px solid #fff;
            border-radius: 8px;
            overflow: hidden;
            flex-shrink: 0;
                        transition: transform 0.5s ease-in-out;
            
            
        }

        /* 이미지 크기 조정 */
        .carousel-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease-in-out;
        }
        .carousel-item img:hover {
            opacity: 0.7;
            cursor:pointer;
        }

        /* 네비게이션 버튼 - 기본적으로 숨김 */
        .carousel-btn {
            position: absolute;
            background: rgba(255, 255, 255, 0.8);
            border: none;
            cursor: pointer;
            padding: 10px;
            border-radius: 50%;
            font-size: 18px;
            font-weight: bold;
            z-index: 0;
            display: none; /* 기본적으로 숨김 */
            transition: transform 0.5s ease-in-out;
        }

        .carousel-btn:hover {
            background: rgba(255, 255, 255, 1);
        }

        /* 왼쪽 버튼 */
        .carousel-btn-left {
            left: 10px;
        }

        /* 오른쪽 버튼 */
        .carousel-btn-right {
            right: 10px;
        }

        /* 캐러셀 컨테이너에 마우스를 올리면 버튼 표시 */
        .carousel-container:hover .carousel-btn,
        .carousel-container:focus-within .carousel-btn {
            display: block;
        }
        #song{
        	writing-mode: vertical-lr;
        	font-size:2rem;
        	position:fixed;
        	margin-left: 50%;
        	color:black;
        }
        
    </style>


<!-- 캐러셀 컨테이너 -->
<div class="carousel-container" id="carouselContainer">
	<a href="/" id="song">#유행중인</a>
    <button class="carousel-btn carousel-btn-left" onclick="prevSlide()">&#9665;</button>
    <div class="carousel-track-container">
        <div class="carousel-wrapper" id="carousel">
            <div class="carousel-item"><img src="${pageContext.request.contextPath}/picture1.jpg" alt="Image 1"></div>
            <div class="carousel-item"><img src="${pageContext.request.contextPath}/picture2.jpg" alt="Image 2"></div>
            <div class="carousel-item"><img src="${pageContext.request.contextPath}/picture3.jpg" alt="Image 3"></div>
            <div class="carousel-item"><img src="${pageContext.request.contextPath}/picture4.jpg" alt="Image 4"></div>
            <div class="carousel-item"><img src="${pageContext.request.contextPath}/picture5.jpg" alt="Image 5"></div>
            <div class="carousel-item"><img src="${pageContext.request.contextPath}/picture6.jpg" alt="Image 6"></div>
        </div>
    </div>
    <button class="carousel-btn carousel-btn-right" onclick="nextSlide()">&#9655;</button>
</div>

<script>
    let isAnimating = false;
    const carousel = document.getElementById("carousel");
    const items = document.querySelectorAll(".carousel-item");
    const itemWidth = 170; // 아이템 크기 + gap(10px)

    function nextSlide() {
        if (isAnimating) return;
        isAnimating = true;

        carousel.style.transition = "transform 0.5s ease-in-out";
        carousel.style.transform = `translateX(-${itemWidth}px)`;

        setTimeout(() => {
            let firstItem = carousel.firstElementChild;
            carousel.appendChild(firstItem);
            carousel.style.transition = "none";
            carousel.style.transform = "translateX(0)";

            requestAnimationFrame(() => {
                isAnimating = false;
            });
        }, 100);
    }

    function prevSlide() {
        if (isAnimating) return;
        isAnimating = true;

        let lastItem = carousel.lastElementChild;
        carousel.insertBefore(lastItem, carousel.firstElementChild);

        carousel.style.transition = "none";
        carousel.style.transform = `translateX(-${itemWidth}px)`;

        requestAnimationFrame(() => {
            carousel.style.transition = "transform 0.5s ease-in-out";
            carousel.style.transform = "translateX(0)";

            setTimeout(() => {
                isAnimating = false;
            }, 100);
        });
    }
</script>

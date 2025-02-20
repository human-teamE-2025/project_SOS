<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
    @charset "UTF-8";

    /* ✅ left-nav-mine (기본적으로 숨김) */
    #left-nav-mine {
        display: none;
    }

    /* ✅ left-nav2 (기본적으로 숨김) */
    #left-nav2 {
        position: fixed;
        left: 0;
        top: 15vh;
        width: 60px;
        height: 79vh; /* 세로 길이 고정 유지 */
        background-color: #F8B400;
        border-right: 1px solid #ddd;
        overflow-y: auto;
        padding-top: 10px;
        transition: width 0.3s ease-in-out;
        display: none; /* ✅ 기본적으로 숨김 */
    }

    #left-nav2 button {
        background-color: transparent;
        text-align: center;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 10px 0;
        width: 100%;
        font-size: 0px;
        border: none;
        cursor: pointer;
        transition: background 0.2s ease-in-out;
    }

    #left-nav2 button img {
        width: 24px;
        height: 24px;
    }

    /* 아이콘 스타일 수정 */
    #left-nav2 button i {
        font-size: 1.5rem;
        color: #000; /* 아이콘 색상을 검정색으로 지정 */
    }

    /* 버튼 hover 효과 */
    #left-nav2 button:hover {
        background-color: rgba(0, 0, 0, 0.1);
    }
</style>

<!-- ✅ left-nav-mine -->
<div id="left-nav-mine"></div>

<!-- ✅ left-nav2 -->
<div id="left-nav2">
    <button class="btn-home">
        <i class="fa-solid fa-house"></i>
    </button>
    <button class="btn-mypage">
        <i class="fa-solid fa-user"></i>
    </button>
    <button class="btn-sub">
        <img src="${pageContext.request.contextPath}/static/img/favicon.ico">
    </button>
    <button class="btn-mymusic">
        <i class="fa-solid fa-compact-disc"></i>
    </button>
</div>

<!-- ✅ JavaScript 수정 -->
<script>
document.addEventListener("DOMContentLoaded", function() {
    const menuButton = document.getElementById("menu-button");
    const leftNav = document.getElementById("left-nav");
    const leftNavMine = document.getElementById("left-nav-mine");

    if (!menuButton || !leftNav || !leftNavMine) {
        console.error("⚠️ menu-button, left-nav 또는 left-nav-mine 요소를 찾을 수 없습니다.");
        return;
    }

    menuButton.addEventListener("click", function() {
        const isLeftNavHidden = window.getComputedStyle(leftNav).display === "none";

        if (isLeftNavHidden) {
            leftNav.style.display = "block";
            leftNavMine.style.display = "none";
        } else {
            leftNav.style.display = "none";
            leftNavMine.style.display = "block";
            leftNavMine.style.opacity = "1";  // ✅ 확실히 보이도록 설정
            leftNavMine.style.visibility = "visible"; // ✅ 숨김 상태 방지
        }
    });
});
</script>

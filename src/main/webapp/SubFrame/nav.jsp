<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/nav.css">
        
<nav>
    <div class="logo">
        <button class="logo-btn" onclick="window.location.href='${pageContext.request.contextPath}/index.jsp';"></button>
    </div>
    
    <div class="search-bar">
        <input type="text" placeholder="Search...">
        <button><i class="fas fa-search"></i></button>
    </div>

    <!-- ✅ menu 버튼 -->
    <div class="menu" id="menu-button" tabindex="0">
        <i class="fa-solid fa-bars"></i>
    </div>
    
    <div class="nav-button">            	
        <button id="b1"><i class="fa-solid fa-bell"></i></button>			
        <button id="b2"><i class="fas fa-sign-in-alt"></i></button>
    </div>
</nav>

<script>
document.addEventListener("DOMContentLoaded", function() {
    const menuButton = document.getElementById("menu-button"); // ✅ 메뉴 버튼
    const leftNav = document.getElementById("left-nav"); // ✅ 기존 사이드바
    const leftNavMine = document.getElementById("left-nav2"); // ✅ 최소화된 사이드바
	
    if (!menuButton || !leftNav || !leftNavMine) {
        console.error("⚠️ menu-button, left-nav 또는 left-nav-mine 요소를 찾을 수 없습니다.");
        return;
    }

    menuButton.addEventListener("click", function() {
        // ✅ 현재 display 상태를 정확하게 가져옴
        const isLeftNavHidden = window.getComputedStyle(leftNav).display === "none";
        leftNavMine.style.display = "block";

        if (isLeftNavHidden) {
            leftNav.style.display = "block";
            leftNavMine.style.display = "none";
        } else {
            leftNav.style.display = "none";
            leftNavMine.style.display = "block";
        }
    });
});

</script>

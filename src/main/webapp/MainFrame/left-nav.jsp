<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/left-nav.css">


<aside id="left-nav">
    <ul id="nav-item">
        <button id="btn-home"><i class="fa-solid fa-house"></i> 홈</button>
        <button id="btn-mypage" onclick="location.href='mypage.jsp'"><i class="fa-solid fa-user"></i> 내 페이지</button>
        <button id="btn-sub"><img src="${pageContext.request.contextPath}/static/img/favicon.ico"> 구독</button>
        <button id="btn-seen" onclick="location.href='view-index.jsp'"><i class="fa-solid fa-clock"></i> 시청기록</button>
        <button id="btn-mymusic"><i class="fa-solid fa-compact-disc"></i> 내가 올린 음악</button>
        <button id="btn-playlist"><i class="fa-solid fa-list"></i> 플레이 리스트</button>
        <hr>

        <div id="artist-section">
            <%
                int artistCount = 20; // 원하는 아티스트 개수 설정
                for (int i = 1; i <= artistCount; i++) {
            %>
                <button class="btn-artist"><i class="fa-solid fa-music"></i> 아티스트 <%= i %></button>
            <%
                }
            %>
        </div>
    </ul>
</aside>
<script>
document.addEventListener("DOMContentLoaded", function () {
    const menuButton = document.querySelector(".menu");
    const leftNav = document.getElementById("left-nav");
    const artistSection = document.getElementById("artist-section");
    const myPageButton = document.getElementById("btn-mypage");
    const myMusicButton = document.getElementById("btn-mymusic");
    const playListButton = document.getElementById("btn-playlist");
    function checkMobile() {
        if (window.innerWidth <= 768) {
            leftNav.classList.add("collapsed");
            leftNav.style.display = "flex"; // 모바일 기본 상태 유지
            artistSection.classList.add("hidden");
            
            myPageButton.innerHTML = '<i class="fa-solid fa-user"></i> 내<br>페이지';
            myMusicButton.innerHTML = '<i class="fa-solid fa-compact-disc"></i> 내가<br>올린 음악';
            playListButton.innerHTML = '<i class="fa-solid fa-list"></i> 플레이<br>리스트';
        } else {
            leftNav.classList.remove("collapsed", "hidden");
            leftNav.style.display = "flex"; // 데스크톱에서는 항상 보이게
        }
    }

    checkMobile(); // 초기 실행
    window.addEventListener("resize", checkMobile); // 창 크기 변경 시 적용

    menuButton.addEventListener("click", function () {

        if (window.innerWidth <= 768) {
            if (leftNav.style.display === "none" || leftNav.classList.contains("hidden")) {
                leftNav.style.display = "flex";
                setTimeout(() => leftNav.classList.remove("hidden"), 10);
            } else {
                leftNav.classList.add("hidden");
                setTimeout(() => leftNav.style.display = "none", 300);
            }
        } else {
            // 데스크톱 환경에서는 collapsed 토글
            leftNav.classList.toggle("collapsed");
            artistSection.classList.toggle("hidden");

            if (leftNav.classList.contains("collapsed")) {
                myPageButton.innerHTML = '<i class="fa-solid fa-user"></i> 내<br>페이지';
                myMusicButton.innerHTML = '<i class="fa-solid fa-compact-disc"></i> 내가<br>올린 음악';
                playListButton.innerHTML = '<i class="fa-solid fa-list"></i> 플레이<br>리스트';
            } else {
                myPageButton.innerHTML = '<i class="fa-solid fa-user"></i> 내 페이지';
                myMusicButton.innerHTML = '<i class="fa-solid fa-compact-disc"></i> 내가 올린 음악';
                playListButton.innerHTML = '<i class="fa-solid fa-list"></i> 플레이 리스트';
            }
        }
    });
});
</script>



<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<head>
    <link rel="stylesheet" type="text/css" href="./MainFrame/left-nav.css">
</head>

<aside id="left-nav">
    <ul id="nav-item">
        <button id="btn-home"><i class="fa-solid fa-house"></i> 홈</button>
        <button id="btn-mypage" onclick="location.href='mypage.jsp'"><i class="fa-solid fa-user"></i> 내 페이지</button>
        <button id="btn-sub"><img src="${pageContext.request.contextPath}/static/img/favicon.ico"> 구독</button>
        <button id="btn-seen"><i class="fa-solid fa-clock"></i> 시청기록</button>
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

    menuButton.addEventListener("click", function () {
        leftNav.classList.toggle("collapsed");
        artistSection.classList.toggle("hidden");
        
        const myPageButton = document.getElementById("btn-mypage");
        const myMusicButton = document.getElementById("btn-mymusic");
        const playListButton = document.getElementById("btn-playlist");

        if (leftNav.classList.contains("collapsed")) {
            myPageButton.innerHTML = '<i class="fa-solid fa-user"></i> 내<br>페이지';
            myMusicButton.innerHTML = '<i class="fa-solid fa-compact-disc"></i> 내가<br>올린 음악';
            playListButton.innerHTML = '<i class="fa-solid fa-list"></i> 플레이<br>리스트';
        } else {
            myPageButton.innerHTML = '<i class="fa-solid fa-user"></i> 내 페이지';
            myMusicButton.innerHTML = '<i class="fa-solid fa-compact-disc"></i> 내가 올린 음악';
            playListButton.innerHTML = '<i class="fa-solid fa-list"></i> 플레이 리스트';
        }
        
    });
});



</script>
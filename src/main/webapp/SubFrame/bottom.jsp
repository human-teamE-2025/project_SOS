<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bottom.css">

<section id="bottom">
    <aside id="musicbar">
        <button class="play" id="backplay"><i class="fa-solid fa-backward"></i></button>
        <button class="play" id="play"><i class="fa-solid fa-play"></i></button>
        <button class="play" id="fowardplay"><i class="fa-solid fa-forward"></i></button>
    </aside>

    <footer>
        <a href="${pageContext.request.contextPath}/about.jsp?section=company">회사소개</a>&emsp;|&emsp;
        <a href="${pageContext.request.contextPath}/about.jsp?section=terms">이용약관</a>&emsp;|&emsp;
        <a href="${pageContext.request.contextPath}/about.jsp?section=privacy">개인정보처리방침</a>&emsp;
        Copyright © 2025 All rights reserved.
    </footer>

    <aside id="settingbar">
        <button class="play" id="backplay"><i class="fa-solid fa-volume-high"></i></button>
        <button class="play" id="play"><i class="fa-solid fa-sliders"></i></button>
        <button class="play" id="fowardplay"><i class="fa-solid fa-repeat"></i></button>
    </aside>
</section>

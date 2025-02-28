<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/mypage1.css">


			
			<div id="main-container">
			<%@ include file="./left-nav.jsp" %>
			
			<div id="main-con">
				
						
	<main>
	<section class="section">
	<div id="member-container">
	    <div class="member" style="width: 35vw; height: 23vh;">
	            <h3 id="pay-1">내 요금제</h3>
	            <h1 id="nomal">일반회원</h1>
	            <p id="day">요금 청구 날짜: 2025년 5월 23일</p>
	            <p id="card">뒷번호 ****인 visa 카드</p>
	        </div>
	        <div class="edit" style="width: 16vw; height: 23vh;">
	            <img src="./static/img/profile.png" style="width: 20vh; height: 20vh;">
	        </div>
	    </div>
	
	    <div class="set" style="width: 52vw; height: 18vh;">
	    	<div class="left">계정</div>
	       	<div class="row">
	        	<img src="./static/img/pen.png" style="width:32px; height: 32px">
	        <span class="my-txt">프로필편집</span>
	       		<button class="icon" style="width:32px; height: 32px"><img src="./static/img/gobutton.png" style="width:32px; height: 32px"></button> 
	       	</div>
	        <div class="row">
	        	<img src="./static/img/gear.png" style="width:32px; height: 32px">
	        <span class="my-txt">설정</span>
	       		<button class="icon" style="width:32px; height: 32px"><img src="./static/img/gobutton.png" style="width:32px; height: 32px"></button> 
	        </div>
	    </div>
	
	    <div class="switch" style="width: 52vw; height: 18vh;">
	   		<div class="left">보안</div>
	        <div class="row">
	        	<img src="./static/img/lock.png" style="width:32px; height: 32px">
	        <span class="my-txt">ID/PW 변경</span>
	       		<button class="icon" style="width:32px; height: 32px"><img src="./static/img/gobutton.png" style="width:32px; height: 32px"></button> 
	        </div>
	        <div class="row">
	        	<img src="./static/img/power.png" style="width:32px; height: 32px">
	      		<span class="my-txt">로그아웃 </span>
	       		<button class="icon" style="width:32px; height: 32px"><img src="./static/img/gobutton.png" style="width:32px; height: 32px"></button> 
	        </div>
	    </div>
	
	    <div class="use" style="width: 52vw; height: 10vh;">
	    	<div class="row-terms">
	          <span id="sos" style="font-family: 'League Gothic', sans-serif; font-size: 35px; color:#282828">Song of Senses&nbsp;&nbsp;<a id="policy">이용정책</a></span>
	       		<a href="#" class="icon"><img src="./static/img/gobutton.png" style="width:32px; height: 32px"></a>
    	</div>
    </div>
</section>	
				</main>
				<%@ include file="./right-sections.jsp" %>

			</div>
			</div>
			<%@ include file="./upload/mobile-upload-button.jsp" %>
			
			
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/right-sections.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">



    <section id="right-sections">
        <!-- 게시판 헤더 -->
<div class="board-header">
    <span>게시판</span>
        <%@ include file="./upload/upload-button.jsp" %>  <!-- ✅ 업로드 버튼 포함 -->

</div>


        <!-- 게시판 게시글 목록 -->
        <div class="board-content">
				<div class="post">
    	<div class="post-content">
        <div class="post-title">여기는 게시글 제목이 적혀지는 구역입니다</div>
        <div class="post-info">
            <i class="fa-solid fa-user"></i> 작성자 
            <i class="fa-solid fa-eye"></i> 조회수 
            <i class="fa-solid fa-calendar"></i> 등록일
        </div>
  	  </div>
 		   <div class="post-thumbnail"></div> <!-- ✅ 랜덤 색상 썸네일 추가 -->
		</div>
						<div class="post">
    	<div class="post-content">
        <div class="post-title">여기는 게시글 제목이 적혀지는 구역입니다</div>
        <div class="post-info">
            <i class="fa-solid fa-user"></i> 작성자 
            <i class="fa-solid fa-eye"></i> 조회수 
            <i class="fa-solid fa-calendar"></i> 등록일
        </div>
  	  </div>
 		   <div class="post-thumbnail"></div> <!-- ✅ 랜덤 색상 썸네일 추가 -->
		</div>
						<div class="post">
    	<div class="post-content">
        <div class="post-title">여기는 게시글 제목이 적혀지는 구역입니다</div>
        <div class="post-info">
            <i class="fa-solid fa-user"></i> 작성자 
            <i class="fa-solid fa-eye"></i> 조회수 
            <i class="fa-solid fa-calendar"></i> 등록일
        </div>
  	  </div>
 		   <div class="post-thumbnail"></div> <!-- ✅ 랜덤 색상 썸네일 추가 -->
		</div>
						<div class="post">
    	<div class="post-content">
        <div class="post-title">여기는 게시글 제목이 적혀지는 구역입니다</div>
        <div class="post-info">
            <i class="fa-solid fa-user"></i> 작성자 
            <i class="fa-solid fa-eye"></i> 조회수 
            <i class="fa-solid fa-calendar"></i> 등록일
        </div>
  	  </div>
 		   <div class="post-thumbnail"></div> <!-- ✅ 랜덤 색상 썸네일 추가 -->
		</div>
						<div class="post">
    	<div class="post-content">
        <div class="post-title">여기는 게시글 제목이 적혀지는 구역입니다</div>
        <div class="post-info">
            <i class="fa-solid fa-user"></i> 작성자 
            <i class="fa-solid fa-eye"></i> 조회수 
            <i class="fa-solid fa-calendar"></i> 등록일
        </div>
  	  </div>
 		   <div class="post-thumbnail"></div> <!-- ✅ 랜덤 색상 썸네일 추가 -->
		</div>
						<div class="post">
    	<div class="post-content">
        <div class="post-title">여기는 게시글 제목이 적혀지는 구역입니다</div>
        <div class="post-info">
            <i class="fa-solid fa-user"></i> 작성자 
            <i class="fa-solid fa-eye"></i> 조회수 
            <i class="fa-solid fa-calendar"></i> 등록일
        </div>
  	  </div>
 		   <div class="post-thumbnail"></div> <!-- ✅ 랜덤 색상 썸네일 추가 -->
		</div>
						<div class="post">
    	<div class="post-content">
        <div class="post-title">여기는 게시글 제목이 적혀지는 구역입니다</div>
        <div class="post-info">
            <i class="fa-solid fa-user"></i> 작성자 
            <i class="fa-solid fa-eye"></i> 조회수 
            <i class="fa-solid fa-calendar"></i> 등록일
        </div>
  	  </div>
 		   <div class="post-thumbnail"></div> <!-- ✅ 랜덤 색상 썸네일 추가 -->
		</div>
								<div class="post">
    	<div class="post-content">
        <div class="post-title">여기는 게시글 제목이 적혀지는 구역입니다</div>
        <div class="post-info">
            <i class="fa-solid fa-user"></i> 작성자 
            <i class="fa-solid fa-eye"></i> 조회수 
            <i class="fa-solid fa-calendar"></i> 등록일
        </div>
  	  </div>
 		   <div class="post-thumbnail"></div> <!-- ✅ 랜덤 색상 썸네일 추가 -->
		</div>
								<div class="post">
    	<div class="post-content">
        <div class="post-title">여기는 게시글 제목이 적혀지는 구역입니다</div>
        <div class="post-info">
            <i class="fa-solid fa-user"></i> 작성자 
            <i class="fa-solid fa-eye"></i> 조회수 
            <i class="fa-solid fa-calendar"></i> 등록일
        </div>
  	  </div>
 		   <div class="post-thumbnail"></div> <!-- ✅ 랜덤 색상 썸네일 추가 -->
		</div>
		
		
				
            
        </div>
    </section>
    
    <script>
    document.addEventListener("DOMContentLoaded", function () {
        const posts = document.querySelectorAll(".post-thumbnail"); // 썸네일 선택
        const gradients = [
            "linear-gradient(45deg, #FF6B6B, #FF8E53)", // 레드 → 오렌지
            "linear-gradient(45deg, #42A5F5, #478ED1)", // 블루 → 네이비
            "linear-gradient(45deg, #AB47BC, #8E24AA)", // 퍼플 → 다크 퍼플
            "linear-gradient(45deg, #26A69A, #2BBBAD)", // 민트 → 블루그린
            "linear-gradient(45deg, #FFA726, #FF7043)", // 오렌지 → 레드
            "linear-gradient(45deg, #EC407A, #D81B60)", // 핑크 → 다크 핑크
        ];

        posts.forEach(post => {
            const randomGradient = gradients[Math.floor(Math.random() * gradients.length)]; // 랜덤 선택
            post.style.background = randomGradient; // 배경 적용
        });
    });
</script>



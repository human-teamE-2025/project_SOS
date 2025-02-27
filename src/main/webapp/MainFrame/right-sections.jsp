<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/right-sections.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">


<style>
/* 기본 헤더 스타일 */
.board-header {
    position: relative;
    background: #333;
    padding: 12px 16px;
    border-radius: 8px;
    color: white;
    font-size: 18px;
    font-weight: bold;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: space-between;
    transition: 0.3s ease;
}

/* 드롭다운 메뉴 스타일 */
.dropdown-menu {
    position: absolute;
    top: 100%;
    left: 0;
    width: 100%;
    background: #222;
    border-radius: 8px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    display: none;
    flex-direction: column;
    margin-top: 6px;
    overflow: hidden;
}

/* 드롭다운 항목 스타일 */
.dropdown-item {
    padding: 12px 16px;
    color: white;
    text-align: center;
    transition: background 0.3s ease;
}

.dropdown-item:hover {
    background: #FFC107;
    color: black;
}

/* 드롭다운 활성화 */
.dropdown-menu.active {
    display: flex;
}
</style>

    <section id="right-sections">
        <!-- 게시판 헤더 -->
<div class="board-header" onclick="toggleDropdown()">
    <span id="board-title">실시간 ▽</span>
    <%@ include file="./upload/upload-button.jsp" %>  <!-- ✅ 업로드 버튼 포함 -->

    <!-- 드롭다운 옵션 -->
    <div id="board-dropdown" class="dropdown-menu">
        <div class="dropdown-item" onclick="selectBoardOption('실시간')">실시간</div>
        <div class="dropdown-item" onclick="selectBoardOption('재생목록')">재생목록</div>
        <div class="dropdown-item" onclick="selectBoardOption('게시판')">게시판</div>
    </div>
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
    function toggleDropdown() {
        document.getElementById("board-dropdown").classList.toggle("active");
    }

    function selectBoardOption(option) {
        document.getElementById("board-title").innerText = option + " ▽";
        document.getElementById("board-dropdown").classList.remove("active");
    }
    
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



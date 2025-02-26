<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/view-history.css">


			
			<div id="main-container">
			<%@ include file="./left-nav.jsp" %>
			
			<div id="main-con">
				
		<main>
		
		<section id="a-container">
		<h1>시청 기록</h1>

        <div class="a-section">
            
            <h2>오늘</h2>
            <br>
            <hr>
            <br>
            <div class="video-box1">
	            <div class="video"><video src="./static/img/Test.mp4" controls></video> 
	            </div>
					<div class="a-title">
					<p style="font-size: 25px">제목</p>
					<p style="font-size: 15px">내용</p></div>
					<div class="button-box-a">
					<button class="close-buttons">&times;</button>
					<button class="more-buttons">&#x22EE;</button>
					
				</div>
				
            </div>
            <br>
             <div class="video-box1">
	            <div class="video"><video src="./static/img/Test.mp4" controls></video> 
	            </div>
					<div class="a-title">
					<p style="font-size: 25px">제목</p>
					<p style="font-size: 15px">내용</p></div>
					<div class="button-box-a">
					<button class="close-buttons">&times;</button>
					<button class="more-buttons">&#x22EE;</button>
					
				</div>
				
            </div>
        </div>
 <div class="a-section">
            <h2>어제</h2>
            <br>
            <hr>
            <br>
            <div class="video-box1">
	            <div class="video"><video src="./static/img/Test.mp4" controls></video> 
	            </div>
					<div class="a-title">
					<p style="font-size: 25px">제목</p>
					<p style="font-size: 15px">내용</p></div>
					<div class="button-box-a">
					<button class="close-buttons">&times;</button>
					<button class="more-buttons">&#x22EE;</button>
					
				</div>
				
            </div>
            <br>
             <div class="video-box1">
	            <div class="video"><video src="./static/img/Test.mp4" controls></video> 
	            </div>
					<div class="a-title">
					<p style="font-size: 25px">제목</p>
					<p style="font-size: 15px">내용</p></div>
					<div class="button-box-a">
					<button class="close-buttons">&times;</button>
					<button class="more-buttons">&#x22EE;</button>
					
				</div>
				
            </div>
        </div>
		</section>
			</main>
				<%@ include file="./right-sections.jsp" %>

			</div>
			</div>
			<script>
			  /** ✅ 알림 팝업 보이기/숨기기 */
		 $(".close-buttons").click(function() {
    // 클릭된 버튼의 부모 요소인 .video-box1을 숨기기
    var videoBox = $(this).closest('.video-box1');
    videoBox.css("display", "none");

    // .video-box1이 모두 숨겨졌는지 체크
    var parentSection = videoBox.closest('.a-section');
    var visibleVideoBoxes = parentSection.find('.video-box1:visible');

    // .video-box1이 모두 숨겨졌으면 .a-section을 숨기기
    if (visibleVideoBoxes.length === 0) {
        parentSection.css("display", "none");
    }
});
		// 비디오
		 document.querySelectorAll('.play-buttons').forEach(button => {
			    button.addEventListener('click', function() {
			        var videoElement = this.closest('.video-box1').querySelector('video');
			        var pauseButton = this.closest('.video-box1').querySelector('.pause-buttons');
			        
			        videoElement.play(); // 비디오 재생
			        this.style.display = 'none'; // 재생 버튼 숨기기
			        pauseButton.style.display = 'block'; // 일시정지 버튼 보이기
			    });
			});

	
			</script>
			
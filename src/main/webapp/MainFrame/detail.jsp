
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/static/css/main-container.css">

<style>
main {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #000;
	color: white;
}

.container {
	width: 99%;
	margin: auto;
	background: black;
	padding: 20px;
	box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.7);
	border: 1px solid #ddd;
	border-radius: 10px;
}

.header {
	font-size: 24px;
	font-weight: bold;
	margin-bottom: 20px;
}

.album-info {
	display: flex;
	border: 1px solid #ddd;
	padding: 15px;
	border-radius: 10px;
}

.album-cover {
	width: 30%;
	text-align: center;
	display: grid;
  	place-items: center;
	
}

.album-cover img {
	width: 180px;
	height: 180px;	
	object-fit: cover;
	display: block;
	
}

.song-details {
	flex: 1;
	padding: 10px;
}

.song-title {
	font-size: 20px;
	font-weight: bold;
}

.song-meta {
	margin-top: 10px;
	font-size: 14px;
	color: white;
}

.follow-button {
	background-color: #FFC107;
	color: black;
	border: none;
	padding: 10px 20px;
	cursor: pointer;
	border-radius: 5px;
	margin-top: 10px;
}

.description, .comments {
	margin-top: 20px;
}

.description {
	border: 1px solid #ddd;
	padding: 15px;
	border-radius: 10px;
}

.comment-box-container {
	display: flex;
	align-items: center;
}

.comment-box {
	flex: 1;
	height: 50px;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 5px;
	background: black;
	color: white;
}

.submit-btn {
	background-color: #FFC107;
	color: black;
	border: none;
	padding: 10px 20px;
	cursor: pointer;
	border-radius: 5px;
	margin-left: 10px;
}

.comment-list {
	margin-top: 20px;
}

.comment {
	display: flex;
	align-items: center;
	margin-bottom: 10px;
	border-bottom: 1px solid #444;
	padding-bottom: 10px;
}

.comment img {
	width: 40px;
	height: 40px;
	border-radius: 50%;
	margin-right: 10px;
}

.comment-content {
	flex: 1;
}

.comment-author {
	font-weight: bold;
	margin-bottom: 5px;
}

#song-post {
	border-left: inset 2px;
	margin: 20px;
	padding: 20px;
	padding-left: 35px;
}

.follow-button {
	margin-bottom: 25px
}

.song-post {
	margin-top: 10px;
	font-size: 14px;
}

textarea {
	resize: none;
}

.comment-input{
	border: 1px solid #ddd;
	padding: 15px;
	border-radius: 10px;
}

.comment{
	border-bottom: 1px solid #ddd;
	padding: 15px;
}

@media screen and (max-width: 768px) {
	.album-info {
		flex-direction: column;
		align-items: center;
		text-align: center;
	}

	.album-cover {
		width: 100%;
	}

	.album-cover img {
		width: 100%;
		max-width: 200px;
		height: auto;
	}

	.song-details {
		width: 100%;
	}

	.comment-box-container {
		flex-direction: column;
	}

	.submit-btn {
		margin-left: 0;
		margin-top: 10px;
		width: 100%;
	}

	.comment {
		flex-direction: column;
		align-items: flex-start;
	}

	.comment img {
		margin-bottom: 10px;
	}

	.comment-box {
		width: 100%;
	}
}

@media screen and (max-width: 480px) {
	.header {
		font-size: 20px;
	}

	.song-title {
		font-size: 18px;
	}

	.song-meta {
		font-size: 12px;
	}

	.follow-button {
		width: 100%;
		padding: 12px;
	}
}
</style>



<div id="main-container">
	<%@ include file="./left-nav.jsp"%>

	<div id="main-con">
		<main>
			<div class="container">
				<div class="header">앨범 정보</div>

				<div class="album-info">
					<div class="album-cover">
						<img src="static/img/picture1.jpg" alt="앨범 커버">
					</div>
					<div class="song-details">
						<div class="song-title">노래 제목</div>
						<div class="song-meta">아티스트: 아티스트</div>
						<div class="song-meta">앨범명: 앨범명</div>
						<div class="song-meta">발매일: YYYY-MM-DD</div>
						<div class="song-meta">장르: 장르명</div>
						<div class="song-meta">작곡: 작곡가</div>
						<div class="song-meta">작사: 작사가</div>
						<div class="song-meta">재생시간: 03:18</div>
					</div>
					<div id="song-post">
						<button class="follow-button" type="button">팔로우</button>
						<div class="song-post">노래게시자</div>
						<div class="song-post">노래게시시간</div>
					</div>
				</div>



				<div class="description">
					<h3>앨범 소개</h3>
					<p>앨범 설명 앨범 설명 앨범 설명 앨범 설명 앨범 설명 앨범 설명 앨범 설명 앨범 설명 앨범 설명 앨범 설명 앨범
						설명 앨범 설명 앨범 설명 앨범 설명 앨범 설명 앨범 설명 앨범 설명 앨범 설명 앨범 설명 앨범 설명 앨범 설명 앨범
						설명 앨범 설명 앨범 설명 앨범 설명 앨범 설명 앨범 설명 앨범 설명 앨범 설명 앨범 설명 앨범 설명 앨범 설명 앨범
						설명 앨범 설명 앨범 설명 앨범 설명 앨범 설명 앨범 설명 앨범 설명 앨범 설명 앨범 설명 앨범 설명 앨범 설명 앨범
						설명 앨범 설명 앨범 설명 앨범 설명 앨범 설명 앨범 설명 앨범 설명 앨범 설명</p>
				</div>

				<div class="comments">
					<div class="comment-input">
						<h3>댓글</h3>
						<div class="comment-box-container">
							<textarea class="comment-box" placeholder="댓글을 입력하세요"></textarea>
							<button class="submit-btn" type="submit">등록</button>
						</div>
					</div>
					<div class="comment-list">
						<div class="comment">
							<img src="프로필사진" alt="프로필">
							<div class="comment-content">
								<div class="comment-author">닉네임</div>
								<div class="comment-text">댓글 내용</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</main>
		<%@ include file="./right-sections.jsp"%>

	</div>
</div>
<%@ include file="./upload/mobile-upload-button.jsp"%>


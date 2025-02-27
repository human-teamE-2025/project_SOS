<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
/* 컨테이너 스타일 */
#custom-upload-container {
	display:flex;
    background: #222;
    padding: 30px;
    border-radius: 12px;
    color: white;
    max-width: 600px;
    margin: auto;
    box-shadow: 0 0 15px rgba(255, 255, 255, 0.1);
}
#custom-music-upload{
	display:flex;

	flex-direction: column;
		gap :4px;
}

/* 타이틀 */
.custom-upload-title {
    text-align: center;
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 20px;
    color: #FFC107;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
}

/* 입력 필드 공통 스타일 */
.custom-upload-input, 
.custom-upload-select, 
.custom-upload-textarea {
    padding: 12px;
    border-radius: 8px;
    border: 1px solid #777;
    background: #333;
    color: white;
    font-size: 16px;
    width: 100%;
    max-width: 550px;
    transition: 0.3s ease;
}

/* 포커스 효과 */
.custom-upload-input:focus, 
.custom-upload-select:focus, 
.custom-upload-textarea:focus {
    border-color: #FFC107;
    outline: none;
    box-shadow: 0 0 8px rgba(255, 193, 7, 0.5);
}

/* 파일 선택 버튼 */
.custom-upload-input[type="file"] {
    padding: 12px;
    height: 45px;
    cursor: pointer;
}

/* 라디오 버튼 그룹 */
.custom-radio-group {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    margin-top:12px;
    margin-bottom:12px;
    gap: 12px;
    padding: 15px;
    background: #333;
    border-radius: 8px;
    width: 100%;
    max-width: 550px;
}

/* 썸네일 색상 선택 */
.custom-thumbnail-container {
    display: flex;
    align-items: center;
    gap: 15px;
    width: 100%;
    max-width: 550px;
}

.custom-thumbnail-preview {
    width: 60px;
    height: 60px;
    border-radius: 10px;
    display: flex;
    justify-content: center;
    align-items: center;
    overflow: hidden;
    background: #666;
    flex-shrink: 0;
    border: 2px solid #FFC107;
}

/* 장르 선택 */
.custom-upload-select {
    flex: 1;
    min-width: 200px;
}

/* 설명 입력란 */
.custom-description-container {
    display: flex;
    flex-direction: column;
    width: 100%;
    max-width: 550px;
}

.custom-upload-textarea {
    flex: 1;
    min-height: 90px;
    resize: vertical;
}

/* 분위기 태그 */
.custom-mood-tags {
    display: flex;
    flex-wrap: wrap;
    gap: 8px;
    max-width: 550px;
    justify-content: center;
}

.custom-mood-tags label {
    background: #444;
    padding: 10px 14px;
    border-radius: 6px;
    color: white;
    cursor: pointer;
    font-size: 14px;
    transition: 0.3s ease;
    border: 1px solid #666;
}

.custom-mood-tags input:checked + label {
    background: #FFC107;
    color: black;
    font-weight: bold;
    border: 1px solid #FFB300;
}

.custom-mood-tags input {
    display: none;
}

/* 최종 업로드 버튼 */
.custom-upload-button {
    background: linear-gradient(90deg, #FFC107, #FFA000);
    color: black;
    padding: 14px;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    font-size: 18px;
    transition: 0.3s ease;
    width: 100%;
    max-width: 550px;
    text-align: center;
    font-weight: bold;
}

.custom-upload-button:hover {
    background: linear-gradient(90deg, #FFB300, #FF8C00);
    box-shadow: 0 4px 10px rgba(255, 193, 7, 0.5);
}
</style>

<div id="custom-upload-container">
    <form id="custom-music-upload" class="custom-upload-form" enctype="multipart/form-data">
        <h2 class="custom-upload-title">🎵 노래 업로드</h2>
    
        <label>음악 파일 업로드 :</label>
        <input type="file" id="custom-music-file" class="custom-upload-input" name="music-file" accept=".mp3, .wav, .aac" required>

        <div class="custom-radio-group">
            <label for="national">국내음악</label>
            <input type="radio" id="national" name="music-type" value="national">
            <label for="global">국외음악</label>            
            <input type="radio" id="global" name="music-type" value="global">
            <input type="text" placeholder="아티스트 입력" id="custom-artist" class="custom-upload-input" name="artist" required>
        </div>

        <div class="custom-thumbnail-container">
            <label>썸네일색상:</label>
            <input type="color" id="custom-thumbnail-preview" class="custom-thumbnail-preview" value="#ff9a9e">           
            <label>장르:</label>
            <select id="custom-genre" class="custom-upload-select" name="genre" required>
                <option value="">-- 장르 선택 --</option>
                <option value="pop">팝</option>
                <option value="rock">락</option>
                <option value="hiphop">힙합</option>
                <option value="jazz">재즈</option>
                <option value="classical">클래식</option>
            </select>
        </div>

        <label>설명 (선택사항):</label>
        <textarea id="custom-description" class="custom-upload-textarea" name="description" rows="3"></textarea>

        <label>분위기 태그 선택(선택사항):</label>
        <div class="custom-mood-tags">
            <% String[] moodTags = {"새벽 감성 음악", "여름 바닷가 감성", "영화 주제 음악", "드라마 OST", "피아노 연주", "기타 연주", "바이올린 연주", "잔잔한 카페 분위기", "몽환적인 느낌의 곡", "로맨틱송"}; 
            for (int i = 0; i < moodTags.length; i++) { %>
                <input type="checkbox" id="custom-mood<%=i%>" name="mood" value="<%=moodTags[i]%>">
                <label for="custom-mood<%=i%>"><%=moodTags[i]%></label>
            <% } %>
        </div>
        
        <button type="submit" onclick="alert('구현예정');" class="custom-upload-button">최종 업로드</button>
    </form>
</div>

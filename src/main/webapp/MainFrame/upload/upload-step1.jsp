<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
#custom-upload-container {
    background: #222;
    padding: 20px;
    border-radius: 10px;
    color: white;
    max-width: 600px;
    margin: auto;
    box-shadow: 0 0 10px rgba(255, 255, 255, 0.1);
}

.custom-upload-title { text-align: center; font-size: 24px; font-weight: bold; }

.custom-upload-form {
    display: flex;
    flex-direction: column;
    gap: 15px;
}

.custom-row {
    display: flex;
    gap: 15px;
    align-items: center;
    justify-content: space-between;
    width: 100%;
}

.custom-upload-input, .custom-upload-select, .custom-upload-textarea {
    padding: 12px;
    border-radius: 5px;
    border: 1px solid #777;
    background: #444;
    color: white;
    font-size: 16px;
    flex: 1;
}

.custom-upload-button {
    background: #FFC107;
    color: black;
    padding: 12px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
    transition: 0.3s ease;
    width: 100%;
}

.custom-upload-button:hover { background: #FFB300; }

.custom-thumbnail-container {
    display: flex;
    align-items: center;
    gap: 15px;
    flex: 1;
}

.custom-thumbnail-preview {
    width: 80px;
    height: 80px;
    border-radius: 10px;
    display: flex;
    justify-content: center;
    align-items: center;
    overflow: hidden;
    background: #666;
    flex-shrink: 0;
}

.custom-color-input {
    width: 100px;
    height: 40px;
    border-radius: 5px;
    border: none;
    cursor: pointer;
}

.custom-mood-tags {
    display: flex;
    flex-wrap: wrap;
    gap: 8px;
    flex: 2;
}

.custom-mood-tags label {
    background: #555;
    padding: 10px 14px;
    border-radius: 6px;
    color: white;
    cursor: pointer;
    font-size: 14px;
    transition: 0.3s ease;
}

.custom-mood-tags input:checked + label { background: #FFB300; color: black; font-weight: bold; }

.custom-mood-tags input { display: none; }

/* 설명 입력란 크기 조정 */
.custom-description-container {
    display: flex;
    align-items: center;
    gap: 15px;
    width: 100%;
}

.custom-upload-textarea {
    flex: 2;
    min-height: 60px;
}
.custom-radio-group {
    display: flex;
    align-items: center;
    gap: 10px;
}

.custom-radio-group input[type="radio"] {
    transform: scale(1.2);
    margin-right: 5px;
}

</style>

<div id="custom-upload-container">
    <h2 class="custom-upload-title">🎵 노래 업로드</h2>
    <form id="custom-music-upload" class="custom-upload-form" enctype="multipart/form-data">
        <label>음악 파일 업로드 :</label>
        <input type="file" id="custom-music-file" class="custom-upload-input" placeholder="hello" name="music-file" accept=".mp3, .wav, .aac" required>
        <div class="custom-radio-group">
            <label for="national">국내음악</label>
            <input type="radio" id="national" name="music-type" value="national">
            <label for="global">국외음악</label>
            <input type="radio" id="global" name="music-type" value="global">
        </div>


        <label>아티스트:</label>
        <input type="text" id="custom-artist" class="custom-upload-input" name="artist" required>
        
            <label>장르:</label>
            <select id="custom-genre" class="custom-upload-select" name="genre" required>
                <option value="">-- 장르 선택 --</option>
                <option value="pop">팝</option>
                <option value="rock">락</option>
                <option value="hiphop">힙합</option>
                <option value="jazz">재즈</option>
                <option value="classical">클래식</option>
            </select>


        <div class="custom-description-container">
            <label>썸네일색상:</label>
                <input type="color" id="custom-thumbnail-preview" class="custom-thumbnail-preview" value="#ff9a9e">           
            <label>설명 (선택사항):</label>
            <textarea id="custom-description" class="custom-upload-textarea" name="description" rows="3"></textarea>
			</div>
			
			            <label>분위기 태그 선택(선택사항):</label>
            <div class="custom-mood-tags">
                <% 
                
                String[] moodTags = {
                        "새벽 감성 음악", "여름 바닷가 감성", "영화 주제 음악", "드라마 OST", "피아노로 연주된", 
                        "기타로 연주된", "바이올린 연주곡", "오케스트라 편곡", "잔잔한 카페 분위기", 
                        "활기찬 분위기", "침울한 분위기", "몽환적인 느낌의 곡", "사랑스러운 로맨틱송", 
                        "운동할 때 듣기 좋은", "공부할 때 집중되는 음악", "새벽 감성 음악", "신나는 댄스곡", 
                        "잔잔한 어쿠스틱", "90년대 레트로 감성", "Lo-Fi 힙합 스타일"
                    };
                
                for (int i = 0; i < moodTags.length; i++) { %>
                    <input type="checkbox" id="custom-mood<%=i%>" name="mood" value="<%=moodTags[i]%>">
                    <label for="custom-mood<%=i%>"><%=moodTags[i]%></label>
                <% } %>
            </div>
        <button type="submit" class="custom-upload-button">최종 업로드</button>
    </form>
</div>

<script>
document.getElementById("custom-thumbnail-color").addEventListener("input", function(event) {
    document.getElementById("custom-thumbnail-preview").style.backgroundColor = event.target.value;
});

document.getElementById("custom-music-upload").addEventListener("submit", function(event) {
    event.preventDefault();
    alert("업로드 완료!");
});
</script>

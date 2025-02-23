<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/condition.css">

<div id="condition">
    <!-- 첫 번째 필터 그룹 (대분류 + 토글 버튼) -->
    <div class="filter-group toggle-group">
        <span class="filter-title">대분류</span>
        <div class="filter-content">
            <div class="button-container">
                <button class="scroll-left hidden">🡄</button>
            </div>
            <div class="filter-scroll">
    <input type="checkbox" id="domestic" name="category" value="domestic">
    <label for="domestic">국내음악</label>
    
    <input type="checkbox" id="international" name="category" value="international">
    <label for="international">국외음악</label>
            </div>

            <!-- ✅ 정렬 조건 추가 -->
            <div class="sort-options">
                <select id="sort-type">
                    <option value="date">등록일</option>
                    <option value="views">조회수</option>
                    <option value="random">무작위</option>
                </select>
                <select id="sort-order">
                    <option value="asc">오름차순</option>
                    <option value="desc">내림차순</option>
                </select>
            </div>

            <div class="button-container">
                <button id="toggle-btn">▼</button>
                <button class="scroll-right hidden">🡆</button>
            </div>
        </div>
    </div>

    <!-- 펼쳐질 필터 그룹 -->
    <div id="filter-content" class="hidden">
<div class="filter-group">
    <span class="filter-title">장르</span>
    <div class="filter-content">
        <div class="button-container">
            <button class="scroll-left hidden">🡄</button>
        </div>
        <div class="filter-scroll">
            <input type="checkbox" id="genre1" name="genre" value="pop">
            <label for="genre1">팝 (Pop)</label>

            <input type="checkbox" id="genre2" name="genre" value="rock">
            <label for="genre2">록 (Rock)</label>

            <input type="checkbox" id="genre3" name="genre" value="hiphop">
            <label for="genre3">힙합 (Hip-Hop)</label>

            <input type="checkbox" id="genre4" name="genre" value="jazz">
            <label for="genre4">재즈 (Jazz)</label>

            <input type="checkbox" id="genre5" name="genre" value="classical">
            <label for="genre5">클래식 (Classical)</label>

            <input type="checkbox" id="genre6" name="genre" value="edm">
            <label for="genre6">EDM (Electronic Dance Music)</label>
        </div>
        <div class="button-container">
            <button class="scroll-right hidden">🡆</button>
        </div>
    </div>
</div>


<div class="filter-group">
    <span class="filter-title">아티스트</span>
    <div class="filter-content">
        <div class="button-container">
            <button class="scroll-left hidden">🡄</button>
        </div>
        <div class="filter-scroll">
            <input type="checkbox" id="artist1" name="artist" value="BTS">
            <label for="artist1">BTS</label>

            <input type="checkbox" id="artist2" name="artist" value="Taylor Swift">
            <label for="artist2">Taylor Swift</label>

            <input type="checkbox" id="artist3" name="artist" value="The Weeknd">
            <label for="artist3">The Weeknd</label>

            <input type="checkbox" id="artist4" name="artist" value="Adele">
            <label for="artist4">Adele</label>

            <input type="checkbox" id="artist5" name="artist" value="Coldplay">
            <label for="artist5">Coldplay</label>

            <input type="checkbox" id="artist6" name="artist" value="Billie Eilish">
            <label for="artist6">Billie Eilish</label>

            <input type="checkbox" id="artist7" name="artist" value="Ed Sheeran">
            <label for="artist7">Ed Sheeran</label>

            <input type="checkbox" id="artist8" name="artist" value="Bruno Mars">
            <label for="artist8">Bruno Mars</label>

            <input type="checkbox" id="artist9" name="artist" value="BLACKPINK">
            <label for="artist9">BLACKPINK</label>

            <input type="checkbox" id="artist10" name="artist" value="Queen">
            <label for="artist10">Queen</label>
        </div>
        <div class="button-container">
            <button class="scroll-right hidden">🡆</button>
        </div>
    </div>
</div>

        
        
        <div class="filter-group">
    <span class="filter-title">노래 길이</span>
    <div class="filter-content">
        <div class="button-container">
            <button class="scroll-left hidden">🡄</button>
        </div>
        <div class="filter-scroll">
            <input type="radio" id="length1" name="song-length" value="under30">
            <label for="length1">30초 이하</label>

            <input type="radio" id="length2" name="song-length" value="30to60">
            <label for="length2">30초 ~ 1분</label>

            <input type="radio" id="length3" name="song-length" value="60to90">
            <label for="length3">1분 ~ 1분30초</label>

            <input type="radio" id="length4" name="song-length" value="90to120">
            <label for="length4">1분30초 ~ 2분</label>

            <input type="radio" id="length5" name="song-length" value="120to150">
            <label for="length5">2분 ~ 2분30초</label>

            <input type="radio" id="length6" name="song-length" value="180to240">
            <label for="length6">3분 ~ 4분</label>

            <input type="radio" id="length7" name="song-length" value="over240">
            <label for="length7">4분 초과</label>
        </div>
        <div class="button-container">
            <button class="scroll-right hidden">🡆</button>
        </div>
    </div>
</div>
      <div class="filter-group song-tags"> <!-- ✅ 추가한 클래스 song-tags -->
    <span class="filter-title">노래 속성</span>
    <div class="filter-content">
        <div class="button-container">
            <button class="scroll-left hidden">🡄</button>
        </div>
        <div class="filter-scroll">
            <% String[] songTags = {
                "새벽 감성 음악", "여름 바닷가 감성", "영화 주제 음악", "드라마 OST", "피아노로 연주된", 
                "기타로 연주된", "바이올린 연주곡", "오케스트라 편곡", "잔잔한 카페 분위기", 
                "활기찬 분위기", "침울한 분위기", "몽환적인 느낌의 곡", "사랑스러운 로맨틱송", 
                "운동할 때 듣기 좋은", "공부할 때 집중되는 음악", "새벽 감성 음악", "신나는 댄스곡", 
                "잔잔한 어쿠스틱", "90년대 레트로 감성", "Lo-Fi 힙합 스타일"
            };
            for (int i = 0; i < songTags.length; i++) { %>
                <input type="checkbox" id="tag<%=i%>" name="song-tags" value="<%=songTags[i]%>">
                <label for="tag<%=i%>"><%=songTags[i]%></label>
            <% } %>
        </div>
        <div class="button-container">
            <button class="scroll-right hidden">🡆</button>
        </div>
    </div>
</div>
        
        
    </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function () {
    const toggleBtn = document.getElementById("toggle-btn");
    const filterContent = document.getElementById("filter-content");

    // 펼치기 버튼 클릭 시 스크롤 버튼 다시 체크
    toggleBtn.addEventListener("click", function () {
        if (filterContent.classList.contains("hidden")) {
            filterContent.classList.remove("hidden");
            toggleBtn.textContent = "▲"; 
            
        } else {
            filterContent.classList.add("hidden");

           
            toggleBtn.textContent = "▼"; 
        }
        updateScrollButtons();
    });
    
    const sortType = document.getElementById("sort-type");
    const sortOrder = document.getElementById("sort-order");
    const postsContainer = document.querySelector(".board-content");
    
    function sortPosts() {
        let posts = Array.from(postsContainer.children);
        let type = sortType.value;
        let order = sortOrder.value;
        
        posts.sort((a, b) => {
            let valueA, valueB;

            if (type === "date") {
                valueA = new Date(a.dataset.date);
                valueB = new Date(b.dataset.date);
            } else if (type === "views") {
                valueA = parseInt(a.dataset.views, 10);
                valueB = parseInt(b.dataset.views, 10);
            } else {
                return order === "asc" ? 1 : -1; // 무작위 정렬
            }

            return order === "asc" ? valueA - valueB : valueB - valueA;
        });

        posts.forEach(post => postsContainer.appendChild(post));
    }

    sortType.addEventListener("change", sortPosts);
    sortOrder.addEventListener("change", sortPosts);
    
    

    function updateScrollButtons() {
        document.querySelectorAll(".filter-group").forEach(group => {
            const scrollContainer = group.querySelector(".filter-scroll");
            const scrollLeftBtn = group.querySelector(".scroll-left");
            const scrollRightBtn = group.querySelector(".scroll-right");

            function checkScrollState() {
                if (scrollContainer.scrollLeft > 0) {
                    scrollLeftBtn.classList.add("active");
                } else {
                    scrollLeftBtn.classList.remove("active");
                }

                if (scrollContainer.scrollLeft + scrollContainer.clientWidth < scrollContainer.scrollWidth) {
                    scrollRightBtn.classList.add("active");
                } else {
                    scrollRightBtn.classList.remove("active");
                }
            }

            if (scrollContainer && scrollLeftBtn && scrollRightBtn) {
                checkScrollState();

                scrollRightBtn.addEventListener("click", function () {
                    scrollContainer.scrollBy({ left: 100, behavior: "smooth" });
                });

                scrollLeftBtn.addEventListener("click", function () {
                    scrollContainer.scrollBy({ left: -100, behavior: "smooth" });
                });

                scrollContainer.addEventListener("scroll", checkScrollState);
            }
        });
    }

    updateScrollButtons();
});
</script>

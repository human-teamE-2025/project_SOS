<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    #condition {
        background: #d3d3d3;
        height: auto;
        padding: 6px;
        color: black;
        border-radius: 12px;
        width: 55vw;
        display: flex;
        flex-direction: column;
        gap: 2px;
    }

    /* 필터 그룹 스타일 */
    .filter-group {
        display: flex;
        align-items: center;
        position: relative;
        width: 93%;
        padding: 2px 0;
    }

    /* 대분류 (토글 그룹) 크기 조정 */
    .toggle-group {
        margin-bottom: 2px;
        font-size: 14px;
    }

    /* 필터 제목 크기 증가 */
    .filter-title {
        font-weight: bold;
        margin-right: 8px;
        min-width: 100px;
        font-size: 18px;
        display: flex;
        align-items: center;
        gap: 5px;
    }

    /* 필터 컨텐츠 - 체크박스 및 버튼 포함 */
    .filter-content {
        display: flex;
        align-items: center;
        font-size: 14px;
        width: 95%;
    }

    /* 체크박스 컨테이너 - 가로 스크롤 지원 */
    .filter-scroll {
        display: flex;
        gap: 8px;
        overflow-x: auto;
        white-space: nowrap;
        flex-grow: 1;
        padding: 2px;
        scrollbar-width: none;
        scroll-behavior: smooth;
        position: relative;
        align-items: center;
    }

    /* 스크롤바 숨기기 (Chrome, Safari) */
    .filter-scroll::-webkit-scrollbar {
        display: none;
    }

    /* 버튼 컨테이너 (스크롤 버튼 정렬을 위해 추가) */
    .button-container {
        display: flex;
        align-items: center;
        gap: 5px;
    }

    /* 스크롤 버튼 (🡄, 🡆) */
    .scroll-left, .scroll-right {
        background: rgba(0, 0, 0, 0.3);
        border: none;
        font-size: 14px;
        cursor: pointer;
        padding: 6px;
        display: none;
        border-radius: 50%;
        color: white;
        width: 26px;
        height: 26px;
        text-align: center;
    }

    /* 스크롤 버튼 활성화 */
    .scroll-left.active, .scroll-right.active {
        display: flex;
        justify-content: center;
        align-items: center;
    }

    /* 접기/펼치기 버튼 */
    #toggle-btn {
        background: transparent;
        border: none;
        font-size: 16px;
        cursor: pointer;
        padding: 5px;
        align-self: center;
    }

    /* 숨김 상태 */
    .hidden {
        display: none;
    }

    /* 반응형 대응 */
    @media (max-width: 768px) {
        #condition {
            width: 90vw;
        }

        .filter-group {
            flex-direction: column;
            align-items: flex-start;
        }
    }
</style>

<div id="condition">
    <!-- 첫 번째 필터 그룹 (대분류 + 토글 버튼) -->
    <div class="filter-group toggle-group">
        <span class="filter-title">대분류</span>
        <div class="filter-content">
            <div class="button-container">
                <button class="scroll-left hidden">🡄</button>
            </div>
            <div class="filter-scroll">
                <label><input type="checkbox" name="category" value="domestic"> 국내음악</label>
                <label><input type="checkbox" name="category" value="international"> 국외음악</label>
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
                    <% for (int i = 1; i <= 20; i++) { %>
                        <label><input type="checkbox" name="genre" value="genre<%=i%>"> 장르<%=i%></label>
                    <% } %>
                </div>
                <div class="button-container">
                    <button class="scroll-right hidden">🡆</button>
                </div>
            </div>
        </div>

        <div class="filter-group">
            <span class="filter-title">분위기</span>
            <div class="filter-content">
                <div class="button-container">
                    <button class="scroll-left hidden">🡄</button>
                </div>
                <div class="filter-scroll">
                    <% for (int i = 1; i <= 15; i++) { %>
                        <label><input type="checkbox" name="mood" value="mood<%=i%>"> 분위기<%=i%></label>
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

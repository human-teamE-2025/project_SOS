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

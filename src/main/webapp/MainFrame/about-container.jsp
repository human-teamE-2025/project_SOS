<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<head>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/about-container.css">
</head>

<div id="main-container">
    <div id="main-con">
        <!-- 항목 리스트 -->
        <div class="column">
            <div class="title-row">
                <div class="title">회사소개</div>
                <button class="toggle-btn">+</button>
            </div>
            <div class="description">
                <p>Song of Senses는 감각을 깨우는 특별한 경험을 제공하는 브랜드입니다...</p>
            </div>
        </div>

        <div class="column">
            <div class="title-row">
                <div class="title">제휴안내</div>
                <button class="toggle-btn">+</button>
            </div>
            <div class="description">
                <p>Song of Senses는 감각을 깨우는 특별한 경험을 제공하는 브랜드입니다...</p>
            </div>
        </div>

        <div class="column">
            <div class="title-row">
                <div class="title">광고안내</div>
                <button class="toggle-btn">+</button>
            </div>
            <div class="description">
                <p>Song of Senses는 감각을 깨우는 특별한 경험을 제공하는 브랜드입니다...
                Song of Senses는 감각을 깨우는 특별한 경험을 제공하는 브랜드입니다...
                Song of Senses는 감각을 깨우는 특별한 경험을 제공하는 브랜드입니다...
                Song of Senses는 감각을 깨우는 특별한 경험을 제공하는 브랜드입니다...
                Song of Senses는 감각을 깨우는 특별한 경험을 제공하는 브랜드입니다...
                Song of Senses는 감각을 깨우는 특별한 경험을 제공하는 브랜드입니다...
                Song of Senses는 감각을 깨우는 특별한 경험을 제공하는 브랜드입니다...
                Song of Senses는 감각을 깨우는 특별한 경험을 제공하는 브랜드입니다...
                Song of Senses는 감각을 깨우는 특별한 경험을 제공하는 브랜드입니다...
                Song of Senses는 감각을 깨우는 특별한 경험을 제공하는 브랜드입니다...
                Song of Senses는 감각을 깨우는 특별한 경험을 제공하는 브랜드입니다...
                Song of Senses는 감각을 깨우는 특별한 경험을 제공하는 브랜드입니다...Song of Senses는 감각을 깨우는 특별한 경험을 제공하는 브랜드입니다...
                Song of Senses는 감각을 깨우는 특별한 경험을 제공하는 브랜드입니다...
                
                </p>
            </div>
        </div>

        <div class="column">
            <div class="title-row">
                <div class="title">이용약관</div>
                <button class="toggle-btn">+</button>
            </div>
            <div class="description">
                <p>Song of Senses는 감각을 깨우는 특별한 경험을 제공하는 브랜드입니다...</p>
            </div>
        </div>

        <div class="column">
            <div class="title-row">
                <div class="title">개인정보처리방침</div>
                <button class="toggle-btn">+</button>
            </div>
            <div class="description">
                <p>Song of Senses는 감각을 깨우는 특별한 경험을 제공하는 브랜드입니다...</p>
            </div>
        </div>

        <div class="column">
            <div class="title-row">
                <div class="title">이용정책</div>
                <button class="toggle-btn">+</button>
            </div>
            <div class="description">
                <p>Song of Senses는 감각을 깨우는 특별한 경험을 제공하는 브랜드입니다...</p>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function() {
    const columns = document.querySelectorAll('.column');
    const buttons = document.querySelectorAll('.toggle-btn');

    // 초기 상태 - 첫 번째 항목 열어두기
    let currentOpenIndex = null;

    buttons.forEach((button, index) => {
        button.addEventListener('click', function(event) {
            toggleDescription(index);
            event.stopPropagation(); // 클릭 이벤트 전파 방지
        });
    });

    function toggleDescription(index) {
        const column = columns[index];
        const description = column.querySelector('.description');
        const button = buttons[index];

        // 현재 열린 항목이 있는 경우 닫기
        if (currentOpenIndex !== null && currentOpenIndex !== index) {
            closeDescription(currentOpenIndex);
        }

        // 새 항목 열기
        const isCurrentlyOpen = description.classList.contains('show');

        if (isCurrentlyOpen) {
            closeDescription(index);
            currentOpenIndex = null;
        } else {
            description.classList.add('show');
            column.classList.add('selected');
            button.textContent = "−";
            currentOpenIndex = index;
        }
    }

    function closeDescription(index) {
        const column = columns[index];
        const description = column.querySelector('.description');
        const button = buttons[index];

        description.classList.remove('show');
        column.classList.remove('selected');
        button.textContent = "+";
    }
});
</script>

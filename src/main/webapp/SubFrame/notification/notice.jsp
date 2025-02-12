<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="./SubFrame/notification/notice.css">

<div id="popup">    
    <div id="popup-header">
        <span id="popup-title">알림</span>
        <button id="settings-btn">설정</button>
    </div>
    <ul id="nav-item">
    </ul>
</div>

<script>
document.addEventListener("DOMContentLoaded", function() {
    const button = document.getElementById("b1");
    const popup = document.getElementById("popup");
    const navItem = document.getElementById("nav-item");
    let idCounter = 1; // ID 카운터 초기화

    // 버튼 클릭 시 팝업 보이기/숨기기
    button.addEventListener("click", function() {
        popup.style.visibility = popup.style.visibility === "hidden" || popup.style.visibility === "" ? "visible" : "hidden";
    });

    // 리스트 아이템 삭제 기능 추가
    function addDeleteEvent(icon) {
        icon.addEventListener("click", function(event) {
            const listItem = event.target.closest("li"); // 부모 <li> 요소 찾기
            console.log("삭제할 ID:", listItem.getAttribute("data-id"));
            listItem.remove();
        });
    }

    // 추가 옵션 버튼 클릭 이벤트
    function addOptionEvent(optionBtn) {
        optionBtn.addEventListener("click", function(event) {
            alert("추가 옵션을 선택하세요!");
        });
    }

    // 랜덤 문자열 생성 함수 (최대 10글자)
    function generateRandomText(length = 10) {
        const characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        return Array.from({ length }, () => characters.charAt(Math.floor(Math.random() * characters.length))).join("");
    }

    // 새로운 리스트 아이템 추가 함수
    function addListItem() {
        const listItem = document.createElement("li");
        listItem.setAttribute("data-id", idCounter);

        const itemContent = document.createElement("div");
        itemContent.classList.add("item-content");

        const img = document.createElement("img");
        img.src = "static/img/fav.ico"; // 아이콘 경로
        img.alt = "icon";

        const link = document.createElement("a");
        link.href = "/E_web/mypage.jsp";
        link.textContent = generateRandomText(Math.floor(Math.random() * 10) + 1); // 1~10글자

        const buttonContent = document.createElement("div");
        buttonContent.classList.add("button-content");
        
        const optionBtn = document.createElement("i");
        optionBtn.classList.add("fa-solid", "fa-ellipsis-vertical", "option-icon");

        const icon = document.createElement("i");
        icon.classList.add("fa-solid", "fa-xmark", "delete-icon");

        addDeleteEvent(icon);
        addOptionEvent(optionBtn);

        // 요소 조립
        itemContent.appendChild(img);
        itemContent.appendChild(link);
        buttonContent.appendChild(optionBtn);
        buttonContent.appendChild(icon);
        
        listItem.appendChild(itemContent);
        listItem.appendChild(buttonContent); 
               
        navItem.appendChild(listItem);

        idCounter++; // ID 증가
    }

    // 초기 데이터 추가 (예: 100개 자동 추가)
    for (let i = 0; i < 100; i++) {
        addListItem();
    }
});
</script>



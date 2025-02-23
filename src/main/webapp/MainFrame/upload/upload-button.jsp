<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
.upload-btn-container {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 8px 15px;
    background: #FFC107;
    border-radius: 8px;
    cursor: pointer;
    transition: background 0.3s ease, transform 0.2s ease;
    font-size: 16px;
    font-weight: bold;
    color: black;
    text-decoration: none;
    width: fit-content;
}

.upload-btn-container:hover {
    background: #FFB300;
    transform: scale(1.05);
}

.upload-btn-container i {
    margin-right: 8px;
    font-size: 18px;
}
</style>

<div class="upload-btn-container">
    <i class="fa-solid fa-pen-to-square"></i> 업로드
</div>

<script>
document.addEventListener("DOMContentLoaded", function () {
    const uploadButton = document.querySelector(".upload-btn-container");
    
    const mainContainer = document.querySelector("main"); 
    let cachedUploadStep1 = "";

    // ✅ Step1을 미리 캐싱
    fetch("${pageContext.request.contextPath}/MainFrame/upload/upload-step1.jsp")
        .then(response => response.text())
        .then(data => {
            cachedUploadStep1 = data;
        })
        .catch(error => console.error("❌ Step1 캐싱 실패"));

    uploadButton.addEventListener("click", function (e) {
        e.preventDefault(); 

        if (cachedUploadStep1) {
            mainContainer.innerHTML = cachedUploadStep1; 
            executeScripts(mainContainer);
        } else {
            console.error("❌ Step1 캐싱 실패");
        }
    });
});

function executeScripts(element) {
    const scripts = element.querySelectorAll("script");
    scripts.forEach(script => {
        const newScript = document.createElement("script");
        if (script.src) {
            newScript.src = script.src;
            newScript.onload = () => console.log("✅ 외부 스크립트 로드 완료:", script.src);
        } else {
            newScript.textContent = script.textContent;
        }
        document.body.appendChild(newScript);
    });
}
</script>

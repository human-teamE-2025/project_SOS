<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<style>
/* ✅ 모바일 업로드 버튼 */
#mobile-upload-btn {
    display: none !important; /* 기본적으로 숨김 */
    position: fixed;
    top: 0;
    left: 50%;
    transform: translateX(-50%);
    background: #FFC107; /* 빨간색 */
    padding: 12px 24px;
    border-radius: 0 0 8px 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    cursor: pointer;
    z-index: 1000;
    transition: background 0.3s ease, transform 0.2s ease;
    display: flex;
    align-items: center;
    justify-content: center;
}

/* ✅ 모바일 환경에서만 표시 */
@media screen and (max-width: 768px) {
    #mobile-upload-btn {
        display: block !important;
    }
}

#mobile-upload-btn:hover {
    background: #E63232;
    transform: translateX(-50%) scale(1.1);
}
</style>

<!-- ✅ 모바일용 업로드 버튼 -->
<div id="mobile-upload-btn">
    <i class="fa-solid fa-pen-to-square"></i> 업로드
</div>

<script>
document.addEventListener("DOMContentLoaded", function () {
    const mobileUploadButton = document.getElementById("mobile-upload-btn"); // 모바일용 버튼
    const mainContainer = document.querySelector("main");
    let cachedUploadStep1 = "";

    // ✅ Step1을 미리 캐싱
    fetch("${pageContext.request.contextPath}/MainFrame/upload/upload-step1.jsp")
        .then(response => response.text())
        .then(data => {
            cachedUploadStep1 = data;
        })
        .catch(error => console.error("❌ Step1 캐싱 실패"));

    function loadUploadStep1() {
        if (cachedUploadStep1) {
            mainContainer.innerHTML = cachedUploadStep1;
            executeScripts(mainContainer);
        } else {
            console.error("❌ Step1 캐싱 실패");
        }
    }

    // ✅ 모바일 버튼 이벤트 리스너 추가 (중복 방지)
    if (mobileUploadButton && !mobileUploadButton.dataset.listenerAdded) {
        mobileUploadButton.addEventListener("click", loadUploadStep1);
        mobileUploadButton.dataset.listenerAdded = "true";
    }
});

// ✅ 동적으로 불러온 스크립트 실행 함수
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

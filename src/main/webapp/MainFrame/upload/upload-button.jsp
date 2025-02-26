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
    position: relative;
}

/* ✅ 마우스 올릴 때 업로드 버튼 강조 */
.upload-btn-container:hover {
    background: #FFB300;
    transform: scale(1.05);
}

.upload-btn-container i {
    margin-right: 8px;
    font-size: 18px;
}

/* ✅ 경고 메시지 스타일 (required 스타일과 유사) */
.login-required-tooltip {
    position: absolute;
    top: 105%;
    left: 50%;
    transform: translateX(-50%);
    background: #ff4444;
    color: white;
    font-size: 14px;
    padding: 5px 10px;
    border-radius: 5px;
    white-space: nowrap;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
    opacity: 1;
    transition: opacity 0.5s ease-in-out;
}

/* ✅ 삼각형 화살표 (입력 필드 `required` 스타일과 유사) */
.login-required-tooltip::after {
    content: "";
    position: absolute;
    bottom: 100%;
    left: 50%;
    transform: translateX(-50%);
    border-width: 5px;
    border-style: solid;
    border-color: transparent transparent #ff4444 transparent;
}

/* ✅ 흔들리는 효과 (input required 경고 스타일과 유사) */
@keyframes shake {
    0%, 100% { transform: translateX(0); }
    25% { transform: translateX(-5px); }
    50% { transform: translateX(5px); }
    75% { transform: translateX(-5px); }
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

        // ✅ 로그인 여부 확인
        fetch("${pageContext.request.contextPath}/SessionInfoServlet")
            .then(response => response.json())
            .then(data => {
                if (data.loggedIn) {
                    // ✅ 로그인된 사용자 → 업로드 페이지 로드
                    if (cachedUploadStep1) {
                        mainContainer.innerHTML = cachedUploadStep1; 
                        executeScripts(mainContainer);
                    } else {
                        console.error("❌ Step1 캐싱 실패");
                    }
                } else {	
                    // ❌ 로그인되지 않은 사용자 → "로그인 후 이용 가능" 경고 표시
                    showLoginRequiredTooltip(uploadButton);
                }
            })
            .catch(error => console.error("❌ 로그인 상태 확인 실패:", error));
    });
});

// ✅ 로그인 후 이용 가능 툴팁(경고) 표시 함수
function showLoginRequiredTooltip(button) {
    if (document.querySelector(".login-required-tooltip")) return; // 이미 표시 중이면 중복 생성 방지

    const tooltip = document.createElement("div");
    tooltip.classList.add("login-required-tooltip");
    tooltip.textContent = "로그인 후 이용 가능합니다.";
    
    button.appendChild(tooltip);

    // ✅ 버튼 흔들리는 애니메이션 추가
    button.style.animation = "shake 0.3s ease-in-out";

    // ✅ 1.5초 후 경고 메시지 사라짐
    setTimeout(() => {
        tooltip.style.opacity = "0";
        setTimeout(() => tooltip.remove(), 500);
    }, 1500);

    // ✅ 애니메이션 제거 (0.3초 후 원상 복귀)
    setTimeout(() => {
        button.style.animation = "";
    }, 300);
}

// ✅ 동적 스크립트 실행 함수 (기존 기능 유지)
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

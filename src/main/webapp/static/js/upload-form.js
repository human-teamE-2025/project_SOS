document.addEventListener("DOMContentLoaded", function () {
    console.log("🚀 [UPLOAD FORM] JavaScript 로드 완료!");

    const nextStepButton = document.getElementById("next-step");
    const fileInput = document.getElementById("music-file");
    const formInputs = document.querySelectorAll("#music-upload-step1 input, #music-upload-step1 select");

    function validateForm() {
        let isValid = true;
        let errorMessage = "다음 단계";

        formInputs.forEach(input => {
            if (input.type === "checkbox") return; // 분위기 태그 제외
            if (!input.value.trim()) {
                isValid = false;
                errorMessage = "모든 항목을 입력하세요";
            }
        });

        const file = fileInput.files[0];
        if (!file) {
            isValid = false;
            errorMessage = "음악 파일을 업로드하세요";
        } else {
            const allowedExtensions = ["mp3", "wav", "aac"];
            const fileExtension = file.name.split(".").pop().toLowerCase();
            if (!allowedExtensions.includes(fileExtension) || file.size > 10 * 1024 * 1024) {
                isValid = false;
                errorMessage = "MP3, WAV, AAC 형식만 가능 (10MB 이하)";
            }
        }

        nextStepButton.disabled = !isValid;
        nextStepButton.textContent = errorMessage; // 버튼에 원인 표시
    }

    formInputs.forEach(input => {
        input.addEventListener("input", validateForm);
    });

    fileInput.addEventListener("change", validateForm);

    validateForm(); // 초기 상태에서 유효성 검사 실행
});

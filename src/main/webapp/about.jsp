
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Song of Senses</title>

<link rel="icon" href="static/img/fav.ico" type="image/x-icon">
<link href="https://fonts.googleapis.com/css2?family=League+Gothic&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<link rel="preconnect" href="https://rsms.me/">
<link rel="stylesheet" href="https://rsms.me/inter/inter.css">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
	font-family: 'Inter', sans-serif;
}

#entire {

}

			
</style>
</head>
<body>
    <div id="entire">
			<%@ include file="./SubFrame/SubContainer.jsp" %>		
			<%@ include file="./MainFrame/about-container.jsp" %>		
    </div>	
    
    <script>
    document.addEventListener("DOMContentLoaded", function () {
        try {
            console.log("🔹 DOMContentLoaded 실행됨!");

            // ✅ 모든 .toggle-btn 버튼 찾기
            const columns = document.querySelectorAll('.column');
            const buttonContainer = document.getElementById("main-con");

            if (!buttonContainer) {
                console.warn("⚠️ main-con 요소를 찾을 수 없습니다. 버튼 클릭이 동작하지 않을 수 있습니다.");
                return;
            }

            // ✅ 이벤트 리스너를 부모 요소에만 등록하여 delegation 사용
            buttonContainer.addEventListener("click", function (event) {
                const button = event.target.closest(".toggle-btn");

                if (!button) return; // 클릭한 요소가 버튼이 아닐 경우 무시

                console.log(`🔹 버튼 클릭됨: ${button.innerText}`);

                const column = button.closest(".column");
                if (!column) {
                    console.warn("⚠️ 클릭한 버튼의 부모 .column을 찾을 수 없습니다.");
                    return;
                }

                const description = column.querySelector('.description');

                if (!description) {
                    console.warn("⚠️ .description 요소를 찾을 수 없습니다.");
                    return;
                }

                const isOpen = description.classList.contains("show");

                // ✅ 기존 열린 항목 닫기
                document.querySelectorAll(".description.show").forEach(desc => {
                    desc.classList.remove("show");
                    desc.closest(".column").classList.remove("selected");
                    desc.closest(".column").querySelector(".toggle-btn").innerText = "+";
                });

                // ✅ 새로운 항목 열기 (현재 닫혀 있을 경우만)
                if (!isOpen) {
                    description.classList.add("show");
                    column.classList.add("selected");
                    button.innerText = "−";
                    console.log(`🔹 ${button.innerText} 버튼을 눌러 섹션이 열렸습니다.`);
                }
            });

            // ✅ URL에서 section 파라미터를 가져와 자동으로 해당 섹션 열기
            function openSectionFromURL() {
                try {
                    const params = new URLSearchParams(window.location.search);
                    const section = params.get("section");

                    if (section) {
                        let indexToOpen = null;

                        if (section === "company") indexToOpen = 0;
                        else if (section === "Partnership") indexToOpen = 1;
                        else if (section === "terms") indexToOpen = 3;
                        else if (section === "privacy") indexToOpen = 4;

                        if (indexToOpen !== null) {
                            setTimeout(() => {
                                const button = document.querySelectorAll(".toggle-btn")[indexToOpen];
                                if (button) {
                                    console.log(`🔹 URL을 통해 자동으로 섹션 열기: ${button.innerText}`);
                                    button.click(); // 🔥 클릭 이벤트 강제 실행
                                }
                            }, 300);
                        }
                    }
                } catch (error) {
                    console.error(`❌ openSectionFromURL() 오류 발생: ${error.message}`);
                }
            }

            openSectionFromURL();

        } catch (error) {
            console.error(`❌ DOMContentLoaded 오류 발생: ${error.message}`);
        }
    });

</script>
    
    
</body>
</html>
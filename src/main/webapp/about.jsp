
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
    const columns = document.querySelectorAll('.column');
    const buttons = document.querySelectorAll('.toggle-btn');
    let currentOpenIndex = null;

    buttons.forEach((button, index) => {
        button.addEventListener('click', function (event) {
            toggleDescription(index);
            event.stopPropagation();
        });
    });

    function toggleDescription(index) {
        const column = columns[index];
        const description = column.querySelector('.description');
        const button = buttons[index];

        if (currentOpenIndex !== null && currentOpenIndex !== index) {
            closeDescription(currentOpenIndex);
        }

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

    // 🔹 URL을 확인하여 해당 섹션 자동 활성화
    function openSectionFromURL() {
        const params = new URLSearchParams(window.location.search);
        const section = params.get("section");

        if (section) {
            let indexToOpen = null;
            if (section === "company") indexToOpen = 0;
            else if (section === "terms") indexToOpen = 3;
            else if (section === "privacy") indexToOpen = 4;

            if (indexToOpen !== null) {
                toggleDescription(indexToOpen);
            }
        }
    }

    openSectionFromURL(); // 페이지 로드 시 실행
});
</script>
    
    
</body>
</html>
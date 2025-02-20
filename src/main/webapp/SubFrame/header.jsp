<!-- header.jsp -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/header.css">       
<header>
    <div id="left-header">
        <button class="menu">
            <i class="fa-solid fa-bars"></i>
        </button>

        <div id="titles">
            <button class="logo-btn logo" onclick="window.location.href='${pageContext.request.contextPath}/index.jsp';"></button>			
            <h1 id="title" onclick="window.location.href='${pageContext.request.contextPath}/index.jsp';">Song of Senses</h1>
        </div>
    </div>

    <div id="right-header">
        <div class="search-container">
                <input id="search" type="text" placeholder="Search...">
                <button class="search-submit"><i class="fa-solid fa-magnifying-glass"></i></button>

        </div>

        <div class="nav-button">            	
            <button id="b1"><i class="fa-solid fa-bell"></i></button>			
            <button id="b2"><i class="fas fa-sign-in-alt"></i></button>
        </div>
    </div>
</header>

        
<script>
        $(document).ready(function() {
            $("#b2").click(function() {
                // 모달이 이미 열려있으면 닫기
                if ($("#login-modal").is(":visible")) {
                    $("#login-modal").fadeOut();
                } else {
                    // 모달이 열려있지 않으면 불러오기
                    $.ajax({
                        url: "SubFrame/Modal/Login.jsp",
                        type: "GET",
                        dataType: "html",
                        success: function(data) {
                            // 모달이 이미 존재하지 않으면 새로 추가
                            if ($("#login-modal").length === 0) {
                                $("body").append(data); // 새 모달 추가
                                // 처음에는 모달을 숨겨두기
                                  
                            }

                            // 모달을 즉시 보이게 함 (AJAX 요청이 성공적으로 완료된 후에 표시)
                            $("#login-modal").fadeIn(); 
                        },
                        error: function(xhr, status, error) {
                            console.error("모달을 불러오는 중 오류 발생:", error);
                        }
                    });
                }
            });

            // 모달 외부 클릭 시 모달 닫기
            $(document).on("click", function(event) {
                if ($(event.target).closest("#login-modal").length === 0) {
                    $("#login-modal").fadeOut();
                }
            });
        });

        $(document).ready(function() {
            // 햄버거 메뉴 클릭 시 X 버튼으로 변경
            $(".menu").click(function() {
                let icon = $(this).find("i");
                if (icon.hasClass("fa-bars")) {
                    icon.removeClass("fa-bars").addClass("fa-xmark");
                } else {
                    icon.removeClass("fa-xmark").addClass("fa-bars");
                }
            });

            // 검색 버튼 클릭 시 검색바 토글
        });


        </script>


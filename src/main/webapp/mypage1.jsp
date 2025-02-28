<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Song of Senses</title>

<link href="https://fonts.googleapis.com/css2?family=League+Gothic&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<link rel="preconnect" href="https://rsms.me/">
<link rel="stylesheet" href="https://rsms.me/inter/inter.css">


<style>

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
	font-family: 'Inter', sans-serif;
}
	* ::-webkit-scrollbar {
    width: 8px;
}
* ::-webkit-scrollbar-thumb {
    background-color: rgba(0, 0, 0, 0.5);
    border-radius: 4px;
}	

* ::-webkit-scrollbar-track {
    background-color: transparent;
}
button :hover{
	opacity:0.6;
}
</style>			
</head>
<body>
    <div id="entire">
			<%@ include file="./SubFrame/SubContainer.jsp" %>		
			<%@ include file="./MainFrame/mypage1.jsp" %>		


    </div>	
</body>
</html>
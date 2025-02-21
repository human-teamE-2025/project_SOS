
			        <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<head>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/main-container.css">
</head>


			<div id="main-container">
			<%@ include file="./left-nav.jsp" %>
			
			<div id="main-con">
				
			<main>
						<%@ include file="./condition.jsp" %>
	    				<%@ include file="./carousel1.jsp" %>
	    				<%@ include file="./carousel2.jsp" %>
    					<%@ include file="./carousel3.jsp" %>
    					<%@ include file="./carousel4.jsp" %>
						<%@ include file="./carousel5.jsp" %>
			</main>
				<%@ include file="./right-sections.jsp" %>

			</div>
			</div>
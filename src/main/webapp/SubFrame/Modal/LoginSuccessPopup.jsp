<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat, java.util.Date" %>

<%
    HttpSession sessionObj = request.getSession();
    String nickname = (String) sessionObj.getAttribute("userName");
    String loginTime = (String) sessionObj.getAttribute("loginTime");

    if (nickname == null) {
        nickname = "사용자";
    }
    if (loginTime == null) {
        loginTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
        sessionObj.setAttribute("loginTime", loginTime);
    }
%>

<div id="user-popup" class="user-popup">
    <p><strong><%= nickname %></strong>님, 환영합니다!</p>
    <p class="login-time">🕒 로그인 시간: <%= loginTime %></p>
    <button id="logout-btn">로그아웃</button>
</div>

<style>
.user-popup {
    position: absolute;
    top: 50px;
    right: 20px;
    width: 220px;
    background: #222;
    padding: 15px;
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
    color: white;
    font-size: 14px;
    display: none;
    text-align: center;
}

.user-popup .login-time {
    font-size: 12px;
    color: #aaa;
    margin-top: 5px;
}

#logout-btn {
    background: #ff4444;
    color: white;
    border: none;
    padding: 8px 12px;
    border-radius: 5px;
    cursor: pointer;
    width: 100%;
    margin-top: 10px;
}

#logout-btn:hover {
    background: #cc0000;
}
</style>

<script>
$(document).ready(function() {
    $("#logout-btn").click(function() {
        $.ajax({
            url: "LogoutServlet",
            type: "POST",
            success: function(response) {
                if (response.trim() === "success") {
                    alert("✅ 로그아웃 되었습니다.");
                    location.reload();
                }
            },
            error: function() {
                alert("❌ 로그아웃 실패");
            }
        });
    });
});
</script>

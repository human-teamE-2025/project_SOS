<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Goods List</title>
</head>
<body>
<h1>Goods List</h1>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Item</th>
        <th>Password</th>
    </tr>
    <%
        String driverName="com.mysql.cj.jdbc.Driver";  // 최신 MySQL 드라이버 이름
        String url = "jdbc:mysql://3.25.114.213:3306/userDB?useSSL=false&serverTimezone=UTC";
        String id = "your_user";  // MySQL ID
        String pwd = "your_password";  // MYSQL Password

        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            // [1] JDBC 드라이버 로드
            Class.forName(driverName);   
            out.println("MySQL JDBC 드라이버 등록 성공!!<br>");
            
            // [2] 데이터베이스 연결
            conn = DriverManager.getConnection(url, id, pwd);
            out.println("DB 연결 성공!!<br>");
            
            // [3] SQL 쿼리 실행
            String query = "SELECT id, email, password FROM userInfo";
            stmt = conn.createStatement();
            rs = stmt.executeQuery(query);
            
            // [4] 결과 출력
            while (rs.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getInt("id") + "</td>");
                out.println("<td>" + rs.getString("email") + "</td>");
                out.println("<td>" + rs.getString("password") + "</td>");
                out.println("</tr>");
            }
            
        } catch (ClassNotFoundException e) {
            out.println("MySQL JDBC 드라이버를 찾을 수 없습니다!<br>");
            e.printStackTrace();
        } catch (SQLException e) {
            out.println("DB 연결 실패!<br>");
            e.printStackTrace();
        } catch (Exception e) {
            out.println("기타 예외 발생!<br>");
            e.printStackTrace();
        } finally {
            // [5] 데이터베이스 연결 해제
            try { 
                if (rs != null) rs.close(); 
                if (stmt != null) stmt.close(); 
                if (conn != null) conn.close(); 
                out.println("DB 연결 종료!!<br>");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
</table>
</body>
</html>

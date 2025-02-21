package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL = "jdbc:mysql://3.25.114.213:3306/userDB";
    private static final String USER = "your_user";
    private static final String PASSWORD = "your_password";

    // ✅ DB 연결을 생성하는 메서드
    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return java.sql.DriverManager.getConnection(URL, USER, PASSWORD);
    }

    // ✅ DB 리소스를 안전하게 닫는 메서드 (PreparedStatement만)
    public static void close(Connection conn, PreparedStatement pstmt) {
        close(conn, pstmt, null); // ResultSet이 필요하지 않을 때
    }

    // ✅ DB 리소스를 안전하게 닫는 메서드 (ResultSet 포함)
    public static void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
        try {
            if (rs != null) rs.close();  // ResultSet이 있을 경우 닫기
        } catch (SQLException e) {
            e.printStackTrace();
        }

        try {
            if (pstmt != null) pstmt.close();  // PreparedStatement 닫기
        } catch (SQLException e) {
            e.printStackTrace();
        }

        try {
            if (conn != null) conn.close();  // Connection 닫기
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

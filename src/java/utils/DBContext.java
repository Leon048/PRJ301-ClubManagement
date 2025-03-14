///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
// */
package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {
    // Cấu hình kết nối cơ sở dữ liệu
    private static final String DB_URL = "jdbc:sqlserver://DESKTOP-9V8UV9S:1433;databaseName=ClubManagement;TrustServerCertificate=true";
    private static final String DB_USER = "sa";
    private static final String DB_PASSWORD = "123";
    
    // Phương thức lấy kết nối đến cơ sở dữ liệu
    public static Connection getConnection() throws SQLException {
        try {
            // Kiểm tra và tải driver JDBC (nếu cần)
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            throw new SQLException("Kết nối cơ sở dữ liệu thất bại", e);
        }
    }
}

//package utils;
//
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.SQLException;
//
//public class DBContext {
//    // Cấu hình kết nối cơ sở dữ liệu
//    private static final String DB_URL = "jdbc:sqlserver://DESKTOP-9V8UV9S:1433;databaseName=ClubManagement;TrustServerCertificate=true";
//    private static final String DB_USER = "sa";
//    private static final String DB_PASSWORD = "123";
//
//    // ✅ Singleton Instance
//    private static DBContext instance;
//    private Connection connection;
//
//    // ✅ Hàm getInstance() để lấy instance duy nhất
//    public static synchronized DBContext getInstance() {
//        if (instance == null) {
//            instance = new DBContext();
//        }
//        return instance;
//    }
//
//    // ✅ Constructor riêng tư để ngăn chặn tạo instance ngoài lớp
//    private DBContext() {
//        try {
//            if (connection == null || connection.isClosed()) {
//                // Tải driver JDBC
//                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
//                // Kết nối đến database
//                connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
//                System.out.println("✅ Kết nối SQL Server thành công!");
//            }
//        } catch (ClassNotFoundException | SQLException e) {
//            System.err.println("🔴 Lỗi kết nối SQL Server: " + e.getMessage());
//            connection = null;
//        }
//    }
//
//    // ✅ Lấy kết nối hiện tại (hoặc null nếu lỗi)
//    public Connection getConnection() {
//        return connection;
//    }
//
//    // ✅ Kiểm tra kết nối hoạt động đúng
//    public static void main(String[] args) {
//        try {
//            Connection conn = DBContext.getInstance().getConnection();
//            if (conn != null) {
//                System.out.println("🎯 Kết nối thành công! Sẵn sàng sử dụng DB.");
//                conn.close();
//            } else {
//                System.err.println("🚨 Kết nối thất bại!");
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
//}



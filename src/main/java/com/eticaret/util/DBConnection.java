package com.eticaret.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    
    private static final String URL = "jdbc:mysql://localhost:3306/eticaret_db";
    private static final String USER = "root";
    private static final String PASSWORD = "root";
    
    // Veritabanı bağlantısı al
    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Veritabanına bağlandı!");
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL Driver bulunamadı!");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("Veritabanı bağlantı hatası!");
            e.printStackTrace();
        }
        return conn;
    }
    
    // Bağlantıyı kapat
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
                System.out.println("Bağlantı kapatıldı.");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
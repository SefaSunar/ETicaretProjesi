package com.eticaret.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.eticaret.model.User;
import com.eticaret.util.DBConnection;
import com.eticaret.util.PasswordUtil;

public class UserDAO {
    
    // Email var mı kontrol et
    public boolean emailExists(String email) {
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            
            boolean exists = false;
            if (rs.next()) {
                exists = rs.getInt(1) > 0;
            }
            
            rs.close();
            stmt.close();
            conn.close();
            
            return exists;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Kullanıcı kaydet (ŞİFRE HASHLENECEK)
    public boolean registerUser(String fullName, String email, String password, String phone, String address) {
        try {
            // ŞİFREYİ HASHLE
            String hashedPassword = PasswordUtil.hashPassword(password);
            
            Connection conn = DBConnection.getConnection();
            String sql = "INSERT INTO users (full_name, email, password, phone, address, role, created_at) " +
                        "VALUES (?, ?, ?, ?, ?, 'customer', NOW())";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, fullName);
            stmt.setString(2, email);
            stmt.setString(3, hashedPassword); // HASHLENMIŞ ŞİFRE
            stmt.setString(4, phone);
            stmt.setString(5, address);
            
            int rows = stmt.executeUpdate();
            
            stmt.close();
            conn.close();
            
            return rows > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Kullanıcı girişi (ŞİFRE HASHLENECEK)
    public User login(String email, String password) {
        User user = null;
        
        try {
            // ŞİFREYİ HASHLE
            String hashedPassword = PasswordUtil.hashPassword(password);
            
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, hashedPassword); // HASHLENMIŞ ŞİFRE
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));
            }
            
            rs.close();
            stmt.close();
            conn.close();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return user;
    }
}
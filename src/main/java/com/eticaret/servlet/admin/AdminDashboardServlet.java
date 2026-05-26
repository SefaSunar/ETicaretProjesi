package com.eticaret.servlet.admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.eticaret.util.DBConnection;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            Connection conn = DBConnection.getConnection();
            
            // Toplam ürün sayısı
            String productSql = "SELECT COUNT(*) as count FROM products WHERE is_active = true";
            PreparedStatement productStmt = conn.prepareStatement(productSql);
            ResultSet productRs = productStmt.executeQuery();
            int totalProducts = 0;
            if (productRs.next()) {
                totalProducts = productRs.getInt("count");
            }
            
            // Toplam kategori sayısı
            String categorySql = "SELECT COUNT(*) as count FROM categories WHERE is_active = true";
            PreparedStatement categoryStmt = conn.prepareStatement(categorySql);
            ResultSet categoryRs = categoryStmt.executeQuery();
            int totalCategories = 0;
            if (categoryRs.next()) {
                totalCategories = categoryRs.getInt("count");
            }
            
            // Toplam sipariş sayısı
            String orderSql = "SELECT COUNT(*) as count FROM orders";
            PreparedStatement orderStmt = conn.prepareStatement(orderSql);
            ResultSet orderRs = orderStmt.executeQuery();
            int totalOrders = 0;
            if (orderRs.next()) {
                totalOrders = orderRs.getInt("count");
            }
            
            // Toplam kullanıcı sayısı
            String userSql = "SELECT COUNT(*) as count FROM users";
            PreparedStatement userStmt = conn.prepareStatement(userSql);
            ResultSet userRs = userStmt.executeQuery();
            int totalUsers = 0;
            if (userRs.next()) {
                totalUsers = userRs.getInt("count");
            }
            
            // Bekleyen sipariş sayısı
            String pendingSql = "SELECT COUNT(*) as count FROM orders WHERE status = 'Beklemede'";
            PreparedStatement pendingStmt = conn.prepareStatement(pendingSql);
            ResultSet pendingRs = pendingStmt.executeQuery();
            int pendingOrders = 0;
            if (pendingRs.next()) {
                pendingOrders = pendingRs.getInt("count");
            }
            
            // Sonuçları kapat
            productRs.close();
            productStmt.close();
            categoryRs.close();
            categoryStmt.close();
            orderRs.close();
            orderStmt.close();
            userRs.close();
            userStmt.close();
            pendingRs.close();
            pendingStmt.close();
            conn.close();
            
            // Attribute'ları set et
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("totalCategories", totalCategories);
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("pendingOrders", pendingOrders);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}
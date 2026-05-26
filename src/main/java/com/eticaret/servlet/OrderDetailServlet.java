package com.eticaret.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.eticaret.util.DBConnection;

@WebServlet("/order-detail")
public class OrderDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Kullanıcı kontrolü
        if (session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        
        int orderId = Integer.parseInt(request.getParameter("id"));
        int userId = (int) session.getAttribute("userId");
        
        // Sipariş bilgilerini getir
        Map<String, Object> orderInfo = new HashMap<>();
        List<Map<String, Object>> orderItems = new ArrayList<>();
        
        try {
            Connection conn = DBConnection.getConnection();
            
            // Sipariş bilgisi
            String orderSql = "SELECT * FROM orders WHERE id = ? AND user_id = ?";
            PreparedStatement orderStmt = conn.prepareStatement(orderSql);
            orderStmt.setInt(1, orderId);
            orderStmt.setInt(2, userId);
            ResultSet orderRs = orderStmt.executeQuery();
            
            if (orderRs.next()) {
                orderInfo.put("id", orderRs.getInt("id"));
                orderInfo.put("orderDate", orderRs.getTimestamp("order_date"));
                orderInfo.put("totalAmount", orderRs.getDouble("total_amount"));
                orderInfo.put("status", orderRs.getString("status"));
            }
            
            // Sipariş ürünleri
            String itemsSql = "SELECT oi.*, p.name as product_name " +
                             "FROM order_items oi " +
                             "JOIN products p ON oi.product_id = p.id " +
                             "WHERE oi.order_id = ?";
            PreparedStatement itemsStmt = conn.prepareStatement(itemsSql);
            itemsStmt.setInt(1, orderId);
            ResultSet itemsRs = itemsStmt.executeQuery();
            
            while (itemsRs.next()) {
                Map<String, Object> item = new HashMap<>();
                item.put("productName", itemsRs.getString("product_name"));
                item.put("quantity", itemsRs.getInt("quantity"));
                item.put("unitPrice", itemsRs.getDouble("unit_price"));
                item.put("subtotal", itemsRs.getDouble("subtotal"));
                orderItems.add(item);
            }
            
            orderRs.close();
            orderStmt.close();
            itemsRs.close();
            itemsStmt.close();
            conn.close();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        request.setAttribute("orderInfo", orderInfo);
        request.setAttribute("orderItems", orderItems);
        request.getRequestDispatcher("/order-detail.jsp").forward(request, response);
    }
}
package com.eticaret.servlet.admin;

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

import com.eticaret.util.DBConnection;

@WebServlet("/admin/orders")
public class AdminOrdersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("detail".equals(action)) {
            showOrderDetail(request, response);
        } else {
            showOrders(request, response);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        updateOrderStatus(request, response);
    }
    
    // Tüm siparişleri göster
    private void showOrders(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Map<String, Object>> orders = new ArrayList<>();
        
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT o.*, u.full_name FROM orders o " +
                        "JOIN users u ON o.user_id = u.id " +
                        "ORDER BY o.order_date DESC";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> order = new HashMap<>();
                order.put("id", rs.getInt("id"));
                order.put("userName", rs.getString("full_name"));
                order.put("orderDate", rs.getTimestamp("order_date"));
                order.put("totalAmount", rs.getDouble("total_amount"));
                order.put("status", rs.getString("status"));
                orders.add(order);
            }
            
            rs.close();
            stmt.close();
            conn.close();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/admin/orders.jsp").forward(request, response);
    }
    
    // Sipariş durumunu güncelle
    private void updateOrderStatus(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String status = request.getParameter("status");
            
            Connection conn = DBConnection.getConnection();
            String sql = "UPDATE orders SET status = ? WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, status);
            stmt.setInt(2, orderId);
            stmt.executeUpdate();
            
            stmt.close();
            conn.close();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        response.sendRedirect("orders");
    }
    
    // Sipariş detayını göster
    private void showOrderDetail(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int orderId = Integer.parseInt(request.getParameter("id"));
        
        Map<String, Object> orderInfo = new HashMap<>();
        List<Map<String, Object>> orderItems = new ArrayList<>();
        
        try {
            Connection conn = DBConnection.getConnection();
            
            // Sipariş bilgisi
            String orderSql = "SELECT o.*, u.full_name FROM orders o " +
                             "JOIN users u ON o.user_id = u.id " +
                             "WHERE o.id = ?";
            PreparedStatement orderStmt = conn.prepareStatement(orderSql);
            orderStmt.setInt(1, orderId);
            ResultSet orderRs = orderStmt.executeQuery();
            
            if (orderRs.next()) {
                orderInfo.put("id", orderRs.getInt("id"));
                orderInfo.put("userName", orderRs.getString("full_name"));
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
        request.getRequestDispatcher("/admin/order-detail.jsp").forward(request, response);
    }
}	
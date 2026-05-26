package com.eticaret.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.eticaret.dao.OrderDAO;
import com.eticaret.model.CartItem;
import com.eticaret.util.DBConnection;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private OrderDAO orderDAO;
    
    public void init() {
        orderDAO = new OrderDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Kullanıcı kontrolü
        if (session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        
        // Sepet kontrolü
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("home");
            return;
        }
        
        // Toplam tutarı hesapla
        double total = 0;
        for (CartItem item : cart) {
            total += item.getSubtotal();
        }
        
        // Sipariş oluştur
        int userId = (int) session.getAttribute("userId");
        boolean success = orderDAO.createOrder(userId, cart, total);
        
        if (success) {
            // STOK GÜNCELLE
            updateStock(cart);
            
            // Sepeti temizle
            session.removeAttribute("cart");
            
            // Başarı sayfasına yönlendir
            request.setAttribute("message", "Siparişiniz başarıyla oluşturuldu!");
            request.getRequestDispatcher("/order-success.jsp").forward(request, response);
        } else {
            // Hata
            request.setAttribute("error", "Sipariş oluşturulamadı! Lütfen tekrar deneyin.");
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
    
    // Stokları güncelle
    private void updateStock(List<CartItem> cart) {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "UPDATE products SET stock = stock - ? WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            
            for (CartItem item : cart) {
                stmt.setInt(1, item.getQuantity());
                stmt.setInt(2, item.getProductId());
                stmt.executeUpdate();
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
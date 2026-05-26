package com.eticaret.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.eticaret.dao.ProductDAO;
import com.eticaret.model.CartItem;
import com.eticaret.model.Product;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ProductDAO productDAO;
    
    public void init() {
        productDAO = new ProductDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            addToCart(request, response);
        } else if ("remove".equals(action)) {
            removeFromCart(request, response);
        } else if ("update".equals(action)) {
            updateCart(request, response);
        } else {
            // Sepeti göster
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
    
    // Sepete ürün ekle
    private void addToCart(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        HttpSession session = request.getSession();
        
        // Kullanıcı giriş yapmış mı kontrol et
        if (session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        
        int productId = Integer.parseInt(request.getParameter("productId"));
        Product product = productDAO.getProductById(productId);
        
        if (product == null) {
            response.sendRedirect("home");
            return;
        }
        
        // STOK KONTROLÜ
        if (product.getStock() <= 0) {
            session.setAttribute("error", "Bu ürün stokta yok!");
            response.sendRedirect("home");
            return;
        }
        
        // Sepeti session'dan al (yoksa oluştur)
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }
        
        // Ürün sepette var mı kontrol et
        boolean found = false;
        for (CartItem item : cart) {
            if (item.getProductId() == productId) {
                // STOK KONTROLÜ - Sepetteki miktar stoktan fazla olamaz
                if (item.getQuantity() + 1 > product.getStock()) {
                    session.setAttribute("error", "Stokta yeterli ürün yok! Maksimum " + product.getStock() + " adet ekleyebilirsiniz.");
                    response.sendRedirect("cart");
                    return;
                }
                item.setQuantity(item.getQuantity() + 1);
                found = true;
                break;
            }
        }
        
        // Yoksa yeni ekle
        if (!found) {
            CartItem newItem = new CartItem(
                product.getId(),
                product.getName(),
                product.getPrice(),
                1
            );
            cart.add(newItem);
        }
        
        // Sepeti session'a kaydet
        session.setAttribute("cart", cart);
        
        // Sepet sayfasına yönlendir
        response.sendRedirect("cart");
    }
    
    // Sepetten ürün çıkar
    private void removeFromCart(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        HttpSession session = request.getSession();
        int productId = Integer.parseInt(request.getParameter("productId"));
        
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart != null) {
            cart.removeIf(item -> item.getProductId() == productId);
            session.setAttribute("cart", cart);
        }
        
        response.sendRedirect("cart");
    }
    
    // Sepetteki ürün miktarını güncelle
    private void updateCart(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        HttpSession session = request.getSession();
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        
        // STOK KONTROLÜ
        Product product = productDAO.getProductById(productId);
        if (product != null && quantity > product.getStock()) {
            session.setAttribute("error", "Stokta yeterli ürün yok! Maksimum " + product.getStock() + " adet ekleyebilirsiniz.");
            response.sendRedirect("cart");
            return;
        }
        
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart != null) {
            for (CartItem item : cart) {
                if (item.getProductId() == productId) {
                    if (quantity > 0) {
                        item.setQuantity(quantity);
                    } else {
                        cart.remove(item);
                    }
                    break;
                }
            }
            session.setAttribute("cart", cart);
        }
        
        response.sendRedirect("cart");
    }
}
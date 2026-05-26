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
import com.eticaret.model.Product;

@WebServlet("/favorites")
public class FavoritesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ProductDAO productDAO;
    
    public void init() {
        productDAO = new ProductDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        
        // Kullanıcı giriş kontrolü
        if (session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        
        if ("add".equals(action)) {
            addToFavorites(request, response);
        } else if ("remove".equals(action)) {
            removeFromFavorites(request, response);
        } else {
            showFavorites(request, response);
        }
    }
    
    // Favorilere ekle
    private void addToFavorites(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        HttpSession session = request.getSession();
        int productId = Integer.parseInt(request.getParameter("productId"));
        
        // Favoriler listesini al (yoksa oluştur)
        List<Integer> favorites = (List<Integer>) session.getAttribute("favorites");
        if (favorites == null) {
            favorites = new ArrayList<>();
        }
        
        // Zaten varsa ekleme
        if (!favorites.contains(productId)) {
            favorites.add(productId);
        }
        
        session.setAttribute("favorites", favorites);
        
        // Geri yönlendir
        String referer = request.getHeader("Referer");
        response.sendRedirect(referer != null ? referer : "home");
    }
    
    // Favorilerden çıkar
    private void removeFromFavorites(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        HttpSession session = request.getSession();
        int productId = Integer.parseInt(request.getParameter("productId"));
        
        List<Integer> favorites = (List<Integer>) session.getAttribute("favorites");
        if (favorites != null) {
            favorites.remove(Integer.valueOf(productId));
            session.setAttribute("favorites", favorites);
        }
        
        response.sendRedirect("favorites");
    }
    
    // Favorileri göster
    private void showFavorites(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        List<Integer> favoriteIds = (List<Integer>) session.getAttribute("favorites");
        List<Product> favoriteProducts = new ArrayList<>();
        
        if (favoriteIds != null && !favoriteIds.isEmpty()) {
            for (Integer id : favoriteIds) {
                Product product = productDAO.getProductById(id);
                if (product != null) {
                    favoriteProducts.add(product);
                }
            }
        }
        
        request.setAttribute("favoriteProducts", favoriteProducts);
        request.getRequestDispatcher("/favorites.jsp").forward(request, response);
    }
}
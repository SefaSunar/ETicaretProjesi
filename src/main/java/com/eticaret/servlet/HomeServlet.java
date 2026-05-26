package com.eticaret.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.eticaret.dao.CategoryDAO;
import com.eticaret.dao.ProductDAO;
import com.eticaret.model.Category;
import com.eticaret.model.Product;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;
    
    public void init() {
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String categoryIdStr = request.getParameter("categoryId");
        String searchQuery = request.getParameter("search");
        
        List<Product> products;
        
        // Arama varsa
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            products = productDAO.searchProducts(searchQuery);
        }
        // Kategori filtresi varsa
        else if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
            int categoryId = Integer.parseInt(categoryIdStr);
            products = productDAO.getProductsByCategory(categoryId);
        }
        // Tüm ürünler
        else {
            products = productDAO.getAllProducts();
        }
        
        List<Category> categories = categoryDAO.getAllCategories();
        
        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.setAttribute("searchQuery", searchQuery);
        
        request.getRequestDispatcher("/products.jsp").forward(request, response);
    }
}
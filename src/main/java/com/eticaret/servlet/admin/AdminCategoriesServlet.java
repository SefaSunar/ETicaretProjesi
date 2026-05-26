package com.eticaret.servlet.admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.eticaret.dao.CategoryDAO;
import com.eticaret.model.Category;
import com.eticaret.util.DBConnection;

@WebServlet("/admin/categories")
public class AdminCategoriesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private CategoryDAO categoryDAO;
    
    public void init() {
        categoryDAO = new CategoryDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            showAddForm(request, response);
        } else if ("edit".equals(action)) {
            showEditForm(request, response);
        } else if ("delete".equals(action)) {
            deleteCategory(request, response);
        } else {
            showCategories(request, response);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        
        if ("update".equals(action)) {
            updateCategory(request, response);
        } else {
            addCategory(request, response);
        }
    }
    
    // Tüm kategorileri göster
    private void showCategories(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/admin/categories.jsp").forward(request, response);
    }
    
    // Ekleme formunu göster
    private void showAddForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.getRequestDispatcher("/admin/category-add.jsp").forward(request, response);
    }
    
    // Düzenleme formunu göster
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        Category category = categoryDAO.getCategoryById(id);
        request.setAttribute("category", category);
        request.getRequestDispatcher("/admin/category-edit.jsp").forward(request, response);
    }
    
    // Yeni kategori ekle
    private void addCategory(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            
            // FORM DOĞRULAMA
            StringBuilder errors = new StringBuilder();
            
            // Kategori adı boş olamaz
            if (name == null || name.trim().isEmpty()) {
                errors.append("Kategori adı boş olamaz!<br>");
            }
            
            // Hata varsa geri dön
            if (errors.length() > 0) {
                request.setAttribute("error", errors.toString());
                request.getRequestDispatcher("/admin/category-add.jsp").forward(request, response);
                return;
            }
            
            Connection conn = DBConnection.getConnection();
            String sql = "INSERT INTO categories (name, description, is_active) VALUES (?, ?, true)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, description);
            stmt.executeUpdate();
            
            stmt.close();
            conn.close();
            
            response.sendRedirect("categories");
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Kategori eklenirken bir hata oluştu!");
            request.getRequestDispatcher("/admin/category-add.jsp").forward(request, response);
        }
    }
    
    // Kategori güncelle
    private void updateCategory(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            
            // FORM DOĞRULAMA
            StringBuilder errors = new StringBuilder();
            
            // Kategori adı boş olamaz
            if (name == null || name.trim().isEmpty()) {
                errors.append("Kategori adı boş olamaz!<br>");
            }
            
            // Hata varsa geri dön
            if (errors.length() > 0) {
                request.setAttribute("error", errors.toString());
                Category category = categoryDAO.getCategoryById(id);
                request.setAttribute("category", category);
                request.getRequestDispatcher("/admin/category-edit.jsp").forward(request, response);
                return;
            }
            
            Connection conn = DBConnection.getConnection();
            String sql = "UPDATE categories SET name = ?, description = ? WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, description);
            stmt.setInt(3, id);
            stmt.executeUpdate();
            
            stmt.close();
            conn.close();
            
            response.sendRedirect("categories");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("categories?error=true");
        }
    }
    
    // Kategori sil
    private void deleteCategory(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            
            Connection conn = DBConnection.getConnection();
            String sql = "UPDATE categories SET is_active = false WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.executeUpdate();
            
            stmt.close();
            conn.close();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        response.sendRedirect("categories");
    }
}
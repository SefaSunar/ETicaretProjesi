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
import com.eticaret.dao.ProductDAO;
import com.eticaret.model.Category;
import com.eticaret.model.Product;
import com.eticaret.util.DBConnection;

@WebServlet("/admin/products")
public class AdminProductsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;
    
    public void init() {
        productDAO = new ProductDAO();
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
            deleteProduct(request, response);
        } else {
            showProducts(request, response);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        
        if ("update".equals(action)) {
            updateProduct(request, response);
        } else {
            addProduct(request, response);
        }
    }
    
    // Tüm ürünleri göster
    private void showProducts(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Product> products = productDAO.getAllProducts();
        request.setAttribute("products", products);
        request.getRequestDispatcher("/admin/products.jsp").forward(request, response);
    }
    
    // Ürün ekleme formunu göster
    private void showAddForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/admin/product-add.jsp").forward(request, response);
    }
    
    // Düzenleme formunu göster
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int productId = Integer.parseInt(request.getParameter("id"));
        Product product = productDAO.getProductById(productId);
        List<Category> categories = categoryDAO.getAllCategories();
        
        request.setAttribute("product", product);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/admin/product-edit.jsp").forward(request, response);
    }
    
    // Yeni ürün ekle
    private void addProduct(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String categoryIdStr = request.getParameter("categoryId");
            String priceStr = request.getParameter("price");
            String stockStr = request.getParameter("stock");
            String imageUrl = request.getParameter("imageUrl");
            
            // FORM DOĞRULAMA
            StringBuilder errors = new StringBuilder();
            
            // Ürün adı boş olamaz
            if (name == null || name.trim().isEmpty()) {
                errors.append("Ürün adı boş olamaz!<br>");
            }
            
            // Kategori seçilmeli
            if (categoryIdStr == null || categoryIdStr.trim().isEmpty()) {
                errors.append("Kategori seçilmelidir!<br>");
            }
            
            // Fiyat kontrolü
            double price = 0;
            try {
                price = Double.parseDouble(priceStr);
                if (price <= 0) {
                    errors.append("Fiyat 0'dan büyük olmalıdır!<br>");
                }
            } catch (NumberFormatException e) {
                errors.append("Geçerli bir fiyat giriniz!<br>");
            }
            
            // Stok kontrolü
            int stock = 0;
            try {
                stock = Integer.parseInt(stockStr);
                if (stock < 0) {
                    errors.append("Stok miktarı negatif olamaz!<br>");
                }
            } catch (NumberFormatException e) {
                errors.append("Geçerli bir stok miktarı giriniz!<br>");
            }
            
            // Hata varsa geri dön
            if (errors.length() > 0) {
                request.setAttribute("error", errors.toString());
                List<Category> categories = categoryDAO.getAllCategories();
                request.setAttribute("categories", categories);
                request.getRequestDispatcher("/admin/product-add.jsp").forward(request, response);
                return;
            }
            
            // Kategori ID'yi parse et
            int categoryId = Integer.parseInt(categoryIdStr);
            
            // Veritabanına ekle
            Connection conn = DBConnection.getConnection();
            String sql = "INSERT INTO products (category_id, name, description, price, stock, image_url, is_active) " +
                        "VALUES (?, ?, ?, ?, ?, ?, true)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, categoryId);
            stmt.setString(2, name);
            stmt.setString(3, description);
            stmt.setDouble(4, price);
            stmt.setInt(5, stock);
            stmt.setString(6, imageUrl);
            stmt.executeUpdate();
            
            stmt.close();
            conn.close();
            
            response.sendRedirect("products");
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Ürün eklenirken bir hata oluştu!");
            List<Category> categories = categoryDAO.getAllCategories();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/admin/product-add.jsp").forward(request, response);
        }
    }
    
    // Ürün güncelle
    private void updateProduct(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String categoryIdStr = request.getParameter("categoryId");
            String priceStr = request.getParameter("price");
            String stockStr = request.getParameter("stock");
            String imageUrl = request.getParameter("imageUrl");
            
            // FORM DOĞRULAMA
            StringBuilder errors = new StringBuilder();
            
            // Ürün adı boş olamaz
            if (name == null || name.trim().isEmpty()) {
                errors.append("Ürün adı boş olamaz!<br>");
            }
            
            // Kategori seçilmeli
            if (categoryIdStr == null || categoryIdStr.trim().isEmpty()) {
                errors.append("Kategori seçilmelidir!<br>");
            }
            
            // Fiyat kontrolü
            double price = 0;
            try {
                price = Double.parseDouble(priceStr);
                if (price <= 0) {
                    errors.append("Fiyat 0'dan büyük olmalıdır!<br>");
                }
            } catch (NumberFormatException e) {
                errors.append("Geçerli bir fiyat giriniz!<br>");
            }
            
            // Stok kontrolü
            int stock = 0;
            try {
                stock = Integer.parseInt(stockStr);
                if (stock < 0) {
                    errors.append("Stok miktarı negatif olamaz!<br>");
                }
            } catch (NumberFormatException e) {
                errors.append("Geçerli bir stok miktarı giriniz!<br>");
            }
            
            // Hata varsa geri dön
            if (errors.length() > 0) {
                request.setAttribute("error", errors.toString());
                Product product = productDAO.getProductById(id);
                List<Category> categories = categoryDAO.getAllCategories();
                request.setAttribute("product", product);
                request.setAttribute("categories", categories);
                request.getRequestDispatcher("/admin/product-edit.jsp").forward(request, response);
                return;
            }
            
            // Kategori ID'yi parse et
            int categoryId = Integer.parseInt(categoryIdStr);
            
            // Veritabanını güncelle
            Connection conn = DBConnection.getConnection();
            String sql = "UPDATE products SET category_id = ?, name = ?, description = ?, " +
                        "price = ?, stock = ?, image_url = ? WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, categoryId);
            stmt.setString(2, name);
            stmt.setString(3, description);
            stmt.setDouble(4, price);
            stmt.setInt(5, stock);
            stmt.setString(6, imageUrl);
            stmt.setInt(7, id);
            stmt.executeUpdate();
            
            stmt.close();
            conn.close();
            
            response.sendRedirect("products");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("products?error=true");
        }
    }
    
    // Ürün sil
    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        try {
            int productId = Integer.parseInt(request.getParameter("id"));
            
            Connection conn = DBConnection.getConnection();
            String sql = "UPDATE products SET is_active = false WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, productId);
            stmt.executeUpdate();
            
            stmt.close();
            conn.close();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        response.sendRedirect("products");
    }
}
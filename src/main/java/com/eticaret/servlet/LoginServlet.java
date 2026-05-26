package com.eticaret.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.eticaret.dao.UserDAO;
import com.eticaret.model.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private UserDAO userDAO;
    
    public void init() {
        userDAO = new UserDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // FORM DOĞRULAMA
        StringBuilder errors = new StringBuilder();
        
        // Email boş olamaz
        if (email == null || email.trim().isEmpty()) {
            errors.append("Email boş olamaz!<br>");
        }
        
        // Şifre boş olamaz
        if (password == null || password.trim().isEmpty()) {
            errors.append("Şifre boş olamaz!<br>");
        }
        
        // Hata varsa geri dön
        if (errors.length() > 0) {
            request.setAttribute("error", errors.toString());
            request.setAttribute("email", email);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
        
        // Kullanıcı girişini kontrol et
        User user = userDAO.login(email, password);
        
        if (user != null) {
            // Giriş başarılı - Session oluştur
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("userName", user.getFullName());
            session.setAttribute("userRole", user.getRole());
            
            // Admin ise admin paneline, değilse ana sayfaya yönlendir
            if ("admin".equals(user.getRole())) {
                response.sendRedirect("admin/dashboard");
            } else {
                response.sendRedirect("home");
            }
        } else {
            // Giriş başarısız
            request.setAttribute("error", "Email veya şifre hatalı!");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
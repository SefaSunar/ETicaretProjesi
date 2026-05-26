package com.eticaret.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.eticaret.dao.UserDAO;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private UserDAO userDAO;
    
    public void init() {
        userDAO = new UserDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        
        // FORM DOĞRULAMA
        StringBuilder errors = new StringBuilder();
        
        // Ad soyad boş olamaz
        if (fullName == null || fullName.trim().isEmpty()) {
            errors.append("Ad soyad boş olamaz!<br>");
        }
        
        // Email boş olamaz ve geçerli formatta olmalı
        if (email == null || email.trim().isEmpty()) {
            errors.append("Email boş olamaz!<br>");
        } else if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            errors.append("Geçerli bir email adresi giriniz!<br>");
        }
        
        // Şifre en az 4 karakter olmalı
        if (password == null || password.trim().isEmpty()) {
            errors.append("Şifre boş olamaz!<br>");
        } else if (password.length() < 4) {
            errors.append("Şifre en az 4 karakter olmalıdır!<br>");
        }
        
        // Telefon boş olamaz
        if (phone == null || phone.trim().isEmpty()) {
            errors.append("Telefon boş olamaz!<br>");
        }
        
        // Hata varsa geri dön
        if (errors.length() > 0) {
            request.setAttribute("error", errors.toString());
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("address", address);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        // Email benzersizlik kontrolü
        if (userDAO.emailExists(email)) {
            request.setAttribute("error", "Bu email adresi zaten kayıtlı!");
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("address", address);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        // Kullanıcıyı kaydet
        boolean success = userDAO.registerUser(fullName, email, password, phone, address);
        
        if (success) {
            request.setAttribute("success", "Kayıt başarılı! Giriş yapabilirsiniz.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Kayıt sırasında bir hata oluştu!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}
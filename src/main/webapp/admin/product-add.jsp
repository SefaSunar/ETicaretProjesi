<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Yeni Ürün Ekle - Admin</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }
        .header {
            background: #34495e;
            color: white;
            padding: 20px;
            text-align: center;
        }
        .container {
            max-width: 600px;
            margin: 30px auto;
            padding: 20px;
        }
        .form-card {
            background: white;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }
        input[type="text"],
        input[type="number"],
        textarea,
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            box-sizing: border-box;
        }
        textarea {
            resize: vertical;
            min-height: 80px;
        }
        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
        }
        .btn-save {
            background: #27ae60;
            color: white;
        }
        .btn-save:hover {
            background: #229954;
        }
        .btn-cancel {
            background: #95a5a6;
            color: white;
            text-decoration: none;
            display: inline-block;
            margin-left: 10px;
        }
        .btn-cancel:hover {
            background: #7f8c8d;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>➕ Yeni Ürün Ekle</h1>
    </div>
    
    <div class="container">
        <div class="form-card">
            <form action="products" method="post">
                <div class="form-group">
                    <label>Ürün Adı *</label>
                    <input type="text" name="name" required>
                </div>
                
                <div class="form-group">
                    <label>Açıklama *</label>
                    <textarea name="description" required></textarea>
                </div>
                
                <div class="form-group">
                    <label>Kategori *</label>
                    <select name="categoryId" required>
                        <option value="">Seçiniz...</option>
                        <c:forEach items="${categories}" var="category">
                            <option value="${category.id}">${category.name}</option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="form-group">
                    <label>Fiyat (TL) *</label>
                    <input type="number" name="price" step="0.01" required>
                </div>
                
                <div class="form-group">
                    <label>Stok *</label>
                    <input type="number" name="stock" required>
                </div>
                
                <div class="form-group">
                    <label>Resim URL</label>
                    <input type="text" name="imageUrl" placeholder="http://...">
                </div>
                
                <button type="submit" class="btn btn-save">Kaydet</button>
                <a href="products" class="btn btn-cancel">İptal</a>
            </form>
        </div>
    </div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Kullanıcı Düzenle - Admin</title>
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
        input[type="email"],
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
            background: #3498db;
            color: white;
        }
        .btn-save:hover {
            background: #2980b9;
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
        <h1>✏️ Kullanıcı Düzenle</h1>
    </div>
    
    <div class="container">
        <div class="form-card">
            <form action="users" method="post">
                <input type="hidden" name="id" value="${user.id}">
                
                <div class="form-group">
                    <label>Ad Soyad *</label>
                    <input type="text" name="fullName" value="${user.fullName}" required>
                </div>
                
                <div class="form-group">
                    <label>Email *</label>
                    <input type="email" name="email" value="${user.email}" required>
                </div>
                
                <div class="form-group">
                    <label>Telefon</label>
                    <input type="text" name="phone" value="${user.phone}">
                </div>
                
                <div class="form-group">
                    <label>Adres</label>
                    <textarea name="address">${user.address}</textarea>
                </div>
                
                <div class="form-group">
                    <label>Rol *</label>
                    <select name="role" required>
                        <option value="customer" ${user.role == 'customer' ? 'selected' : ''}>Müşteri</option>
                        <option value="admin" ${user.role == 'admin' ? 'selected' : ''}>Admin</option>
                    </select>
                </div>
                
                <button type="submit" class="btn btn-save">Güncelle</button>
                <a href="users" class="btn btn-cancel">İptal</a>
            </form>
        </div>
    </div>
</body>
</html>
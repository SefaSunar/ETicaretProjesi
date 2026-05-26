<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ürün Yönetimi - Admin</title>
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
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header h1 {
            margin: 0;
        }
        .nav-buttons a {
            color: white;
            text-decoration: none;
            background: #3498db;
            padding: 10px 20px;
            border-radius: 5px;
            margin-left: 10px;
        }
        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 20px;
        }
        .add-button {
            background: #27ae60;
            color: white;
            padding: 12px 30px;
            border-radius: 5px;
            text-decoration: none;
            display: inline-block;
            margin-bottom: 20px;
            font-weight: bold;
        }
        .products-table {
            background: white;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background: #34495e;
            color: white;
        }
        .btn {
            padding: 8px 15px;
            border-radius: 5px;
            text-decoration: none;
            display: inline-block;
            margin-right: 5px;
        }
        .btn-edit {
            background: #3498db;
            color: white;
        }
        .btn-edit:hover {
            background: #2980b9;
        }
        .btn-delete {
            background: #e74c3c;
            color: white;
            border: none;
            cursor: pointer;
        }
        .btn-delete:hover {
            background: #c0392b;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>📦 Ürün Yönetimi</h1>
        <div class="nav-buttons">
            <a href="dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/home">Ana Sayfa</a>
        </div>
    </div>
    
    <div class="container">
        <a href="products?action=add" class="add-button">+ Yeni Ürün Ekle</a>
        
        <div class="products-table">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Ürün Adı</th>
                        <th>Açıklama</th>
                        <th>Fiyat</th>
                        <th>Stok</th>
                        <th>İşlem</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${products}" var="product">
                        <tr>
                            <td>${product.id}</td>
                            <td>${product.name}</td>
                            <td>${product.description}</td>
                            <td>${product.price} TL</td>
                            <td>${product.stock}</td>
                            <td>
                                <a href="products?action=edit&id=${product.id}" class="btn btn-edit">Düzenle</a>
                                <a href="products?action=delete&id=${product.id}" 
                                   class="btn btn-delete" 
                                   onclick="return confirm('Bu ürünü silmek istediğinize emin misiniz?')">Sil</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
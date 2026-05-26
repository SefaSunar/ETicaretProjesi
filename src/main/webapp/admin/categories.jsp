<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Kategori Yönetimi - Admin</title>
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
        .categories-table {
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
        .btn-delete {
            background: #e74c3c;
            color: white;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>🏷️ Kategori Yönetimi</h1>
        <div class="nav-buttons">
            <a href="dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/home">Ana Sayfa</a>
        </div>
    </div>
    
    <div class="container">
        <a href="categories?action=add" class="add-button">+ Yeni Kategori Ekle</a>
        
        <div class="categories-table">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Kategori Adı</th>
                        <th>Açıklama</th>
                        <th>Durum</th>
                        <th>İşlem</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${categories}" var="category">
                        <tr>
                            <td>${category.id}</td>
                            <td>${category.name}</td>
                            <td>${category.description}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${category.active}">
                                        <span style="color: #27ae60;">✓ Aktif</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color: #e74c3c;">✗ Pasif</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="categories?action=edit&id=${category.id}" class="btn btn-edit">Düzenle</a>
                                <a href="categories?action=delete&id=${category.id}" 
                                   class="btn btn-delete" 
                                   onclick="return confirm('Bu kategoriyi silmek istediğinize emin misiniz?')">Sil</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
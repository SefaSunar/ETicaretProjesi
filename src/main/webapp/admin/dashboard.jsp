<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - E-Ticaret</title>
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
        .nav-buttons a:hover {
            background: #2980b9;
        }
        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 20px;
        }
        .stats {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-card {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            text-align: center;
        }
        .stat-card h3 {
            margin: 0 0 10px 0;
            color: #7f8c8d;
            font-size: 14px;
            text-transform: uppercase;
        }
        .stat-card .number {
            font-size: 48px;
            font-weight: bold;
            color: #2c3e50;
        }
        .stat-card.products .number {
            color: #3498db;
        }
        .stat-card.categories .number {
            color: #e74c3c;
        }
        .stat-card.orders .number {
            color: #f39c12;
        }
        .stat-card.users .number {
            color: #27ae60;
        }
        .stat-card.pending .number {
            color: #9b59b6;
        }
        .menu {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
        }
        .menu-card {
            background: white;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            text-align: center;
            cursor: pointer;
            transition: transform 0.2s;
        }
        .menu-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }
        .menu-card h2 {
            margin: 20px 0 10px 0;
            color: #2c3e50;
        }
        .menu-card p {
            color: #7f8c8d;
        }
        .icon {
            font-size: 60px;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>👨‍💼 Admin Paneli</h1>
        <div class="nav-buttons">
            <span style="margin-right: 20px;">Hoşgeldin, ${sessionScope.userName}!</span>
            <a href="${pageContext.request.contextPath}/home">🏠 Ana Sayfa</a>
            <a href="${pageContext.request.contextPath}/logout">Çıkış Yap</a>
        </div>
    </div>
    
    <div class="container">
        <div class="stats">
            <div class="stat-card products">
                <h3>Toplam Ürün</h3>
                <div class="number">${totalProducts}</div>
            </div>
            
            <div class="stat-card categories">
                <h3>Toplam Kategori</h3>
                <div class="number">${totalCategories}</div>
            </div>
            
            <div class="stat-card orders">
                <h3>Toplam Sipariş</h3>
                <div class="number">${totalOrders}</div>
            </div>
            
            <div class="stat-card users">
                <h3>Toplam Kullanıcı</h3>
                <div class="number">${totalUsers}</div>
            </div>
            
            <div class="stat-card pending">
                <h3>Bekleyen Sipariş</h3>
                <div class="number">${pendingOrders}</div>
            </div>
        </div>
        
        <div class="menu">
            <a href="products" style="text-decoration: none;">
                <div class="menu-card">
                    <div class="icon">📦</div>
                    <h2>Ürün Yönetimi</h2>
                    <p>Ürün ekleme, düzenleme ve silme</p>
                </div>
            </a>
            
            <a href="categories" style="text-decoration: none;">
                <div class="menu-card">
                    <div class="icon">🏷️</div>
                    <h2>Kategori Yönetimi</h2>
                    <p>Kategori ekleme ve düzenleme</p>
                </div>
            </a>
            
            <a href="orders" style="text-decoration: none;">
                <div class="menu-card">
                    <div class="icon">📋</div>
                    <h2>Sipariş Yönetimi</h2>
                    <p>Siparişleri görüntüleme ve güncelleme</p>
                </div>
            </a>
            
            <a href="users" style="text-decoration: none;">
                <div class="menu-card">
                    <div class="icon">👥</div>
                    <h2>Kullanıcı Yönetimi</h2>
                    <p>Kullanıcıları görüntüleme ve düzenleme</p>
                </div>
            </a>
        </div>
    </div>
</body>
</html>
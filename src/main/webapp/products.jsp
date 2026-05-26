<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>E-Ticaret - Ürünler</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }
        .header {
            background: #2c3e50;
            color: white;
            padding: 20px;
            text-align: center;
        }
        .header h1 {
            margin: 0;
        }
        .search-box {
            background: white;
            padding: 20px;
            margin: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            text-align: center;
        }
        .search-box input[type="text"] {
            width: 70%;
            padding: 12px;
            border: 2px solid #3498db;
            border-radius: 5px 0 0 5px;
            font-size: 16px;
            outline: none;
        }
        .search-box button {
            width: 28%;
            padding: 12px;
            background: #3498db;
            color: white;
            border: none;
            border-radius: 0 5px 5px 0;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
        }
        .search-box button:hover {
            background: #2980b9;
        }
        .category-filter {
            background: white;
            padding: 15px;
            margin: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            text-align: center;
        }
        .category-filter button {
            background: #3498db;
            color: white;
            border: none;
            padding: 10px 20px;
            margin: 5px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }
        .category-filter button:hover {
            background: #2980b9;
        }
        .product-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
            padding: 20px;
        }
        .product-card {
            background: white;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            width: 250px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            transition: transform 0.2s;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }
        .product-card h3 {
            color: #2c3e50;
            margin: 10px 0;
        }
        .product-card p {
            color: #666;
            font-size: 14px;
            margin: 5px 0;
        }
        .price {
            color: #e74c3c;
            font-size: 20px;
            font-weight: bold;
            margin: 10px 0;
        }
        .stock {
            color: #27ae60;
            font-size: 12px;
        }
        .no-products {
            text-align: center;
            color: #999;
            padding: 50px;
            font-size: 18px;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>🛒 E-Ticaret Mağazası</h1>
        <div style="margin-top: 10px;">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <span style="color: white;">Hoşgeldin, ${sessionScope.userName}!</span>
                    <a href="favorites" style="color: white; margin-left: 15px; text-decoration: none; background: #e74c3c; padding: 8px 15px; border-radius: 5px;">❤️ Favorilerim</a>
                    <a href="cart" style="color: white; margin-left: 15px; text-decoration: none; background: #f39c12; padding: 8px 15px; border-radius: 5px;">🛒 Sepetim</a>
                    <a href="orders" style="color: white; margin-left: 15px; text-decoration: none; background: #9b59b6; padding: 8px 15px; border-radius: 5px;">📦 Siparişlerim</a>
                    <a href="logout" style="color: white; margin-left: 15px; text-decoration: none; background: #e74c3c; padding: 8px 15px; border-radius: 5px;">Çıkış Yap</a>
                </c:when>
                <c:otherwise>
                    <a href="login" style="color: white; margin-right: 10px; text-decoration: none; background: #3498db; padding: 8px 15px; border-radius: 5px;">Giriş Yap</a>
                    <a href="register" style="color: white; text-decoration: none; background: #27ae60; padding: 8px 15px; border-radius: 5px;">Kayıt Ol</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
    <div class="search-box">
        <form action="home" method="get" style="display: inline-block; width: 100%; max-width: 600px;">
            <input type="text" name="search" placeholder="Ürün ara... (ör: iPhone, Samsung, Kitap)" value="${searchQuery}">
            <button type="submit">🔍 Ara</button>
        </form>
        <c:if test="${not empty searchQuery}">
            <p style="margin-top: 10px; color: #7f8c8d;">
                "<strong>${searchQuery}</strong>" için arama sonuçları
                <a href="home" style="color: #e74c3c; margin-left: 10px;">✖ Temizle</a>
            </p>
        </c:if>
    </div>
    
    <div class="category-filter">
        <form action="home" method="get" style="display: inline;">
            <button type="submit">Tüm Ürünler</button>
        </form>
        
        <c:forEach items="${categories}" var="category">
            <form action="home" method="get" style="display: inline;">
                <input type="hidden" name="categoryId" value="${category.id}">
                <button type="submit">${category.name}</button>
            </form>
        </c:forEach>
    </div>
    
    <div class="product-container">
        <c:forEach items="${products}" var="product">
            <div class="product-card">
                <h3>${product.name}</h3>
                <p>${product.description}</p>
                <p class="price">${product.price} TL</p>
                <p class="stock">Stok: ${product.stock} adet</p>
                
                <a href="product-detail?id=${product.id}" style="display: block; width: 100%; padding: 10px; background: #3498db; color: white; text-align: center; text-decoration: none; border-radius: 5px; margin-top: 10px; font-weight: bold;">📄 Detay</a>
                
                <c:if test="${not empty sessionScope.user}">
                    <form action="favorites" method="get" style="margin-top: 10px;">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId" value="${product.id}">
                        <button type="submit" style="width: 100%; padding: 10px; background: #e74c3c; color: white; border: none; border-radius: 5px; cursor: pointer; font-weight: bold;">❤️ Favorilere Ekle</button>
                    </form>
                    
                    <form action="cart" method="get" style="margin-top: 10px;">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId" value="${product.id}">
                        <button type="submit" style="width: 100%; padding: 10px; background: #27ae60; color: white; border: none; border-radius: 5px; cursor: pointer; font-weight: bold;">🛒 Sepete Ekle</button>
                    </form>
                </c:if>
            </div>
        </c:forEach>
    </div>
    
    <c:if test="${empty products}">
        <div class="no-products">
            <c:choose>
                <c:when test="${not empty searchQuery}">
                    "<strong>${searchQuery}</strong>" için sonuç bulunamadı.
                </c:when>
                <c:otherwise>
                    Bu kategoride henüz ürün bulunmuyor.
                </c:otherwise>
            </c:choose>
        </div>
    </c:if>
</body>
</html>
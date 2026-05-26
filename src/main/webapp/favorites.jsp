<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Favorilerim - E-Ticaret</title>
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
        .nav-buttons {
            margin-top: 10px;
        }
        .nav-buttons a {
            color: white;
            text-decoration: none;
            background: #3498db;
            padding: 8px 15px;
            border-radius: 5px;
            margin: 0 5px;
        }
        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 20px;
        }
        .product-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }
        .product-card {
            background: white;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            width: 250px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            position: relative;
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
        .btn-remove {
            background: #e74c3c;
            color: white;
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            margin-top: 10px;
            font-weight: bold;
        }
        .btn-remove:hover {
            background: #c0392b;
        }
        .btn-detail {
            display: block;
            width: 100%;
            padding: 10px;
            background: #3498db;
            color: white;
            text-align: center;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 10px;
            font-weight: bold;
        }
        .no-favorites {
            text-align: center;
            padding: 50px;
            background: white;
            border-radius: 8px;
            color: #7f8c8d;
        }
        .no-favorites h2 {
            color: #95a5a6;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>❤️ Favorilerim</h1>
        <div class="nav-buttons">
            <c:if test="${not empty sessionScope.user}">
                <span style="color: white;">Hoşgeldin, ${sessionScope.userName}!</span>
            </c:if>
            <a href="home">Ana Sayfa</a>
            <a href="cart">Sepetim</a>
            <a href="orders">Siparişlerim</a>
        </div>
    </div>
    
    <div class="container">
        <c:choose>
            <c:when test="${not empty favoriteProducts}">
                <div class="product-container">
                    <c:forEach items="${favoriteProducts}" var="product">
                        <div class="product-card">
                            <h3>${product.name}</h3>
                            <p>${product.description}</p>
                            <p class="price"><fmt:formatNumber value="${product.price}" pattern="#,##0.00"/> TL</p>
                            <p style="color: #27ae60; font-size: 12px;">Stok: ${product.stock} adet</p>
                            
                            <a href="product-detail?id=${product.id}" class="btn-detail">📄 Detay</a>
                            
                            <form action="favorites" method="get" style="margin-top: 10px;">
                                <input type="hidden" name="action" value="remove">
                                <input type="hidden" name="productId" value="${product.id}">
                                <button type="submit" class="btn-remove">💔 Favorilerden Çıkar</button>
                            </form>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="no-favorites">
                    <h2>Henüz favori ürününüz yok</h2>
                    <p>Ürünleri favorilere eklemek için <a href="home" style="color: #3498db;">buraya tıklayın</a></p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
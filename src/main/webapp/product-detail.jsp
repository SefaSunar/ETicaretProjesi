<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${product.name} - Ürün Detayı</title>
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
            max-width: 1000px;
            margin: 30px auto;
            padding: 20px;
        }
        .product-detail {
            background: white;
            border-radius: 8px;
            padding: 40px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
        }
        .product-image {
            text-align: center;
        }
        .product-image img {
            max-width: 100%;
            border-radius: 8px;
            border: 1px solid #ddd;
        }
        .product-info h2 {
            color: #2c3e50;
            margin-top: 0;
        }
        .price {
            font-size: 32px;
            color: #e74c3c;
            font-weight: bold;
            margin: 20px 0;
        }
        .description {
            color: #666;
            line-height: 1.6;
            margin: 20px 0;
        }
        .stock-info {
            padding: 10px;
            border-radius: 5px;
            margin: 20px 0;
        }
        .in-stock {
            background: #d4edda;
            color: #155724;
        }
        .out-of-stock {
            background: #f8d7da;
            color: #721c24;
        }
        .btn {
            padding: 15px 30px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            text-decoration: none;
            display: inline-block;
        }
        .btn-add-cart {
            background: #27ae60;
            color: white;
            width: 100%;
            margin-top: 20px;
        }
        .btn-add-cart:hover {
            background: #229954;
        }
        .btn-add-cart:disabled {
            background: #95a5a6;
            cursor: not-allowed;
        }
        .btn-back {
            background: #95a5a6;
            color: white;
            margin-top: 10px;
            width: 100%;
            text-align: center;
        }
        .product-meta {
            color: #7f8c8d;
            font-size: 14px;
            margin: 10px 0;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>🛒 Ürün Detayı</h1>
        <div class="nav-buttons">
            <c:if test="${not empty sessionScope.user}">
                <span style="color: white;">Hoşgeldin, ${sessionScope.userName}!</span>
            </c:if>
            <a href="home">Ana Sayfa</a>
            <c:if test="${not empty sessionScope.user}">
                <a href="cart">Sepetim</a>
            </c:if>
        </div>
    </div>
    
    <div class="container">
        <div class="product-detail">
            <div class="product-image">
                <c:choose>
                    <c:when test="${not empty product.imageUrl}">
                        <img src="${product.imageUrl}" alt="${product.name}">
                    </c:when>
                    <c:otherwise>
                        <img src="https://via.placeholder.com/400x400?text=${product.name}" alt="${product.name}">
                    </c:otherwise>
                </c:choose>
            </div>
            
            <div class="product-info">
                <h2>${product.name}</h2>
                
                <div class="product-meta">
                    Ürün ID: #${product.id}
                </div>
                
                <div class="price">
                    <fmt:formatNumber value="${product.price}" pattern="#,##0.00"/> TL
                </div>
                
                <div class="description">
                    <strong>Açıklama:</strong><br>
                    ${product.description}
                </div>
                
                <c:choose>
                    <c:when test="${product.stock > 0}">
                        <div class="stock-info in-stock">
                            ✓ Stokta Var - ${product.stock} adet
                        </div>
                        
                        <c:if test="${not empty sessionScope.user}">
                            <form action="cart" method="get">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productId" value="${product.id}">
                                <button type="submit" class="btn btn-add-cart">🛒 Sepete Ekle</button>
                            </form>
                        </c:if>
                        
                        <c:if test="${empty sessionScope.user}">
                            <p style="text-align: center; color: #e74c3c; margin-top: 20px;">
                                Sepete eklemek için <a href="login" style="color: #3498db;">giriş yapın</a>
                            </p>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <div class="stock-info out-of-stock">
                            ✗ Stokta Yok
                        </div>
                        <button class="btn btn-add-cart" disabled>Stokta Yok</button>
                    </c:otherwise>
                </c:choose>
                
                <a href="home" class="btn btn-back">← Alışverişe Devam Et</a>
            </div>
        </div>
    </div>
</body>
</html>
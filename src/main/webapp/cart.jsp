<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sepetim - E-Ticaret</title>
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
        .container {
            max-width: 1000px;
            margin: 30px auto;
            padding: 20px;
        }
        .cart-table {
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
        .quantity-input {
            width: 60px;
            padding: 5px;
            text-align: center;
        }
        .btn {
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .btn-remove {
            background: #e74c3c;
            color: white;
        }
        .btn-update {
            background: #3498db;
            color: white;
        }
        .btn-checkout {
            background: #27ae60;
            color: white;
            font-size: 18px;
            padding: 15px 30px;
        }
        .total {
            text-align: right;
            font-size: 24px;
            font-weight: bold;
            color: #e74c3c;
            margin: 20px 0;
        }
        .empty-cart {
            text-align: center;
            padding: 50px;
            color: #999;
        }
        .actions {
            text-align: center;
            margin-top: 30px;
        }
        .btn-home {
            background: #95a5a6;
            color: white;
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>🛒 Sepetim</h1>
        <c:if test="${not empty sessionScope.user}">
            <span style="font-size: 14px;">Hoşgeldin, ${sessionScope.userName}!</span>
        </c:if>
    </div>
    
    <div class="container">
        <c:choose>
            <c:when test="${empty sessionScope.cart}">
                <div class="cart-table">
                    <div class="empty-cart">
                        <h2>Sepetiniz Boş</h2>
                        <p>Alışverişe başlamak için ürünleri inceleyebilirsiniz.</p>
                        <a href="home" class="btn btn-home">Alışverişe Başla</a>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="cart-table">
                    <table>
                        <thead>
                            <tr>
                                <th>Ürün Adı</th>
                                <th>Fiyat</th>
                                <th>Adet</th>
                                <th>Toplam</th>
                                <th>İşlem</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="total" value="0" />
                            <c:forEach items="${sessionScope.cart}" var="item">
                                <tr>
                                    <td>${item.productName}</td>
                                    <td>${item.price} TL</td>
                                    <td>
                                        <form action="cart" method="get" style="display: inline;">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="productId" value="${item.productId}">
                                            <input type="number" name="quantity" value="${item.quantity}" min="1" class="quantity-input">
                                            <button type="submit" class="btn btn-update">Güncelle</button>
                                        </form>
                                    </td>
                                    <td>${item.subtotal} TL</td>
                                    <td>
                                        <a href="cart?action=remove&productId=${item.productId}" class="btn btn-remove">Sil</a>
                                    </td>
                                </tr>
                                <c:set var="total" value="${total + item.subtotal}" />
                            </c:forEach>
                        </tbody>
                    </table>
                    
                    <div class="total">
                        Toplam: <fmt:formatNumber value="${total}" pattern="#,##0.00"/> TL
                    </div>
                    
                    <div class="actions">
                        <a href="home" class="btn btn-home">Alışverişe Devam Et</a>
                        <a href="checkout" class="btn btn-checkout">Siparişi Tamamla</a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
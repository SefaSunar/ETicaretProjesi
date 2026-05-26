<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Siparişlerim - E-Ticaret</title>
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
        .order-card {
            background: white;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 2px solid #ecf0f1;
        }
        .order-id {
            font-size: 20px;
            font-weight: bold;
            color: #2c3e50;
        }
        .order-date {
            color: #7f8c8d;
            font-size: 14px;
        }
        .order-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .order-total {
            font-size: 24px;
            color: #e74c3c;
            font-weight: bold;
        }
        .order-status {
            padding: 8px 15px;
            border-radius: 20px;
            font-weight: bold;
            font-size: 14px;
        }
        .status-beklemede {
            background: #f39c12;
            color: white;
        }
        .status-hazirlaniyor {
            background: #3498db;
            color: white;
        }
        .status-kargoda {
            background: #9b59b6;
            color: white;
        }
        .status-teslim {
            background: #27ae60;
            color: white;
        }
        .no-orders {
            text-align: center;
            padding: 50px;
            background: white;
            border-radius: 8px;
            color: #7f8c8d;
        }
        .no-orders h2 {
            color: #95a5a6;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>📦 Siparişlerim</h1>
        <div class="nav-buttons">
            <c:if test="${not empty sessionScope.user}">
                <span style="color: white;">Hoşgeldin, ${sessionScope.userName}!</span>
            </c:if>
            <a href="home">Ana Sayfa</a>
            <a href="cart">Sepetim</a>
        </div>
    </div>
    
    <div class="container">
        <c:choose>
            <c:when test="${not empty orders}">
                <c:forEach items="${orders}" var="order">
                    <div class="order-card">
                        <div class="order-header">
                            <div class="order-id">Sipariş #${order.id}</div>
                            <div class="order-date">
                                <fmt:formatDate value="${order.orderDate}" pattern="dd.MM.yyyy HH:mm"/>
                            </div>
                        </div>
                        
                        <div class="order-info">
                            <div class="order-total">
                                <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/> TL
                            </div>
                            <div>
                                <c:choose>
                                    <c:when test="${order.status == 'Beklemede'}">
                                        <span class="order-status status-beklemede">⏳ Beklemede</span>
                                    </c:when>
                                    <c:when test="${order.status == 'Hazırlanıyor'}">
                                        <span class="order-status status-hazirlaniyor">📦 Hazırlanıyor</span>
                                    </c:when>
                                    <c:when test="${order.status == 'Kargoda'}">
                                        <span class="order-status status-kargoda">🚚 Kargoda</span>
                                    </c:when>
                                    <c:when test="${order.status == 'Teslim Edildi'}">
                                        <span class="order-status status-teslim">✅ Teslim Edildi</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="order-status status-beklemede">${order.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        
                        <div style="text-align: right; margin-top: 10px;">
                            <a href="order-detail?id=${order.id}" style="display: inline-block; padding: 8px 15px; background: #3498db; color: white; text-decoration: none; border-radius: 5px; font-size: 14px;">📋 Detay Göster</a>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="no-orders">
                    <h2>Henüz hiç siparişiniz yok</h2>
                    <p>Alışverişe başlamak için <a href="home" style="color: #3498db;">buraya tıklayın</a></p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
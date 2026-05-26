<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sipariş Detayı - Admin</title>
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
        .header h1 {
            margin: 0;
        }
        .container {
            max-width: 1000px;
            margin: 30px auto;
            padding: 20px;
        }
        .order-info {
            background: white;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .order-info h2 {
            color: #2c3e50;
            margin-top: 0;
        }
        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #ecf0f1;
        }
        .info-label {
            font-weight: bold;
            color: #7f8c8d;
        }
        .info-value {
            color: #2c3e50;
        }
        .items-table {
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
        .total-row {
            font-weight: bold;
            font-size: 18px;
            color: #e74c3c;
        }
        .btn-back {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 30px;
            background: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
        }
        .btn-back:hover {
            background: #2980b9;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>📦 Sipariş Detayı - Admin</h1>
    </div>
    
    <div class="container">
        <div class="order-info">
            <h2>Sipariş Bilgileri</h2>
            
            <div class="info-row">
                <span class="info-label">Sipariş Numarası:</span>
                <span class="info-value">#${orderInfo.id}</span>
            </div>
            
            <div class="info-row">
                <span class="info-label">Müşteri Adı:</span>
                <span class="info-value">${orderInfo.userName}</span>
            </div>
            
            <div class="info-row">
                <span class="info-label">Sipariş Tarihi:</span>
                <span class="info-value">
                    <fmt:formatDate value="${orderInfo.orderDate}" pattern="dd.MM.yyyy HH:mm"/>
                </span>
            </div>
            
            <div class="info-row">
                <span class="info-label">Durum:</span>
                <span class="info-value">${orderInfo.status}</span>
            </div>
        </div>
        
        <div class="items-table">
            <h2>Sipariş Ürünleri</h2>
            <table>
                <thead>
                    <tr>
                        <th>Ürün Adı</th>
                        <th>Birim Fiyat</th>
                        <th>Adet</th>
                        <th>Ara Toplam</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${orderItems}" var="item">
                        <tr>
                            <td>${item.productName}</td>
                            <td><fmt:formatNumber value="${item.unitPrice}" pattern="#,##0.00"/> TL</td>
                            <td>${item.quantity} adet</td>
                            <td><fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00"/> TL</td>
                        </tr>
                    </c:forEach>
                    <tr class="total-row">
                        <td colspan="3" style="text-align: right;">TOPLAM:</td>
                        <td><fmt:formatNumber value="${orderInfo.totalAmount}" pattern="#,##0.00"/> TL</td>
                    </tr>
                </tbody>
            </table>
        </div>
        
        <a href="orders" class="btn-back">← Sipariş Yönetimine Dön</a>
    </div>
</body>
</html>
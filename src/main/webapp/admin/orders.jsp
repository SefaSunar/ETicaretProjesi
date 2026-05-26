<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sipariş Yönetimi - Admin</title>
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
            max-width: 1400px;
            margin: 30px auto;
            padding: 20px;
        }
        .orders-table {
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
        select {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        .btn-update {
            padding: 8px 15px;
            background: #27ae60;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }
        .btn-update:hover {
            background: #229954;
        }
        .btn-detail {
            padding: 8px 15px;
            background: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            display: inline-block;
            font-size: 14px;
        }
        .btn-detail:hover {
            background: #2980b9;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>📋 Sipariş Yönetimi</h1>
        <div class="nav-buttons">
            <a href="dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/home">Ana Sayfa</a>
        </div>
    </div>
    
    <div class="container">
        <div class="orders-table">
            <table>
                <thead>
                    <tr>
                        <th>Sipariş No</th>
                        <th>Müşteri Adı</th>
                        <th>Tarih</th>
                        <th>Toplam Tutar</th>
                        <th>Durum</th>
                        <th>İşlem</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${orders}" var="order">
                        <tr>
                            <td>#${order.id}</td>
                            <td>${order.userName}</td>
                            <td><fmt:formatDate value="${order.orderDate}" pattern="dd.MM.yyyy HH:mm"/></td>
                            <td><fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/> TL</td>
                            <td>
                                <form action="orders" method="post" style="display: inline;">
                                    <input type="hidden" name="orderId" value="${order.id}">
                                    <select name="status">
                                        <option value="Beklemede" ${order.status == 'Beklemede' ? 'selected' : ''}>Beklemede</option>
                                        <option value="Hazırlanıyor" ${order.status == 'Hazırlanıyor' ? 'selected' : ''}>Hazırlanıyor</option>
                                        <option value="Kargoya Verildi" ${order.status == 'Kargoya Verildi' ? 'selected' : ''}>Kargoya Verildi</option>
                                        <option value="Tamamlandı" ${order.status == 'Tamamlandı' ? 'selected' : ''}>Tamamlandı</option>
                                        <option value="İptal Edildi" ${order.status == 'İptal Edildi' ? 'selected' : ''}>İptal Edildi</option>
                                    </select>
                                    <button type="submit" class="btn-update">Güncelle</button>
                                </form>
                            </td>
                            <td>
                                <a href="orders?action=detail&id=${order.id}" class="btn-detail">📋 Detay</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
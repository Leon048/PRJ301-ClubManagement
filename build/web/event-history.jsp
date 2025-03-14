<%-- 
    Document   : event-history
    Created on : Mar 12, 2025, 6:37:25 AM
    Author     : admin
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.util.List, dao.EventDAO, dao.EventRegistrationDAO, model.Event" %>

<%
    // Kiểm tra người dùng đã đăng nhập chưa
    Integer userId = (Integer) session.getAttribute("userId");
    String role = (String) session.getAttribute("role");

    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Lấy danh sách sự kiện mà người dùng đã tham gia
    EventRegistrationDAO eventRegDAO = new EventRegistrationDAO();
    List<Event> registeredEvents = eventRegDAO.getEventsByUser(userId);

    // Nếu là Admin hoặc Chủ nhiệm, lấy tất cả lịch sử đăng ký của tất cả thành viên
    List<Event> allEvents = null;
    if ("Admin".equals(role) || "Chairman".equals(role) || "ViceChairman".equals(role)) {
        allEvents = eventRegDAO.getAllEventHistory();
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử sự kiện</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

<!-- Thanh điều hướng -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="home.jsp">Trang chủ</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="event-list.jsp">Sự kiện</a></li>
                <li class="nav-item"><a class="nav-link" href="profile.jsp">Hồ sơ</a></li>
                <li class="nav-item"><a class="nav-link text-danger" href="logout">Đăng xuất</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Nội dung trang -->
<div class="container mt-5">
    <h2 class="text-center">Lịch sử tham gia sự kiện</h2>

    <!-- Lịch sử sự kiện của người dùng -->
    <div class="card p-4 shadow-lg">
        <h4 class="mb-3">Sự kiện bạn đã tham gia</h4>
        <% if (registeredEvents.isEmpty()) { %>
            <p class="text-muted">Bạn chưa tham gia sự kiện nào.</p>
        <% } else { %>
            <ul class="list-group">
                <% for (Event event : registeredEvents) { %>
                    <li class="list-group-item">
                        <strong><%= event.getEventName() %></strong> - <%= event.getEventDate() %> tại <%= event.getLocation() %>
                        <a href="event-details.jsp?eventId=<%= event.getEventId() %>" class="btn btn-info btn-sm float-end">Xem chi tiết</a>
                    </li>
                <% } %>
            </ul>
        <% } %>
    </div>

    <!-- Lịch sử sự kiện của tất cả thành viên (Chỉ dành cho Admin/Chủ nhiệm) -->
    <% if (allEvents != null) { %>
        <div class="card p-4 shadow-lg mt-4">
            <h4 class="mb-3">Lịch sử đăng ký của tất cả thành viên</h4>
            <% if (allEvents.isEmpty()) { %>
                <p class="text-muted">Chưa có thành viên nào tham gia sự kiện.</p>
            <% } else { %>
                <table class="table table-bordered">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Tên sự kiện</th>
                            <th>Ngày tổ chức</th>
                            <th>Địa điểm</th>
                            <th>Thành viên</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Event event : allEvents) { %>
                        <tr>
                            <td><%= event.getEventId() %></td>
                            <td><%= event.getEventName() %></td>
                            <td><%= event.getEventDate() %></td>
                            <td><%= event.getLocation() %></td>
                            <td><%= event.getRegisteredUserName() %></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } %>
        </div>
    <% } %>

    <div class="text-center mt-4">
        <a href="home.jsp" class="btn btn-secondary">Quay lại</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


<%-- 
    Document   : event-participants
    Created on : Mar 12, 2025, 8:59:08 PM
    Author     : admin
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.util.List, dao.EventDAO, dao.UserDAO, model.User" %>

<%
    // Kiểm tra quyền truy cập (Chỉ Admin, Chủ nhiệm, Phó chủ nhiệm)
    String role = (String) session.getAttribute("role");
    if (role == null || (!"Admin".equals(role) && !"Chairman".equals(role) && !"ViceChairman".equals(role))) {
        response.sendRedirect("unauthorized.jsp");
        return;
    }

    // Lấy eventId từ request
    int eventId = Integer.parseInt(request.getParameter("eventId"));

    // Lấy danh sách người tham gia sự kiện từ EventDAO
    EventDAO eventDAO = new EventDAO();
    List<User> participants = eventDAO.getParticipantsByEvent(eventId);
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách người tham gia</title>
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
                <li class="nav-item"><a class="nav-link" href="manage-events.jsp">Quản lý sự kiện</a></li>
                <li class="nav-item"><a class="nav-link text-danger" href="logout">Đăng xuất</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Nội dung trang -->
<div class="container mt-5">
    <h2 class="text-center">Danh sách người tham gia sự kiện</h2>

    <%-- Hiển thị thông báo nếu có --%>
    <% String success = request.getParameter("success"); %>
    <% String error = request.getParameter("error"); %>
    <% if (success != null) { %>
        <div class="alert alert-success"><%= success %></div>
    <% } %>
    <% if (error != null) { %>
        <div class="alert alert-danger"><%= error %></div>
    <% } %>

    <table class="table table-bordered table-striped">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Họ và tên</th>
                <th>Email</th>
                <th>Vai trò</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <% for (User participant : participants) { %>
            <tr>
                <td><%= participant.getUserId() %></td>
                <td><%= participant.getFullName() %></td>
                <td><%= participant.getEmail() %></td>
                <td><%= participant.getRole() %></td>
                <td>
                    <a href="remove-participant?eventId=<%= eventId %>&userId=<%= participant.getUserId() %>"
                       class="btn btn-danger btn-sm"
                       onclick="return confirm('Bạn có chắc muốn xóa người tham gia này?');">
                        Xóa
                    </a>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>

    <div class="text-center mt-4">
        <a href="manage-events.jsp" class="btn btn-secondary">Quay lại</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


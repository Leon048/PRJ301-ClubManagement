<%-- 
    Document   : add-user
    Created on : Mar 12, 2025, 2:22:13 AM
    Author     : admin
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.util.List, dao.ClubDAO, model.Club" %>

<%
    // Kiểm tra quyền Admin
    String role = (String) session.getAttribute("role");
    if (role == null || !"Admin".equals(role)) {
        response.sendRedirect("unauthorized.jsp");
        return;
    }

    // Lấy danh sách câu lạc bộ để hiển thị trong dropdown
    ClubDAO clubDAO = new ClubDAO();
    List<Club> clubs = clubDAO.getAllClubs();
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm tài khoản</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

<div class="container mt-5">
    <h2 class="text-center">Thêm tài khoản người dùng</h2>
    
    <%-- Hiển thị lỗi nếu có --%>
    <% String error = (String) request.getAttribute("error"); %>
    <% if (error != null) { %>
        <div class="alert alert-danger"><%= error %></div>
    <% } %>

    <%-- Form thêm người dùng --%>
    <form action="add-user" method="post" class="card p-4 shadow-lg">
        <div class="mb-3">
            <label for="fullName" class="form-label">Họ và tên</label>
            <input type="text" class="form-control" id="fullName" name="fullName" required>
        </div>

        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" class="form-control" id="email" name="email" required>
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">Mật khẩu</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>

        <div class="mb-3">
            <label for="role" class="form-label">Vai trò</label>
            <select class="form-select" id="role" name="role" required>
                <option value="Member">Thành viên</option>
                <option value="TeamLeader">Trưởng nhóm</option>
                <option value="ViceChairman">Phó chủ nhiệm</option>
                <option value="Chairman">Chủ nhiệm</option>
                <option value="Admin">Quản trị viên</option>
            </select>
        </div>

        <div class="mb-3">
            <label for="clubId" class="form-label">Câu lạc bộ</label>
            <select class="form-select" id="clubId" name="clubId" required>
                <option value="0">Không thuộc câu lạc bộ</option>
                <% for (Club club : clubs) { %>
                    <option value="<%= club.getClubId() %>"><%= club.getClubName() %></option>
                <% } %>
            </select>
        </div>

        <button type="submit" class="btn btn-primary w-100">Thêm tài khoản</button>
    </form>

    <div class="text-center mt-3">
        <a href="manage-users.jsp" class="btn btn-secondary">Quay lại</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


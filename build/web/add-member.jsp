<%-- 
    Document   : add-member
    Created on : Mar 12, 2025, 7:05:54 PM
    Author     : admin
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.util.List, dao.ClubDAO, model.Club" %>

<%
    // Kiểm tra quyền truy cập (Chỉ Admin, Chủ nhiệm, Phó chủ nhiệm)
    String role = (String) session.getAttribute("role");
    if (role == null || (!"Admin".equals(role) && !"Chairman".equals(role) && !"ViceChairman".equals(role))) {
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
    <title>Thêm Thành Viên</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

<!-- Nội dung trang -->
<div class="container mt-5">
    <h2 class="text-center">Thêm Thành Viên Mới</h2>

    <%-- Hiển thị thông báo lỗi nếu có --%>
    <% String error = (String) request.getAttribute("error"); %>
    <% if (error != null) { %>
        <div class="alert alert-danger"><%= error %></div>
    <% } %>

    <form action="add-member" method="post" class="card p-4 shadow-lg">
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
            <select class="form-control" id="role" name="role" required>
                <option value="Member">Thành viên</option>
                <option value="ViceChairman">Phó chủ nhiệm</option>
                <option value="Chairman">Chủ nhiệm</option>
            </select>
        </div>

        <div class="mb-3">
            <label for="clubId" class="form-label">Câu lạc bộ</label>
            <select class="form-control" id="clubId" name="clubId">
                <% for (Club club : clubs) { %>
                    <option value="<%= club.getClubId() %>"><%= club.getClubName() %></option>
                <% } %>
            </select>
        </div>

        <button type="submit" class="btn btn-primary w-100">Thêm Thành Viên</button>
    </form>

    <div class="text-center mt-3">
        <a href="manage-members.jsp" class="btn btn-secondary">Quay lại</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


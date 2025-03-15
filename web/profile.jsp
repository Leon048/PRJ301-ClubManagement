<%-- 
    Document   : profile
    Created on : Mar 12, 2025, 4:48:05 AM
    Author     : admin
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="dao.UserDAO, model.User" %>

<%
    // Kiểm tra người dùng đã đăng nhập chưa
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Lấy thông tin người dùng từ database
    UserDAO userDAO = new UserDAO();
    User user = userDAO.getUserById(userId);

    // Nếu không tìm thấy user, đăng xuất và yêu cầu đăng nhập lại
    if (user == null) {
        session.invalidate();
        response.sendRedirect("login.jsp?error=Tài khoản không tồn tại!");
        return;
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin cá nhân</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

    <div class="container mt-5">
        <h2 class="text-center">Thông tin cá nhân</h2>

        <div class="card p-4 shadow-lg">
            <div class="mb-3">
                <label class="form-label fw-bold">Họ và tên:</label>
                <p class="form-control-plaintext"><%= user.getFullName() %></p>
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">Email:</label>
                <p class="form-control-plaintext"><%= user.getEmail() %></p>
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">Vai trò:</label>
                <p class="form-control-plaintext"><%= user.getRole() %></p>
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">Câu lạc bộ:</label>
                <p class="form-control-plaintext"><%= (user.getClubName() != null) ? user.getClubName() : "Không có CLB" %></p>
            </div>
        </div>

        <div class="text-center mt-3">
            <a href="update-user.jsp?userId=<%= userId %>" class="btn btn-primary">Chỉnh sửa hồ sơ</a>
            <a href="home.jsp" class="btn btn-secondary">Quay lại</a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


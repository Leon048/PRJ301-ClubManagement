<%-- 
    Document   : manage-users
    Created on : Mar 12, 2025, 2:13:17 AM
    Author     : admin
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.util.List, dao.UserDAO, model.User" %>

<%
    // Kiểm tra quyền Admin
    String role = (String) session.getAttribute("role");
    if (role == null || !"Admin".equals(role)) {
        response.sendRedirect("unauthorized.jsp");
        return;
    }

    // Lấy danh sách người dùng từ UserDAO
    UserDAO userDAO = new UserDAO();
    List<User> users = userDAO.getAllUsersWithClubName(); // Phương thức mới trong UserDAO
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý người dùng</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
    <%@ include file="header.jsp" %>

    <div class="container mt-4">
        <h2 class="text-center">Quản lý tài khoản người dùng</h2>

        <!-- Nút thêm người dùng -->
        <div class="d-flex justify-content-end mb-3">
            <a href="add-user.jsp" class="btn btn-success">Thêm tài khoản</a>
        </div>

        <!-- Hiển thị danh sách người dùng -->
        <div class="table-responsive">
            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Họ tên</th>
                        <th>Email</th>
                        <th>Vai trò</th>
                        <th>Câu lạc bộ</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (User user : users) { %>
                    <tr>
                        <td><%= user.getUserId() %></td>
                        <td><%= user.getFullName() %></td>
                        <td><%= user.getEmail() %></td>
                        <td><%= user.getRole() %></td>
                        <td><%= (user.getClubName() != null) ? user.getClubName() : "Không có CLB" %></td>
                        <td>
                            <a href="update-user.jsp?userId=<%= user.getUserId() %>" class="btn btn-warning btn-sm">Sửa</a>
                            <a href="delete-user?userId=<%= user.getUserId() %>" class="btn btn-danger btn-sm" 
                               onclick="return confirm('Bạn có chắc muốn xóa?');">Xóa</a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <%@ include file="footer.jsp" %>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>



<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.util.List, dao.UserDAO, model.User" %>

<%
    // Kiểm tra quyền truy cập (Chỉ Chairman)
    String role = (String) session.getAttribute("role");
    Integer clubId = (Integer) session.getAttribute("clubId");



    // Lấy danh sách thành viên của câu lạc bộ mà Chairman đang quản lý
    UserDAO userDAO = new UserDAO();
    List<User> members = userDAO.getMembersByClubId(clubId);
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý thành viên</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    </head>
    <body class="bg-light">
        <%@ include file="header.jsp" %>

        <div class="container mt-5">
            <h2 class="text-center">Thành viên trong câu lạc bộ</h2>

            <!-- Nút thêm thành viên -->
            <% if ("Chairman".equals(role)||"ViceChairman".equals(role)) { %>
            <div class="d-flex justify-content-end mb-3">
                <a href="add-member.jsp" class="btn btn-success">Thêm Thành Viên</a>
            </div>
            <% } %>

            <!-- Hiển thị danh sách thành viên -->
            <div class="table-responsive">
                <table class="table table-bordered table-striped">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Họ và tên</th>
                            <th>Email</th>
                            <th>Vai trò</th>
                            <% if ("Chairman".equals(role)||"ViceChairman".equals(role)) { %>
                            <th>Hành động</th>
                            <% } %>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (User member : members) { %>
                        <tr>
                            <td><%= member.getUserId() %></td>
                            <td><%= member.getFullName() %></td>
                            <td><%= member.getEmail() %></td>
                            <td><%= member.getRole() %></td>
                            <% if ("Chairman".equals(role)||"ViceChairman".equals(role)) { %>
                            <td>
                                <a href="update-member.jsp?userId=<%= member.getUserId() %>" class="btn btn-warning btn-sm">Sửa</a>
                                <a href="delete-member?userId=<%= member.getUserId() %>" class="btn btn-danger btn-sm"
                                   onclick="return confirm('Bạn có chắc muốn xóa thành viên này?');">Xóa</a>
                            </td>
                            <% } %>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <div class="text-center mt-4">
                <a href="manage-club.jsp" class="btn btn-secondary">Quay lại</a>
            </div>
        </div>

        <%@ include file="footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

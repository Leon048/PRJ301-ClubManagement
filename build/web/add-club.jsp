<%-- 
    Document   : add-club
    Created on : Mar 12, 2025, 3:00:49 AM
    Author     : admin
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>

<%
    // Kiểm tra quyền Admin
    String role = (String) session.getAttribute("role");
    if (role == null || !"Admin".equals(role)) {
        response.sendRedirect("unauthorized.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thêm câu lạc bộ</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    </head>
    <body class="bg-light">

        <div class="container mt-5">
            <h2 class="text-center">Thêm câu lạc bộ</h2>

            <%-- Hiển thị lỗi nếu có --%>
            <% String error = (String) request.getAttribute("error"); %>
            <% if (error != null) { %>
            <div class="alert alert-danger"><%= error %></div>
            <% } %>

            <%-- Form thêm câu lạc bộ --%>
            <form action="add-club" method="post" class="card p-4 shadow-lg">
                <div class="mb-3">
                    <label for="clubName" class="form-label">Tên câu lạc bộ</label>
                    <input type="text" class="form-control" id="clubName" name="clubName" required>
                </div>

                <div class="mb-3">
                    <label for="description" class="form-label">Mô tả</label>
                    <textarea class="form-control" id="description" name="description" rows="3"></textarea>
                </div>

                <div class="mb-3">
                    <label for="establishedDate" class="form-label">Ngày thành lập</label>
                    <input type="date" class="form-control" id="establishedDate" name="establishedDate" required>
                </div>

                <button type="submit" class="btn btn-primary w-100">Thêm câu lạc bộ</button>
            </form>

            <div class="text-center mt-3">
                <a href="manage-clubs.jsp" class="btn btn-secondary">Quay lại</a>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>


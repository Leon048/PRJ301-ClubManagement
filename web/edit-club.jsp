<%-- 
    Document   : edit-club
    Created on : Mar 12, 2025, 3:16:35 AM
    Author     : admin
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="dao.ClubDAO, model.Club" %>

<%
    // Kiểm tra quyền Admin
    String role = (String) session.getAttribute("role");
    if (role == null ) {
        response.sendRedirect("unauthorized.jsp");
        return;
    }

    // Lấy clubId từ request
    int clubId = Integer.parseInt(request.getParameter("clubId"));

    // Lấy thông tin câu lạc bộ từ ClubDAO
    ClubDAO clubDAO = new ClubDAO();
    Club club = clubDAO.getClubById(clubId);

    if (club == null) {
        response.sendRedirect("manage-clubs.jsp"); // Chuyển hướng nếu câu lạc bộ không tồn tại
        return;
    }
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chỉnh sửa câu lạc bộ</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    </head>
    <body class="bg-light">

        <div class="container mt-5">
            <h2 class="text-center">Chỉnh sửa câu lạc bộ</h2>

            <%-- Hiển thị lỗi nếu có --%>
            <% String error = (String) request.getAttribute("error"); %>
            <% if (error != null) { %>
            <div class="alert alert-danger"><%= error %></div>
            <% } %>

            <%-- Form chỉnh sửa câu lạc bộ --%>
            <form action="edit-club" method="post" class="card p-4 shadow-lg">
                <input type="hidden" name="clubId" value="<%= club.getClubId() %>">

                <div class="mb-3">
                    <label for="clubName" class="form-label">Tên câu lạc bộ</label>
                    <input type="text" class="form-control" id="clubName" name="clubName" value="<%= club.getClubName() %>" required>
                </div>

                <div class="mb-3">
                    <label for="description" class="form-label">Mô tả</label>
                    <textarea class="form-control" id="description" name="description" rows="3"><%= club.getDescription() %></textarea>
                </div>

                <div class="mb-3">
                    <label for="establishedDate" class="form-label">Ngày thành lập</label>
                    <input type="date" class="form-control" id="establishedDate" name="establishedDate" value="<%= club.getEstablishedDate() %>" required>
                </div>

                <button type="submit" class="btn btn-primary w-100">Cập nhật</button>
            </form>

            <div class="text-center mt-3">
                <% if ("Admin".equals(role)) { %>
                <a href="manage-clubs.jsp" class="btn btn-secondary">Quay lại</a>
                <% } %>
                <% if ("Chairman".equals(role)) { %>
                <a href="manage-club.jsp" class="btn btn-secondary">Quay lại</a>
                <% } %>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>


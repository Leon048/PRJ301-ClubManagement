<%-- 
    Document   : manage-club
    Created on : Mar 14, 2025, 2:43:07 PM
    Author     : admin
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="dao.ClubDAO, dao.UserDAO, model.Club, model.User" %>

<%
    // Kiểm tra quyền truy cập (Chỉ Chairman)
    String role = (String) session.getAttribute("role");
    Integer clubId = (Integer) session.getAttribute("clubId");

    if (role == null || (!"Chairman".equals(role)&& !"Member".equals(role)) || clubId == null || clubId <= 0) {
        response.sendRedirect("unauthorized.jsp");
        return;
    }

    // Lấy thông tin câu lạc bộ mà Chairman đang quản lý
    ClubDAO clubDAO = new ClubDAO();
    Club club = clubDAO.getClubById(clubId);

    // Nếu không tìm thấy câu lạc bộ, chuyển hướng về home
    if (club == null) {
        response.sendRedirect("home.jsp?error=Không tìm thấy câu lạc bộ của bạn.");
        return;
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý câu lạc bộ</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
    <%@ include file="header.jsp" %>

    <div class="container mt-4">
        <h2 class="text-center">Quản lý câu lạc bộ của bạn</h2>

        <!-- Hiển thị thông tin câu lạc bộ -->
        <div class="card shadow-lg p-4 mt-3">
            <h4 class="mb-3"><%= club.getClubName() %></h4>
            <p><strong>Mô tả:</strong> <%= club.getDescription() %></p>
            <p><strong>Ngày thành lập:</strong> <%= club.getEstablishedDate() %></p>
        </div>

        <!-- Nút chỉnh sửa thông tin câu lạc bộ -->
        <% if ("Chairman".equals(role)||"ViceChairman".equals(role)) { %>
        <div class="d-flex justify-content-end mt-3">
            <a href="edit-club.jsp?clubId=<%= club.getClubId() %>" class="btn btn-warning">Chỉnh sửa thông tin</a>
        </div>

        <!-- Khu vực quản lý thành viên -->
        <h3 class="mt-5 text-center">Quản lý thành viên</h3>
        <div class="text-center">
            <a href="manage-members.jsp?clubId=<%= club.getClubId() %>" class="btn btn-primary">Xem danh sách thành viên</a>
        </div>
        <% } %>
    </div>

    <%@ include file="footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


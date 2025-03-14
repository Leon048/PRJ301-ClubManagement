<%-- 
    Document   : manage-clubs
    Created on : Mar 12, 2025, 2:57:59 AM
    Author     : admin
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.util.List, dao.ClubDAO, model.Club" %>

<%
    // Kiểm tra quyền Admin
    String role = (String) session.getAttribute("role");
    if (role == null || (!"Admin".equals(role) && !"Chairman".equals(role) && !"ViceChairman".equals(role))) {
        response.sendRedirect("unauthorized.jsp");
        return;
    }

    // Lấy danh sách câu lạc bộ từ ClubDAO
    ClubDAO clubDAO = new ClubDAO();
    List<Club> clubs = clubDAO.getAllClubs();
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
        <h2 class="text-center">Quản lý câu lạc bộ</h2>

        <!-- Nút thêm câu lạc bộ -->
        <div class="d-flex justify-content-end mb-3">
            <a href="add-club.jsp" class="btn btn-success">Thêm câu lạc bộ</a>
        </div>

        <!-- Hiển thị danh sách câu lạc bộ -->
        <div class="table-responsive">
            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Tên câu lạc bộ</th>
                        <th>Mô tả</th>
                        <th>Ngày thành lập</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Club club : clubs) { %>
                    <tr>
                        <td><%= club.getClubId() %></td>
                        <td><%= club.getClubName() %></td>
                        <td><%= club.getDescription() %></td>
                        <td><%= club.getEstablishedDate() %></td>
                        <td>
                            <a href="edit-club.jsp?clubId=<%= club.getClubId() %>" class="btn btn-warning btn-sm">Sửa</a>
                            <a href="delete-club?clubId=<%= club.getClubId() %>" class="btn btn-danger btn-sm"
                               onclick="return confirm('Bạn có chắc muốn xóa câu lạc bộ này?');">Xóa</a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <%@ include file="footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>



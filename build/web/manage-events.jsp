<%-- 
    Document   : manage-event
    Created on : Mar 12, 2025, 8:41:08 PM
    Author     : admin
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.util.List, dao.EventDAO, model.Event" %>

<%
    // Kiểm tra quyền truy cập (Chỉ Admin, Chủ nhiệm, Phó chủ nhiệm)
    String role = (String) session.getAttribute("role");
    if (role == null || (!"Admin".equals(role) && !"Chairman".equals(role) && !"ViceChairman".equals(role))) {
        response.sendRedirect("unauthorized.jsp");
        return;
    }

    // Lấy danh sách sự kiện từ EventDAO
    EventDAO eventDAO = new EventDAO();
    List<Event> events = eventDAO.getAllEvents();
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý sự kiện</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
    <%@ include file="header.jsp" %>

    <div class="container mt-5">
        <h2 class="text-center">Quản lý sự kiện</h2>

        <!-- Nút thêm sự kiện -->
        <div class="d-flex justify-content-end mb-3">
            <a href="add-event.jsp" class="btn btn-success">Thêm Sự Kiện</a>
        </div>

        <!-- Hiển thị danh sách sự kiện -->
        <div class="table-responsive">
            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Tên sự kiện</th>
                        <th>Ngày tổ chức</th>
                        <th>Địa điểm</th>
                        <th>Câu lạc bộ</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Event event : events) { %>
                    <tr>
                        <td><%= event.getEventId() %></td>
                        <td><%= event.getEventName() %></td>
                        <td><%= event.getEventDate() %></td>
                        <td><%= event.getLocation() %></td>
                        <td><%= (event.getClubName() != null) ? event.getClubName() : "Không xác định" %></td>
                        <td>
                            <a href="edit-event.jsp?eventId=<%= event.getEventId() %>" class="btn btn-warning btn-sm">Sửa</a>
                            <a href="delete-event?eventId=<%= event.getEventId() %>" class="btn btn-danger btn-sm"
                               onclick="return confirm('Bạn có chắc muốn xóa sự kiện này?');">Xóa</a>
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



<%-- 
    Document   : event-list
    Created on : Mar 12, 2025, 4:56:19 AM
    Author     : admin
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.util.List, dao.EventDAO, model.Event, dao.EventRegistrationDAO" %>

<%
    // Kiểm tra người dùng đã đăng nhập chưa
    Integer userId = (Integer) session.getAttribute("userId");
    String role = (String) session.getAttribute("role");

    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Lấy danh sách sự kiện từ EventDAO
    EventDAO eventDAO = new EventDAO();
    List<Event> events = eventDAO.getAllEvents();
    
    // Khởi tạo DAO để kiểm tra đăng ký sự kiện
    EventRegistrationDAO eventRegDAO = new EventRegistrationDAO();
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh sách sự kiện</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    </head>
    <body class="bg-light">
        <%@ include file="header.jsp" %>

        <div class="container mt-4">
            <h2 class="text-center">Danh sách sự kiện</h2>

            <%-- Nếu người dùng có quyền, hiển thị nút Thêm Sự Kiện --%>
            <% if ("Admin".equals(role) || "Chairman".equals(role) || "ViceChairman".equals(role)) { %>
            <div class="d-flex justify-content-end mb-3">
                <a href="add-event.jsp" class="btn btn-success">Thêm Sự Kiện</a>
            </div>
            <% } %>

            <!-- Hiển thị danh sách sự kiện -->
            <div class="table-responsive">
                <table class="table table-bordered table-striped">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Tên sự kiện</th>
                            <th>Mô tả</th>
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
                            <td><%= event.getDescription() %></td>
                            <td><%= event.getEventDate() %></td>
                            <td><%= event.getLocation() %></td>
                            <td><%= (event.getClubName() != null) ? event.getClubName() : "Không xác định" %></td>

                            <td>
                                <% if ("Admin".equals(role) || "Chairman".equals(role) || "ViceChairman".equals(role)) { %>
                                <a href="event-details.jsp?eventId=<%= event.getEventId() %>" class="btn btn-info btn-sm">Chi tiết</a>
                                <% } %>
                                <% if ("Member".equals(role)|| "Chairman".equals(role) || "ViceChairman".equals(role)) { %>
                                <% boolean isRegistered = eventRegDAO.isUserRegistered(userId, event.getEventId()); %>
                                <% if (isRegistered) { %>
                                <a href="unregister-event?eventId=<%= event.getEventId() %>" class="btn btn-danger btn-sm"
                                   onclick="return confirm('Bạn có chắc muốn hủy đăng ký?');">Hủy đăng ký</a>
                                <% } else { %>
                                <a href="register-event?eventId=<%= event.getEventId() %>" class="btn btn-success btn-sm">Đăng ký</a>
                                <% } %>
                                <% } %>
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


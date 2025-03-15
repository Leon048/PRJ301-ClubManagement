<%-- 
    Document   : event-list
    Created on : Mar 12, 2025, 4:56:19 AM
    Author     : admin
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.util.List, dao.EventDAO, model.Event, dao.EventRegistrationDAO" %>

<%
    // Kiểm tra quyền truy cập (Chỉ Chairman và Member)
    Integer userId = (Integer) session.getAttribute("userId");
    String role = (String) session.getAttribute("role");
    Integer clubId = (Integer) session.getAttribute("clubId"); // Lấy clubId của Chairman hoặc Member

    if (userId == null || clubId == null || clubId <= 0 || (!"Chairman".equals(role) && !"Member".equals(role))) {
        response.sendRedirect("unauthorized.jsp");
        return;
    }

    // Lấy danh sách sự kiện thuộc câu lạc bộ của Chairman hoặc Member
    EventDAO eventDAO = new EventDAO();
    List<Event> events = eventDAO.getEventsByClubId(clubId);

//    // Khởi tạo DAO để kiểm tra đăng ký sự kiện
//    EventRegistrationDAO eventRegDAO = new EventRegistrationDAO();
    
    // Lấy danh sách sự kiện mà người dùng đã tham gia
    EventRegistrationDAO eventRegDAO = new EventRegistrationDAO();
    List<Event> registeredEvents = eventRegDAO.getEventsByUser(userId);
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
            <h2 class="text-center">Danh sách sự kiện của câu lạc bộ</h2>

            <%-- Nếu là Chairman, hiển thị nút "Thêm Sự Kiện" --%>
            <% if ("Chairman".equals(role)) { %>
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
                            <td>
                                <% if ("Chairman".equals(role)) { %>
                                <a href="update-event.jsp?eventId=<%= event.getEventId() %>" class="btn btn-warning btn-sm">Sửa</a>
                                <a href="delete-event?eventId=<%= event.getEventId() %>" class="btn btn-danger btn-sm"
                                   onclick="return confirm('Bạn có chắc muốn xóa sự kiện này?');">Xóa</a>
                                <% } %>
                                <a href="event-details.jsp?eventId=<%= event.getEventId() %>" class="btn btn-info btn-sm">Chi tiết</a>
                                <% boolean isRegistered = eventRegDAO.isUserRegistered(userId, event.getEventId()); %>
                                <% if (isRegistered) { %>
                                <a href="unregister-event?eventId=<%= event.getEventId() %>" class="btn btn-danger btn-sm"
                                   onclick="return confirm('Bạn có chắc muốn hủy đăng ký?');">Hủy đăng ký</a>
                                <% } else { %>
                                <a href="register-event?eventId=<%= event.getEventId() %>" class="btn btn-success btn-sm">Đăng ký</a>
                                <% } %>

                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <!-- Lịch sử sự kiện của người dùng -->
            <div class="card p-4 shadow-lg">
                <h4 class="mb-3">Sự kiện bạn đã tham gia</h4>
                <% if (registeredEvents.isEmpty()) { %>
                <p class="text-muted">Bạn chưa tham gia sự kiện nào.</p>
                <% } else { %>
                <ul class="list-group">
                    <% for (Event event : registeredEvents) { %>
                    <li class="list-group-item">
                        <strong><%= event.getEventName() %></strong> - <%= event.getEventDate() %> tại <%= event.getLocation() %>
                        <a href="event-details.jsp?eventId=<%= event.getEventId() %>" class="btn btn-info btn-sm float-end">Xem chi tiết</a>
                    </li>
                    <% } %>
                </ul>
                <% } %>
            </div>
        </div>

        <%@ include file="footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>


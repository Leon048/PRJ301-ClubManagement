<%-- 
    Document   : event-details
    Created on : Mar 12, 2025, 5:30:37 AM
    Author     : admin
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="dao.EventDAO, dao.EventRegistrationDAO, model.Event, java.util.List" %>

<%
    // Kiểm tra người dùng đã đăng nhập chưa
    Integer userId = (Integer) session.getAttribute("userId");
    String role = (String) session.getAttribute("role");

    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Lấy eventId từ request
    int eventId = Integer.parseInt(request.getParameter("eventId"));

    // Lấy thông tin sự kiện từ EventDAO
    EventDAO eventDAO = new EventDAO();
    Event event = eventDAO.getEventById(eventId);

    // Nếu sự kiện không tồn tại, chuyển hướng về danh sách sự kiện
    if (event == null) {
        response.sendRedirect("event-list.jsp");
        return;
    }

    // Lấy danh sách người tham gia sự kiện từ EventRegistrationDAO
    EventRegistrationDAO eventRegDAO = new EventRegistrationDAO();
    List<String> participants = eventRegDAO.getParticipants(eventId);
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi tiết sự kiện</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    </head>
    <body class="bg-light">


        <!-- Nội dung trang -->
        <div class="container mt-5">
            <h2 class="text-center">Chi tiết sự kiện</h2>

            <div class="card p-4 shadow-lg">
                <h4 class="mb-3">Thông tin sự kiện</h4>
                <p><strong>Tên sự kiện:</strong> <%= event.getEventName() %></p>
                <p><strong>Mô tả:</strong> <%= event.getDescription() %></p>
                <p><strong>Ngày tổ chức:</strong> <%= event.getEventDate() %></p>
                <p><strong>Địa điểm:</strong> <%= event.getLocation() %></p>
                <p><strong>Câu lạc bộ tổ chức:</strong> <%= event.getClubName() %></p>
            </div>

            <div class="card p-4 shadow-lg mt-4">
                <h4 class="mb-3">Danh sách người tham gia</h4>
                <ul>
                    <% for (String participant : participants) { %>
                    <li><%= participant %></li>
                        <% } %>
                </ul>
            </div>
            <% if ("Member".equals(role)||"Chairman".equals(role)) { %>
            <div class="text-center mt-4">
                <a href="event-list.jsp" class="btn btn-secondary">Quay lại</a>
            </div>
            <% } %>
             <% if ("Admin".equals(role)) { %>
            <div class="text-center mt-4">
                <a href="event-lists.jsp" class="btn btn-secondary">Quay lại</a>
            </div>
            <% } %>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>


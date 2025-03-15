<%-- 
    Document   : update-event
    Created on : Mar 12, 2025, 6:02:12 AM
    Author     : admin
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="dao.EventDAO, dao.ClubDAO, model.Event, model.Club, java.util.List" %>

<%
    // Kiểm tra quyền truy cập (Chỉ Admin, Chủ nhiệm, Phó chủ nhiệm)
    String role = (String) session.getAttribute("role");
    if (role == null || (!"Admin".equals(role) && !"Chairman".equals(role) && !"ViceChairman".equals(role))) {
        response.sendRedirect("unauthorized.jsp");
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

    // Lấy danh sách câu lạc bộ
    ClubDAO clubDAO = new ClubDAO();
    List<Club> clubs = clubDAO.getAllClubs();
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chỉnh sửa sự kiện</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    </head>
    <body class="bg-light">

        <!-- Nội dung trang -->
        <div class="container mt-5">
            <h2 class="text-center">Chỉnh sửa sự kiện</h2>

            <%-- Hiển thị thông báo lỗi nếu có --%>
            <% String error = (String) request.getAttribute("error"); %>
            <% if (error != null) { %>
            <div class="alert alert-danger"><%= error %></div>
            <% } %>

            <form action="update-event" method="post" class="card p-4 shadow-lg">
                <input type="hidden" name="eventId" value="<%= event.getEventId() %>">

                <div class="mb-3">
                    <label for="eventName" class="form-label">Tên sự kiện</label>
                    <input type="text" class="form-control" id="eventName" name="eventName" value="<%= event.getEventName() %>" required>
                </div>

                <div class="mb-3">
                    <label for="description" class="form-label">Mô tả</label>
                    <textarea class="form-control" id="description" name="description" required><%= event.getDescription() %></textarea>
                </div>

                <div class="mb-3">
                    <label for="eventDate" class="form-label">Ngày tổ chức</label>
                    <input type="date" class="form-control" id="eventDate" name="eventDate" value="<%= event.getEventDate() %>" required>
                </div>

                <div class="mb-3">
                    <label for="location" class="form-label">Địa điểm</label>
                    <input type="text" class="form-control" id="location" name="location" value="<%= event.getLocation() %>" required>
                </div>

                <div class="mb-3">
                    <label for="clubId" class="form-label">Câu lạc bộ tổ chức</label>
                    <select class="form-control" id="clubId" name="clubId" required>
                        <% for (Club club : clubs) { %>
                        <option value="<%= club.getClubId() %>" <%= (club.getClubId() == event.getClubId()) ? "selected" : "" %>>
                            <%= club.getClubName() %>
                        </option>
                        <% } %>
                    </select>
                </div>

                <button type="submit" class="btn btn-primary w-100">Cập nhật</button>
            </form>

            <div class="text-center mt-3">
                <% if ("Admin".equals(role)) { %>
                <a href="manage-events.jsp" class="btn btn-secondary">Quay lại</a>
                <% } %>
                <% if ("Chairman".equals(role)) { %>
                <a href="event-list.jsp" class="btn btn-secondary">Quay lại</a>
                <% } %>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>


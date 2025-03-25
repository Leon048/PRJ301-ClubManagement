<%-- 
    Document   : add-event
    Created on : Mar 13, 2025, 10:02:50 PM
    Author     : admin
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="dao.ClubDAO, model.Club, java.util.List" %>

<%
    // Kiểm tra quyền truy cập (Chỉ Admin hoặc Chủ nhiệm mới được thêm sự kiện)
    String role = (String) session.getAttribute("role");
    if (role == null || !(role.equals("Admin") || role.equals("Chairman") || role.equals("ViceChairman"))) {
        response.sendRedirect("unauthorized.jsp");
        return;
    }

    // Lấy danh sách câu lạc bộ từ database
    ClubDAO clubDAO = new ClubDAO();
    List<Club> clubs = clubDAO.getAllClubs();
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Sự Kiện</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
  

    <div class="container mt-5">
        <h2 class="text-center">Thêm Sự Kiện Mới</h2>

        <%-- Hiển thị thông báo lỗi nếu có --%>
        <% String error = request.getParameter("error"); %>
        <% if (error != null) { %>
            <div class="alert alert-danger"><%= error %></div>
        <% } %>

        <form action="add-events" method="post" class="card p-4 shadow-lg">
            <div class="mb-3">
                <label for="eventName" class="form-label">Tên sự kiện</label>
                <input type="text" class="form-control" id="eventName" name="eventName" required>
            </div>

            <div class="mb-3">
                <label for="description" class="form-label">Mô tả</label>
                <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
            </div>

            <div class="mb-3">
                <label for="eventDate" class="form-label">Ngày tổ chức</label>
                <input type="date" class="form-control" id="eventDate" name="eventDate" required>
            </div>

            <div class="mb-3">
                <label for="location" class="form-label">Địa điểm</label>
                <input type="text" class="form-control" id="location" name="location" required>
            </div>

            <div class="mb-3">
                <label for="clubId" class="form-label">Câu lạc bộ tổ chức</label>
                <select class="form-control" id="clubId" name="clubId" required>
                    <option value="">Chọn CLB</option>
                    <% for (Club club : clubs) { %>
                        <option value="<%= club.getClubId() %>"><%= club.getClubName() %></option>
                    <% } %>
                </select>
            </div>

            <button type="submit" class="btn btn-primary w-100">Thêm sự kiện</button>
        </form>

        <div class="text-center mt-3">
            <a href="manage-events.jsp" class="btn btn-secondary">Quay lại</a>
        </div>
    </div>
                
</body>
</html>


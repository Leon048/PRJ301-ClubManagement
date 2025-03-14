<%-- 
    Document   : profile
    Created on : Mar 12, 2025, 4:48:05 AM
    Author     : admin
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="dao.UserDAO, dao.ClubDAO, model.User, model.Club" %>

<%
    // Kiểm tra session có email không
    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Lấy thông tin người dùng từ UserDAO
    UserDAO userDAO = new UserDAO();
    User user = userDAO.getUserByEmail(email);

    // Nếu user không tồn tại, hiển thị lỗi thay vì mất session
    if (user == null) {
        request.setAttribute("error", "Không tìm thấy tài khoản! Vui lòng thử lại.");
        request.getRequestDispatcher("login.jsp").forward(request, response);
        return;
    }

    // Lấy thông tin câu lạc bộ của người dùng (nếu có)
//    ClubDAO clubDAO = new ClubDAO();
//    Club club = (user.getClubId() > 0) ? clubDAO.getClubById(user.getClubId()) : null;
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin tài khoản</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="container mt-5">
        <h2 class="text-center">Thông tin tài khoản</h2>

        <%-- Hiển thị thông báo lỗi nếu có --%>
        <% String error = request.getParameter("error"); %>
        <% if (error != null) { %>
            <div class="alert alert-danger"><%= error %></div>
        <% } %>

        <div class="card shadow-lg p-4">
            <table class="table table-bordered">
                <tr>
                    <th style="width: 30%;">ID:</th>
                    <td><%= user.getUserId() %></td>
                </tr>
                <tr>
                    <th>Họ và tên:</th>
                    <td><%= user.getFullName() %></td>
                </tr>
                <tr>
                    <th>Email:</th>
                    <td><%= user.getEmail() %></td>
                </tr>
                <tr>
                    <th>Vai trò:</th>
                    <td><%= user.getRole() %></td>
                </tr>
                <tr>
                    <th>Câu lạc bộ:</th>
                    <td><%= (user != null) ? user.getClubId() : "Không tham gia CLB" %></td>
                </tr>
            </table>
        </div>

        <div class="text-center mt-3">
            <a href="home.jsp" class="btn btn-secondary">Quay lại</a>
        </div>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>


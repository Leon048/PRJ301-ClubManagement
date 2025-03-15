<%-- 
    Document   : edit-user
    Created on : Mar 12, 2025, 2:28:37 AM
    Author     : admin
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="dao.UserDAO, dao.ClubDAO, model.User, model.Club, java.util.List" %>

<%
    // Kiểm tra quyền truy cập (Chỉ Admin có quyền chỉnh sửa)
    String role = (String) session.getAttribute("role");
//    if (role == null || !"Admin".equals(role)) {
//        response.sendRedirect("unauthorized.jsp");
//        return;
//    }

    // Lấy userId từ request
    int userId = Integer.parseInt(request.getParameter("userId"));

    // Lấy thông tin người dùng từ UserDAO
    UserDAO userDAO = new UserDAO();
    User user = userDAO.getUserById(userId);

    // Nếu người dùng không tồn tại, chuyển hướng về danh sách người dùng
    if (user == null) {
        response.sendRedirect("manage-users.jsp?error=Không tìm thấy người dùng!");
        return;
    }

    // Lấy danh sách câu lạc bộ
    ClubDAO clubDAO = new ClubDAO();
    List<Club> clubs = clubDAO.getAllClubs();

    // Lấy thông báo cập nhật thành công nếu có
    String successMessage = request.getParameter("success");
    String errorMessage = request.getParameter("error");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa người dùng</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

    <div class="container mt-5">
        <h2 class="text-center">Chỉnh sửa Người Dùng</h2>

        <%-- Hiển thị thông báo thành công --%>
        <% if (successMessage != null) { %>
            <div class="alert alert-success text-center">
                <strong><%= successMessage %></strong>
            </div>
        <% } %>

        <%-- Hiển thị thông báo lỗi nếu có --%>
        <% if (errorMessage != null) { %>
            <div class="alert alert-danger"><%= errorMessage %></div>
        <% } %>

        <form action="update-user" method="post" class="card p-4 shadow-lg">
            <input type="hidden" name="userId" value="<%= user.getUserId() %>">

            <div class="mb-3">
                <label for="fullName" class="form-label">Họ và tên</label>
                <input type="text" class="form-control" id="fullName" name="fullName" value="<%= user.getFullName() %>" required>
            </div>

            <div class="mb-3">
                <label for="email" class="form-label">Email (Không thể thay đổi)</label>
                <input type="email" class="form-control" id="email" name="email" value="<%= user.getEmail() %>" readonly>
            </div>

            <div class="mb-3">
                <label for="password" class="form-label">Mật khẩu mới (Không bắt buộc)</label>
                <input type="password" class="form-control" id="password" name="password">
            </div>

            <div class="mb-3">
                <label for="role" class="form-label">Vai trò</label>
                <select class="form-control" id="role" name="role" required>
                    <option value="Member" <%= "Member".equals(user.getRole()) ? "selected" : "" %>>Thành viên</option>
                    <option value="ViceChairman" <%= "ViceChairman".equals(user.getRole()) ? "selected" : "" %>>Phó chủ nhiệm</option>
                    <option value="Chairman" <%= "Chairman".equals(user.getRole()) ? "selected" : "" %>>Chủ nhiệm</option>
                    <option value="Admin" <%= "Admin".equals(user.getRole()) ? "selected" : "" %>>Admin</option>
                </select>
            </div>

            <div class="mb-3">
                <label for="clubId" class="form-label">Câu lạc bộ</label>
                <select class="form-control" id="clubId" name="clubId">
                    <option value="0">Không có CLB</option>
                    <% for (Club club : clubs) { %>
                        <option value="<%= club.getClubId() %>" <%= (club.getClubId() == user.getClubId()) ? "selected" : "" %>>
                            <%= club.getClubName() %>
                        </option>
                    <% } %>
                </select>
            </div>

            <button type="submit" class="btn btn-primary w-100">Cập nhật</button>
        </form>

        <div class="text-center mt-3">
                <% if ("Admin".equals(role)) { %>
                <a href="manage-users.jsp" class="btn btn-secondary">Quay lại</a>
                <% } %>
                <% if ("Chairman".equals(role)||"Member".equals(role)) { %>
                <a href="profile.jsp" class="btn btn-secondary">Quay lại</a>
                <% } %>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>



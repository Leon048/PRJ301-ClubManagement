<%-- 
    Document   : register
    Created on : Mar 15, 2025, 4:08:32 AM
    Author     : admin
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.UserDAO, dao.ClubDAO, model.User, model.Club, java.util.List" %>

<%
    // Lấy danh sách câu lạc bộ từ database
    ClubDAO clubDAO = new ClubDAO();
    List<Club> clubs = clubDAO.getAllClubs();

    // Xử lý đăng ký tài khoản
    String message = null;
    boolean registrationSuccess = false;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        int clubId = Integer.parseInt(request.getParameter("clubId"));

        if (fullName == null || fullName.trim().isEmpty() || 
            email == null || email.trim().isEmpty() || 
            password == null || password.trim().isEmpty() || 
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            message = "Vui lòng điền đầy đủ thông tin!";
        } else if (!password.equals(confirmPassword)) {
            message = "Mật khẩu xác nhận không khớp!";
        } else {
            UserDAO userDAO = new UserDAO();
            boolean isRegistered = userDAO.registerUser(new User(0, fullName, email, password, "Member", clubId, null));

            if (isRegistered) {
                registrationSuccess = true;
            } else {
                message = "Email đã tồn tại hoặc có lỗi xảy ra!";
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký tài khoản</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

    <div class="container mt-5">
        <h2 class="text-center">Đăng ký tài khoản</h2>

        <% if (registrationSuccess) { %>
            <div class="alert alert-success text-center">
                <strong>Đăng ký thành công!</strong> Bạn có thể <a href="login.jsp" class="alert-link">đăng nhập</a> ngay bây giờ.
            </div>
        <% } else { %>

            <% if (message != null) { %>
                <div class="alert alert-danger"><%= message %></div>
            <% } %>

            <div class="card p-4 shadow-lg">
                <form action="register.jsp" method="post">
                    <div class="mb-3">
                        <label for="fullName" class="form-label">Họ và tên</label>
                        <input type="text" class="form-control" id="fullName" name="fullName" required>
                    </div>

                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label">Mật khẩu</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>

                    <div class="mb-3">
                        <label for="confirmPassword" class="form-label">Xác nhận mật khẩu</label>
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                    </div>

                    <div class="mb-3">
                        <label for="clubId" class="form-label">Chọn câu lạc bộ</label>
                        <select class="form-select" id="clubId" name="clubId" required>
                            <option value="0">Không có CLB</option>
                            <% for (Club club : clubs) { %>
                                <option value="<%= club.getClubId() %>"><%= club.getClubName() %></option>
                            <% } %>
                        </select>
                    </div>

                    <button type="submit" class="btn btn-primary w-100">Đăng ký</button>
                </form>

                <div class="text-center mt-3">
                    <p>Đã có tài khoản? <a href="login.jsp">Đăng nhập</a></p>
                </div>
            </div>
        <% } %>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>




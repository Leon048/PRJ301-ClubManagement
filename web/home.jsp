<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="dao.UserDAO, java.util.List" %>

<%
    // Kiểm tra người dùng đã đăng nhập chưa
    String fullName = (String) session.getAttribute("fullName");
    String role = (String) session.getAttribute("role");

    if (fullName == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Trang chủ</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    </head>
    <body>
        <%@ include file="header.jsp" %>

        <div class="container mt-5">
            <h2 class="text-center">Chào mừng, <%= fullName %>!</h2>
            <p class="text-center">Chào mừng bạn đến với hệ thống quản lý câu lạc bộ!</p>
            <% if ("Chairman".equals(role)||"Member".equals(role)||"ViceChairman".equals(role)) { %>
            <div class="row mt-4">
                <!-- Hiển thị trang chính cho tất cả user -->
                <div class="col-md-4">
                    <div class="card shadow-lg">
                        <div class="card-body text-center">
                            <h5 class="card-title">Sự kiện</h5>
                            <p class="card-text">Xem danh sách các sự kiện sắp diễn ra.</p>
                            <a href="event-list.jsp" class="btn btn-primary">Xem ngay</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card shadow-lg">
                        <div class="card-body text-center">
                            <h5 class="card-title">Câu lạc bộ</h5>
                            <p class="card-text">Xem chi tiết câu lạc bộ.</p>
                            <a href="manage-club.jsp" class="btn btn-primary">Xem ngay</a>
                        </div>
                    </div>
                </div>
<!--                <div class="col-md-4">
                    <div class="card shadow-lg">
                        <div class="card-body text-center">
                            <h5 class="card-title">Báo cáo</h5>
                            <p class="card-text">Cập nhật thông tin.</p>
                            <a href="reports.jsp" class="btn btn-primary">Cập nhật</a>
                        </div>
                    </div>
                </div>-->
            </div>
            <% } %>

            <%-- Nếu là Admin, hiển thị dashboard quản trị --%>
            <% if ("Admin".equals(role)) { %>
            <h3 class="mt-5 text-center">Khu vực quản trị</h3>
            <div class="row mt-4">
                <div class="col-md-4">
                    <div class="card shadow-lg">
                        <div class="card-body text-center">
                            <h5 class="card-title">Quản lý người dùng</h5>
                            <p class="card-text">Xem và quản lý danh sách thành viên.</p>
                            <a href="manage-users.jsp" class="btn btn-danger">Quản lý</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card shadow-lg">
                        <div class="card-body text-center">
                            <h5 class="card-title">Quản lý sự kiện</h5>
                            <p class="card-text">Quản lý danh sách các sự kiện của câu lạc bộ.</p>
                            <a href="manage-events.jsp" class="btn btn-danger">Quản lý</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card shadow-lg">
                        <div class="card-body text-center">
                            <h5 class="card-title">Quản lý câu lạc bộ</h5>
                            <p class="card-text">Xem và chỉnh sửa thông tin câu lạc bộ.</p>
                            <a href="manage-clubs.jsp" class="btn btn-danger">Quản lý</a>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
        </div>

        <%@ include file="footer.jsp" %>
    </body>
</html>

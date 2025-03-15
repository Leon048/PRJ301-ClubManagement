<%-- 
    Document   : reports
    Created on : Mar 12, 2025, 3:31:15 AM
    Author     : admin
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.util.List, dao.ReportDAO, model.Report" %>

<%
    // Kiểm tra quyền Admin || !"Admin".equals(role)
    String role = (String) session.getAttribute("role");
    if (role == null ) {
        response.sendRedirect("unauthorized.jsp");
        return;
    }

    // Lấy danh sách báo cáo từ ReportDAO
    ReportDAO reportDAO = new ReportDAO();
    List<Report> reports = reportDAO.getAllReports();
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý báo cáo</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    </head>
    <body class="bg-light">

        <!-- Thanh điều hướng -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container-fluid">
                <a class="navbar-brand" href="admin-dashboard.jsp">Admin Dashboard</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item"><a class="nav-link" href="manage-users.jsp">Quản lý tài khoản</a></li>
                        <li class="nav-item"><a class="nav-link" href="manage-clubs.jsp">Quản lý câu lạc bộ</a></li>
                        <li class="nav-item"><a class="nav-link text-danger" href="logout">Đăng xuất</a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- Nội dung trang -->
        <div class="container mt-4">
            <h2 class="text-center">Báo cáo hoạt động câu lạc bộ</h2>

            <!-- Hiển thị danh sách báo cáo -->
            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Câu lạc bộ</th>
                        <th>Học kỳ</th>
                        <th>Thay đổi thành viên</th>
                        <th>Tóm tắt sự kiện</th>
                        <th>Thống kê tham gia</th>
                        <th>Ngày tạo</th>
                        <th>Chi tiết</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Report report : reports) { %>
                    <tr>
                        <td><%= report.getReportId() %></td>
                        <td><%= report.getClubId() %></td>
                        <td><%= report.getSemester() %></td>
                        <td><%= report.getMemberChanges() %></td>
                        <td><%= report.getEventSummary() %></td>
                        <td><%= report.getParticipationStats() %></td>
                        <td><%= report.getCreatedDate() %></td>
                        <td><a href="report-details.jsp?reportId=<%= report.getReportId() %>" class="btn btn-info btn-sm">Xem</a></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

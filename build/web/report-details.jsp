<%-- 
    Document   : report-details
    Created on : Mar 12, 2025, 3:54:55 AM
    Author     : admin
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="dao.ReportDAO, model.Report" %>

<%
    // Kiểm tra quyền Admin
    String role = (String) session.getAttribute("role");
    if (role == null || !"Admin".equals(role)) {
        response.sendRedirect("unauthorized.jsp");
        return;
    }

    // Lấy reportId từ request
    int reportId = Integer.parseInt(request.getParameter("reportId"));

    // Lấy thông tin báo cáo từ ReportDAO
    ReportDAO reportDAO = new ReportDAO();
    Report report = reportDAO.getReportById(reportId);

    if (report == null) {
        response.sendRedirect("reports.jsp"); // Chuyển hướng nếu báo cáo không tồn tại
        return;
    }
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi tiết báo cáo</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    </head>
    <body class="bg-light">

        <div class="container mt-5">
            <h2 class="text-center">Chi tiết báo cáo</h2>

            <div class="card shadow-lg p-4">
                <h4 class="mb-3">Thông tin báo cáo</h4>
                <p><strong>ID Báo cáo:</strong> <%= report.getReportId() %></p>
                <p><strong>ID Câu lạc bộ:</strong> <%= report.getClubId() %></p>
                <p><strong>Học kỳ:</strong> <%= report.getSemester() %></p>
                <p><strong>Thay đổi thành viên:</strong> <%= report.getMemberChanges() %></p>
                <p><strong>Tóm tắt sự kiện:</strong> <%= report.getEventSummary() %></p>
                <p><strong>Thống kê tham gia:</strong> <%= report.getParticipationStats() %></p>
                <p><strong>Ngày tạo:</strong> <%= report.getCreatedDate() %></p>
            </div>

            <div class="text-center mt-4">
                <a href="reports.jsp" class="btn btn-secondary">Quay lại</a>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>


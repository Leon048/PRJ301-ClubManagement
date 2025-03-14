<%-- 
    Document   : unauthorized
    Created on : Mar 12, 2025, 4:02:24 AM
    Author     : admin
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Truy cập bị từ chối</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    </head>
    <body class="bg-light">

        <div class="container d-flex justify-content-center align-items-center" style="height: 100vh;">
            <div class="card p-4 shadow-lg text-center" style="max-width: 400px;">
                <h2 class="text-danger">Truy cập bị từ chối!</h2>
                <p class="mt-3">Bạn không có quyền truy cập vào trang này.</p>
                <p>Vui lòng đăng nhập với tài khoản có quyền hạn hoặc quay lại trang chính.</p>

                <div class="d-grid gap-2">
                    <a href="home.jsp" class="btn btn-primary">Quay lại trang chủ</a>
                    <a href="login.jsp" class="btn btn-secondary">Đăng nhập</a>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>


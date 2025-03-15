<%-- 
    Document   : header
    Created on : Mar 13, 2025, 1:54:08 AM
    Author     : admin
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <!-- Logo / Trang chủ -->
        <a class="navbar-brand" href="home.jsp">Home</a>
        
        <!-- Nút Toggle trên Mobile -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse justify-content-between" id="navbarNav">
            <!-- Khoảng trống giữ bố cục navbar -->
            <div></div>

            <!-- Lời chào, nút Hồ sơ & Đăng xuất -->
            <div class="ms-auto d-flex align-items-center">
                <span class="navbar-text me-3">
                    Xin chào, <%= (session.getAttribute("fullName") != null) ? session.getAttribute("fullName") : "Người dùng" %>!
                </span>
                <a href="profile.jsp" class="btn btn-info btn-sm me-2">Hồ sơ</a>
                <a href="logout" class="btn btn-danger btn-sm">Đăng xuất</a>
            </div>
        </div>
    </div>
</nav>







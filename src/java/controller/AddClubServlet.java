/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ClubDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import model.Club;

/**
 *
 * @author admin
 */
public class AddClubServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddClubServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddClubServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Nhận dữ liệu từ form
            String clubName = request.getParameter("clubName");
            String description = request.getParameter("description");
            String dateStr = request.getParameter("establishedDate");

            // Kiểm tra dữ liệu nhập vào
            if (clubName == null || clubName.trim().isEmpty() || dateStr == null || dateStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Tên câu lạc bộ và ngày thành lập không được để trống!");
            }

            // Chuyển đổi từ String (yyyy-MM-dd) sang java.util.Date
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date utilDate = sdf.parse(dateStr);

            // Chuyển từ java.util.Date sang java.sql.Date
            java.sql.Date establishedDate = new java.sql.Date(utilDate.getTime());

            // Gọi DAO để thêm câu lạc bộ vào database
            ClubDAO clubDAO = new ClubDAO();
            boolean success = clubDAO.addClub(new Club(0, clubName, description, establishedDate));

            if (success) {
                response.sendRedirect("add-success.jsp"); // Chuyển hướng về trang danh sách câu lạc bộ
            } else {
                request.setAttribute("error", "Lỗi khi thêm câu lạc bộ. Vui lòng thử lại.");
                request.getRequestDispatcher("add-club.jsp").forward(request, response);
            }
        } catch (ParseException e) {
            request.setAttribute("error", "Định dạng ngày không hợp lệ! Định dạng yêu cầu: yyyy-MM-dd.");
            request.getRequestDispatcher("add-club.jsp").forward(request, response);
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("add-club.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi. Vui lòng thử lại!");
            request.getRequestDispatcher("add-club.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

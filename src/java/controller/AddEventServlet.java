/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.EventDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import model.Event;

/**
 *
 * @author admin
 */
public class AddEventServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet AddEventServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddEventServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
            String eventName = request.getParameter("eventName");
            String description = request.getParameter("description");
            String dateStr = request.getParameter("eventDate");
            String location = request.getParameter("location");
            String clubIdStr = request.getParameter("clubId");

            // Kiểm tra dữ liệu nhập vào
            if (eventName == null || eventName.trim().isEmpty() ||
                dateStr == null || dateStr.trim().isEmpty() ||
                location == null || location.trim().isEmpty() ||
                clubIdStr == null || clubIdStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Vui lòng nhập đầy đủ thông tin sự kiện!");
            }

            // Chuyển đổi từ String (yyyy-MM-dd) sang java.util.Date
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date utilDate = sdf.parse(dateStr);

            // Chuyển từ java.util.Date sang java.sql.Date
            java.sql.Date eventDate = new java.sql.Date(utilDate.getTime());

            // Chuyển đổi ClubID sang số nguyên
            int clubId = Integer.parseInt(clubIdStr);

            // Gọi DAO để thêm sự kiện vào database
            EventDAO eventDAO = new EventDAO();
            boolean success = eventDAO.addEvent(new Event(0, eventName, description, eventDate, location, clubId));

            if (success) {
                response.sendRedirect("manage-events.jsp"); // Chuyển hướng về trang danh sách sự kiện
            } else {
                request.setAttribute("error", "Lỗi khi thêm sự kiện. Vui lòng thử lại.");
                request.getRequestDispatcher("add-event.jsp").forward(request, response);
            }
        } catch (ParseException e) {
            request.setAttribute("error", "Định dạng ngày không hợp lệ! Vui lòng nhập đúng định dạng yyyy-MM-dd.");
            request.getRequestDispatcher("add-event.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Vui lòng chọn một câu lạc bộ hợp lệ.");
            request.getRequestDispatcher("add-event.jsp").forward(request, response);
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("add-event.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi. Vui lòng thử lại!");
            request.getRequestDispatcher("add-event.jsp").forward(request, response);
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

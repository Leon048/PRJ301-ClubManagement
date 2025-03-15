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
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author admin
 */
public class DeleteEventServlet extends HttpServlet {

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
            out.println("<title>Servlet DeleteEventServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DeleteEventServlet at " + request.getContextPath() + "</h1>");
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
        // Kiểm tra quyền Admin hoặc Chủ nhiệm
        HttpSession session = request.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("role") : null;
        if (role == null || (!"Admin".equals(role) && !"Chairman".equals(role))) {
            response.sendRedirect("unauthorized.jsp");
            return;
        }

        try {
            // Lấy eventId từ request
            int eventId = Integer.parseInt(request.getParameter("eventId"));

            // Gọi DAO để xóa sự kiện
            EventDAO eventDAO = new EventDAO();
            boolean success = eventDAO.deleteEvent(eventId);

            if (success) {
                response.sendRedirect("manage-events.jsp?success=Xóa sự kiện thành công!");
            } else {
                request.setAttribute("error", "Không thể xóa sự kiện. Có thể có người đã đăng ký tham gia.");
                request.getRequestDispatcher("manage-events.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID sự kiện không hợp lệ.");
            request.getRequestDispatcher("manage-events.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi. Vui lòng thử lại!");
            request.getRequestDispatcher("manage-events.jsp").forward(request, response);
        }
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
        processRequest(request, response);
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

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

/**
 *
 * @author admin
 */
public class UpdateUserServlet extends HttpServlet {
   
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
            out.println("<title>Servlet UpdateUserServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateUserServlet at " + request.getContextPath () + "</h1>");
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
            int userId = Integer.parseInt(request.getParameter("userId"));
            String fullName = request.getParameter("fullName");
            String password = request.getParameter("password"); // Mật khẩu mới (có thể null)
            String role = request.getParameter("role");
            int clubId = Integer.parseInt(request.getParameter("clubId"));

            // Kiểm tra dữ liệu nhập vào
            if (fullName == null || fullName.trim().isEmpty()) {
                throw new IllegalArgumentException("Họ và tên không được để trống!");
            }

            // Gọi DAO để cập nhật thông tin người dùng
            UserDAO userDAO = new UserDAO();
            boolean success = userDAO.updateUser(new User(userId, fullName, null, password, role, clubId, null));

            if (success) {
                response.sendRedirect("update-user.jsp?userId=" + userId + "&success=Cập nhật thành công!");
            } else {
                request.setAttribute("error", "Lỗi khi cập nhật người dùng.");
                request.getRequestDispatcher("update-user.jsp?userId=" + userId).forward(request, response);
            }
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("update-user.jsp?userId=" + request.getParameter("userId")).forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi. Vui lòng thử lại!");
            request.getRequestDispatcher("update-user.jsp?userId=" + request.getParameter("userId")).forward(request, response);
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

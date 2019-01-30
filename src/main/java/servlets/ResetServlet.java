/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import dao.UserDao;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Emiliano
 */
@WebServlet(name = "ResetServlet", urlPatterns = {"/ResetServlet"})
public class ResetServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processGETRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
            PrintWriter out = response.getWriter();  
          
            String email=request.getParameter("email");  
            String cod=request.getParameter("cod");  

            if(UserDao.reset(email, cod)){  
                request.setAttribute("email", email);
                request.setAttribute("cod", cod);
                
                RequestDispatcher rd=request.getRequestDispatcher("ResetPassword.jsp");
                rd.forward(request,response);
            }  
            else{ 
                out.println("<html>"
                    + " <head>"
                    + "     <link rel=\"stylesheet\" href=\"https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css\" crossorigin=\"anonymous\">"
                    + "     <link rel=\"stylesheet\" href=\"css/style.css\">"
                    + "  </head>"
                    + " <body>"
                    + "     <nav class=\"navbar navbar-expand-lg navbar-light bg-light fixed-top\">"
                    + "         <div style=\"width: 1150px; margin: 0 auto;\">"
                    + "             <a class=\"navbar-brand\" href=\"index.jsp\">Shopping List</a>"
                    + "         </div>"
                    + "     </nav>"
                    + "     <div class=\"container\" style=\"margin-top: 150px;\">"
                    + "         <center><div>"
                    + "             <h3>Link not valid!</h3>"
                    + "         </div></center>"
                    + "         <center><a href='login_registration.jsp' class=\"btn btn-outline-primary\" style=\"margin-top: 30px;\">Return to Login</a></center>"
                    + "     </div>"
                    + " </body>"
                    + "</html>");
            }  

            out.close();  
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
        processGETRequest(request, response);
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

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import dao.RegistrationDao;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import mail.Mailer;
/**
 *
 * @author Emiliano
 */
@WebServlet(name = "RegistrationServlet", urlPatterns = {"/RegistrationServlet"})
public class RegistrationServlet extends HttpServlet {

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
        
                    PrintWriter out = response.getWriter();  
    
    String name=request.getParameter("name");
    String surname=request.getParameter("surname");
    String email=request.getParameter("email");  
    String password=request.getParameter("passwordRegistration"); 
   
          
    if(RegistrationDao.register(email, password, name, surname)){  
        Mailer.sendMail(email);
        
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
                    + "             <h3>Check your email:    "+email+"</h3>"
                    + "         </div></center>"
                    + "         <center><a href='login_registration.jsp' class=\"btn btn-outline-primary\" style=\"margin-top: 30px;\">Return to Login</a></center>"
                    + "     </div>"
                    + " </body>"
                    + "</html>");
        

    }  
    else{  
        response.sendRedirect("login_registration.jsp?error=regError");  
        //out.print("Error!");
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

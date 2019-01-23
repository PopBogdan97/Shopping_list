/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import dao.LoginDao;
import dao.UserDao;
import entities.UserBean;
import java.io.IOException;
import java.io.PrintWriter;
import static java.util.Objects.hash;
import java.util.UUID;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Emiliano
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processPOSTRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        PrintWriter out = response.getWriter();
        
        String email = request.getParameter("username");
        String password = request.getParameter("passwordLogin");
        String remember = (request.getParameterMap().containsKey("remember")) ? request.getParameter("remember") : "";

        String result = LoginDao.authenticate(email, password);

        System.out.println("Result dao: "+result);
        
        if (result.equals("notexist")) {
            response.sendRedirect("login_registration.jsp?error=Login error!");

        } else if (result.equals("notvalid")) {
            response.sendRedirect("login_registration.jsp?error=Account not verified!&email="+email);

        } else {
            HttpSession session = request.getSession();
            
            UserBean user = UserDao.getSingleUser(email);
            
            session.setAttribute("user", user);
            request.setAttribute("email", email);
            
            //da cancellare quando non serviranno più
            session.setAttribute("email", email);
            session.setAttribute("tipo", result);
            
            
            

            if (remember.equals("on")) {
                
                String uniqueID = UUID.randomUUID().toString();
                System.out.println("UID: "+uniqueID);
                
                //setto il cookie che andrà memorizzato sul browser con un ID alfanumerico univoco
                Cookie rememberCookie = new Cookie("rememberUser", uniqueID);
                rememberCookie.setMaxAge(15*24*60*60);  //15 giorni
                response.addCookie(rememberCookie);
                
                //aggiungo l'ID all'utente corrispondente nel DB
                LoginDao.setLoginCookie(email, uniqueID);
            }
            
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
            response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
            response.setHeader("Expires", "0"); // Proxies
            
            response.sendRedirect("index.jsp");
        }

        /*
        if (result.equals("1")) {

            HttpSession session = request.getSession();

            session.setAttribute("email", email);
            request.setAttribute("email", email);

            if (remember.equals("on")) {
                //recupero Cod dell'utente che si sta loggando

                String uniqueID = UUID.randomUUID().toString();
                System.out.println("prova");
                System.out.println(uniqueID);

                Cookie rememberCookie = new Cookie("rememberUser", uniqueID);
                rememberCookie.setMaxAge(4320000);  //432000 sec = 5 giorni
                response.addCookie(rememberCookie);
                LoginDao.setLoginCookie(email, uniqueID);
            }

            RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
            rd.forward(request, response);
        } else {
            if (result.equals("false")) {
                request.setAttribute("error", "Login error!");

            } else {
                request.setAttribute("email", email);
                request.setAttribute("error", "Account not verified!");
            }
            RequestDispatcher rd = request.getRequestDispatcher("login_registration.jsp");
            rd.forward(request, response);
        }
         */
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
        processPOSTRequest(request, response);
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

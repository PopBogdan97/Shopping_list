/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package filters;

import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Luca
 */
public class LoggedFilter implements Filter {
    
    private static final boolean debug = true;

    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured. 
    private FilterConfig filterConfig = null;
    
    public LoggedFilter() {
    }    
    
    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("LoggedFilter:DoBeforeProcessing");
        }

        // Write code here to process the request and/or response before
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log items on the request object,
        // such as the parameters.
        /*
	for (Enumeration en = request.getParameterNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    String values[] = request.getParameterValues(name);
	    int n = values.length;
	    StringBuffer buf = new StringBuffer();
	    buf.append(name);
	    buf.append("=");
	    for(int i=0; i < n; i++) {
	        buf.append(values[i]);
	        if (i < n-1)
	            buf.append(",");
	    }
	    log(buf.toString());
	}
         */
    }    
    
    private void doAfterProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("LoggedFilter:DoAfterProcessing");
        }

        // Write code here to process the request and/or response after
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log the attributes on the
        // request object after the request has been processed. 
        /*
	for (Enumeration en = request.getAttributeNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    Object value = request.getAttribute(name);
	    log("attribute: " + name + "=" + value.toString());

	}
         */
        // For example, a filter might append something to the response.
        /*
	PrintWriter respOut = new PrintWriter(response.getWriter());
	respOut.println("<P><B>This has been appended by an intrusive filter.</B>");
         */
    }

    /**
     *
     * @param req The servlet request we are processing
     * @param res The servlet response we are creating
     * @param chain The filter chain we are processing
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet error occurs
     */
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        if (debug) {
            log("LoggedFilter:doFilter()");
        }
        
        doBeforeProcessing(req, res);
        
        
        System.out.println("Filtro Login");
        
        
        /************************ Logged Filer ************************/
        
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        
        HttpSession session = request.getSession(false);
        
        System.out.println(request.getServletPath());
        
        boolean isUnlogged = (session == null || session.getAttribute("email") == null);
        boolean isLogged = (session != null && session.getAttribute("email") != null);
        boolean isAdmin = (isLogged && session.getAttribute("tipo").equals("admin"));
        
        
        String URI = request.getRequestURI();
        
        //JSP files URIs
        String resetPassword = request.getContextPath() + "/ResetPassword.jsp";
        String accessDenied = request.getContextPath() + "/accessDenied.jsp";
        String adminPanel = request.getContextPath() + "/adminPanel.jsp";
        String index = request.getContextPath() + "/index.jsp";
        String login = request.getContextPath() + "/login_registration.jsp";
        String profile = request.getContextPath() + "/profile.jsp";
        String setImage = request.getContextPath() + "/setimage.jsp";
        
        //Servlets URIs
        String activateServlet = request.getContextPath() + "/ActivateServlet";
        
        String loginServlet = request.getContextPath() + "/LoginServlet";
        String logoutServlet = request.getContextPath() + "/LogoutServlet";
        //String reSendServlet = request.getContextPath() + "/ReSendServlet";
        String registrationServlet = request.getContextPath() + "/RegistrationServlet";
        String requestResetServlet = request.getContextPath() + "/RequestResetServlet";
        String resetServlet = request.getContextPath() + "/ResetServlet";
        String setPasswordServlet = request.getContextPath() + "/SetPasswordServlet";
        
        
        if(isUnlogged){ //NOT LOGGED
            System.out.println("is UNlogged");
            if(URI.equals(adminPanel) || URI.equals(logoutServlet) || URI.equals(profile) || URI.equals(setImage)){   //not accessible
                response.sendRedirect("accessDenied.jsp");
            }
            else{   //accessible
                chain.doFilter(req, res);
            }
        }
        else if(isLogged){   //LOGGED
            System.out.println("is logged");
            
            if(URI.equals(adminPanel)){   //not accessible
                if(isAdmin){    //accessible
                    chain.doFilter(req, res);
                }
                else{   //not accessible
                    response.sendRedirect("accessDenied.jsp");
                }
            }
            else if(URI.equals(login) || URI.equals(setImage) || URI.equals(activateServlet) || URI.equals(loginServlet) || URI.equals(registrationServlet) || URI.equals(requestResetServlet) || URI.equals(resetServlet) || URI.equals(resetPassword)/* || URI.equals(reSendServlet)*/){  //not accessible
               response.sendRedirect("accessDenied.jsp");
            }
            else{   //accessible
                chain.doFilter(req, res);
            }
            
        }        
        
        /**************************************************************/
        
        
        doAfterProcessing(req, res);
    }

    /**
     * Return the filter configuration object for this filter.
     */
    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }

    /**
     * Set the filter configuration object for this filter.
     *
     * @param filterConfig The filter configuration object
     */
    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    /**
     * Destroy method for this filter
     */
    public void destroy() {        
    }

    /**
     * Init method for this filter
     */
    public void init(FilterConfig filterConfig) {        
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (debug) {                
                log("LoggedFilter:Initializing filter");
            }
        }
    }

    /**
     * Return a String representation of this object.
     */
    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("LoggedFilter()");
        }
        StringBuffer sb = new StringBuffer("LoggedFilter(");
        sb.append(filterConfig);
        sb.append(")");
        return (sb.toString());
    }
    
    private void sendProcessingError(Throwable t, ServletResponse response) {
        String stackTrace = getStackTrace(t);        
        
        if (stackTrace != null && !stackTrace.equals("")) {
            try {
                response.setContentType("text/html");
                PrintStream ps = new PrintStream(response.getOutputStream());
                PrintWriter pw = new PrintWriter(ps);                
                pw.print("<html>\n<head>\n<title>Error</title>\n</head>\n<body>\n"); //NOI18N

                // PENDING! Localize this for next official release
                pw.print("<h1>The resource did not process correctly</h1>\n<pre>\n");                
                pw.print(stackTrace);                
                pw.print("</pre></body>\n</html>"); //NOI18N
                pw.close();
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        } else {
            try {
                PrintStream ps = new PrintStream(response.getOutputStream());
                t.printStackTrace(ps);
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        }
    }
    
    public static String getStackTrace(Throwable t) {
        String stackTrace = null;
        try {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            pw.close();
            sw.close();
            stackTrace = sw.getBuffer().toString();
        } catch (Exception ex) {
        }
        return stackTrace;
    }
    
    public void log(String msg) {
        filterConfig.getServletContext().log(msg);        
    }
    
}

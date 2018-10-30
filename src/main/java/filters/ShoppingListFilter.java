/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package filters;

import dao.ProdcatDao;
import entities.ShoppingList;
import java.io.IOException;
import java.util.List;
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
 * @author Marco
 */
public class ShoppingListFilter implements Filter {

    private static final boolean DEBUG = true;
    private FilterConfig filterConfig = null;
    
    public ShoppingListFilter() {
    }
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (DEBUG) {
                log("ShoppingListsFilter:Initializing filter");
            }
        }
    }
    
    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (DEBUG) {
            log("ShoppingListsFilter:DoBeforeProcessing");
        }

        ProdcatDao shoppingListDao = null;
        
        try {
            request.setAttribute("shoppingListDao", shoppingListDao);
        } catch (Exception ex) {
            throw new RuntimeException(new ServletException("Impossible to get the dao factory for shopping list storage system", ex));
        }
        
        try {
            List<ShoppingList> shoppingLists = shoppingListDao.getProd();
            request.setAttribute("shoppingLists", shoppingLists);
        } catch (Exception ex) {
            throw new RuntimeException(new ServletException("Impossible to get user or shopping lists", ex));
        }
    }
    
    private void doAfterProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (DEBUG) {
            log("ShoppingListsFilter:DoAfterProcessing");
        }
        //Nothing to post-process
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        if (DEBUG) {
            log("ShoppingListsFilter:doFilter()");
        }

        doBeforeProcessing(request, response);

        Throwable problem = null;
        try {
            chain.doFilter(request, response);
        } catch (IOException | ServletException | RuntimeException ex) {
            problem = ex;
            log(ex.getMessage());
            //ex.printStackTrace();
        }

        doAfterProcessing(request, response);

        // If there was a problem, we want to rethrow it if it is
        // a known type, otherwise log it.
        if (problem != null) {
            if (problem instanceof ServletException) {
                throw (ServletException) problem;
            }
            if (problem instanceof IOException) {
                throw (IOException) problem;
            }
            ((HttpServletResponse) response).sendError(500, problem.getMessage());
        }
    }
    
    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }
    
    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    @Override
    public void destroy() {
    }
    
    public void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }

    public void log(String msg, Throwable t) {
        filterConfig.getServletContext().log(msg, t);
    }
}

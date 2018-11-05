/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import dao.ListCatDao;
import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.util.Base64;
import java.util.Properties;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.apache.commons.io.FileUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

@MultipartConfig(fileSizeThreshold=1024*1024*2, // 2MB
                 maxFileSize=1024*1024*10,      // 10MB
                 maxRequestSize=1024*1024*50)   // 50MB
/**
 *
 * @author Emiliano
 */
@WebServlet(name = "ListCatServlet", urlPatterns = {"/ListCatServlet"})
public class ListCatServlet extends HttpServlet {

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
        response.setContentType("application/json");
        String str=!request.getParameterMap().containsKey("q") ? "": request.getParameter("q");
        JSONArray array=ListCatDao.getList(str);
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.print(array);
        }
    }
    
        protected void processNEWRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String nome=request.getParameter("nome");
        String descrizione=request.getParameter("descrizione");
        String[] prodcat=request.getParameterValues("arr");
        
        String fileName="";
        
        if(Boolean.parseBoolean(request.getParameter("ok"))){

            
            Part part=request.getPart("file");
            
            System.out.println((Paths.get(part.getSubmittedFileName()).getFileName().toString()));
            
            fileName=nome+".png";
                   
                   System.out.println(fileName);

            UploadImage.upload(part, fileName, "listcat");
        }


    if(ListCatDao.initialize(nome, descrizione, fileName)){  
        if(ListCatDao.setProdCat(nome, prodcat)){
            System.out.println("ok");
        }
    }  
    
    }
        
                    protected void processDELETERequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String nome = request.getParameter("nome");

        if (ListCatDao.delete(nome)) {
            System.out.println("ok");
        }
    }
                    
                    protected void processGETDATARequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        String nome = request.getParameter("nome");

        JSONObject object=ListCatDao.getData(nome);
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.print(object);
        }
        
    }
                    
                    protected void processGETIMAGERequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("image/png");

                        String nome = request.getParameter("nome");

        String filename=ListCatDao.getImage(nome);
        
        if(!filename.equals("")){
        
                InputStream is = UploadImage.class.getClassLoader().getResourceAsStream("../../WEB-INF/resources/path.properties");
        Properties properties = new Properties();
        properties.load(is);
        
                        System.out.println(properties.getProperty("location")+"/listcat/"+filename);
                        
                              File file = new File(properties.getProperty("location")+"/listcat/", filename);

byte[] fileContent = FileUtils.readFileToByteArray(file);
String encodedString = Base64.getEncoder().encodeToString(fileContent);                              
      
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.print(encodedString);
        }
        }
        else{
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.print("{}");
        }            
        }
    
    }
                    
                            protected void processMODIFYRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String nome=request.getParameter("nome");
        String descrizione=request.getParameter("descrizione");
        
        String fileName="";
        
        if(Boolean.parseBoolean(request.getParameter("ok"))){

            
            Part part=request.getPart("file");
            
            System.out.println((Paths.get(part.getSubmittedFileName()).getFileName().toString()));
            
            fileName=nome+".png";
                   
                   System.out.println(fileName);

            UploadImage.upload(part, fileName, "listcat");
        }
        
    if(ListCatDao.modify(nome, descrizione, fileName, Boolean.parseBoolean(request.getParameter("mod")) || Boolean.parseBoolean(request.getParameter("ok")))){  
        System.out.println("ok");

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
        
        String action=request.getParameter("action");

        if(action.equals("new")){
            processNEWRequest(request, response);
        }
        else if(action.equals("delete")){
            processDELETERequest(request, response);
            
        }
        else if(action.equals("getdata")){
            processGETDATARequest(request, response);
            
        }
        else if(action.equals("getimage")){
            processGETIMAGERequest(request, response);
            
        }
                else if(action.equals("modify")){
            processMODIFYRequest(request, response);
            
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

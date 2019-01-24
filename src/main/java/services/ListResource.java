/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package services;

import com.google.gson.Gson;
import dao.ListDao;
import entities.Element;
import entities.ElementList;
import entities.ListBean;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.Properties;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.Produces;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PUT;
import javax.ws.rs.PathParam;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import org.apache.commons.io.FileUtils;
import org.glassfish.jersey.media.multipart.FormDataParam;

/**
 * REST Web Service
 *
 * @author bogdan
 */
@Path("list")
public class ListResource {

    @Context
    private UriInfo context;

    /**
     * Creates a new instance of ListResource
     */
    public ListResource() {
    }

    /**
     * Retrieves representation of an instance of services.ListResource
     *
     * @return an instance of java.lang.String
     */
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public String getAllListsJson(@QueryParam("q") String q, @QueryParam("limit") int limit) {
        ElementList el = ListDao.getAllList(q == null ? "" : q, limit == 0 ? "" : "LIMIT " + limit);
        System.out.println("q: " + q);
        System.out.println("limit: " + limit);

        return new Gson().toJson(el);
    }
    
    @GET
    @Path("/{name}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getSingleListJson(@PathParam("name") String name) {
        ListBean list = ListDao.getSingleList(name);
        return new Gson().toJson(list);
    }
    
    @GET
    @Path("/{name}/products")
    @Produces(MediaType.APPLICATION_JSON)
    public String getSingleListProductsJson(@PathParam("name") String name) {
        ListBean list = ListDao.getSingleList(name);
        ElementList el = new ElementList();
        ArrayList<Element> listProducts = new ArrayList<>();
        
        int i = 0;
        for(String s : list.getProducts()){
            Element e = new Element();
            e.setId(i +"");
            e.setText(s);
            listProducts.add(e);
            i++;
        }
        el.setResults(listProducts);
        return new Gson().toJson(el);
    }
    
    @GET
    @Path("/image/{name}")
    @Produces("image/png")
    public String getImage(@PathParam("name") String name) throws IOException {

        String filename = ListDao.getImage(name);

        if (!filename.equals("")) {

            InputStream is = UploadImage.class.getClassLoader().getResourceAsStream("../../WEB-INF/resources/path.properties");
            Properties properties = new Properties();
            properties.load(is);

            System.out.println(properties.getProperty("location") + "/list/" + filename);

            File file = new File(properties.getProperty("location") + "/list/", filename);

            byte[] fileContent = FileUtils.readFileToByteArray(file);
            String encodedString = Base64.getEncoder().encodeToString(fileContent);

            return encodedString;

        } else {

            return "{}";

        }
    }


    /**
     * PUT method for updating or creating an instance of ListResource
     *
     * @param content representation for the resource
     */
    @PUT
    @Path("/{name}")
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    public void putListJson(@PathParam("name") String name, @FormDataParam("catName") String catName, @FormDataParam("description") String description, @FormDataParam("file") InputStream file, @FormDataParam("mod") boolean mod) throws IOException {

        String fileName = "";

        if (file != null) {

            fileName = name + ".png";

            System.out.println(fileName);

            UploadImage.upload(file, fileName, "list");
        }

        if (ListDao.modify(name, catName, description, fileName, (mod || file != null))) {
            System.out.println("ok");
        }
    }
    
    @PUT
    @Path("/{name}/products")
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    public void putListProductsJson(@PathParam("name") String name, @FormDataParam("products") List<String> products) throws IOException {
        
        if (ListDao.setProducts(name, products.toArray(new String[products.size()]))){
            System.out.println("ok");
        }
    }

    @POST
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    public void postListJson(@FormDataParam("name") String name, 
            @FormDataParam("catName") String catName, 
            @FormDataParam("description") String description, 
            @FormDataParam("products") List<String> products, 
            @FormDataParam("file") InputStream file, 
            @FormDataParam("ownerEmail") String ownerEmail, 
            @FormDataParam("mod") boolean mod) throws IOException {

        String fileName = "";

        if (file != null) {

            fileName = name + ".png";

            System.out.println(fileName);

            UploadImage.upload(file, fileName, "list");
        }

        if (ListDao.initialize(name, catName, description, fileName, ownerEmail, (mod || file != null))) {
            if (ListDao.setProducts(name, products.toArray(new String[products.size()]))) {
                System.out.println("ok");
            }
        }

    }
    
    @DELETE
    @Path("/{name}")
    public void deleteListJson(@PathParam("name") String name) {
        
        ListDao.delete(name);
        System.out.println(name);
    }

}

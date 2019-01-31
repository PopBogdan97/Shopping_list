/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package services;

import utilities.UploadImage;
import com.google.gson.Gson;
import dao.ProdCatDao;
import entities.ElementList;
import entities.ProductCatBean;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
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
@Path("productCat")
public class ProductCatResource {

    @Context
    private UriInfo context;

    /**
     * Creates a new instance of ProductCatResource
     */
    public ProductCatResource() {
    }

    /**
     * Retrieves representation of an instance of services.ProductCatResource
     * @return an instance of java.lang.String
     */
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public String getAllProductCatJson(@QueryParam("q") String q, @QueryParam("limit") int limit) {
        ElementList el = ProdCatDao.getAllProductCat(q == null ? "" : q, limit == 0 ? "" : "LIMIT " + limit);
        System.out.println("q: " + q);
        System.out.println("limit: " + limit);

        return new Gson().toJson(el);
    }
    
    @GET
    @Path("/{name}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getSingleProductCatJson(@PathParam("name") String name) {
        ProductCatBean productCat = ProdCatDao.getSingleProductCat(name);
        return new Gson().toJson(productCat);
    }
    
    @GET
    @Path("/{name}/products")
    @Produces(MediaType.APPLICATION_JSON)
    public String getProductsJson(@PathParam("name") String name) {
        ProductCatBean productCat = ProdCatDao.getSingleProductCat(name);
        ElementList el = new ElementList();
        el.setResults(productCat.getProducts());
        
        return new Gson().toJson(el);
    }
    
    @GET
    @Path("/logo/{name}")
    @Produces("image/png")
    public String getImage(@PathParam("name") String name) throws IOException {

        String filename = ProdCatDao.getLogo(name);

        if (!filename.equals("")) {

            InputStream is = UploadImage.class.getClassLoader().getResourceAsStream("../../WEB-INF/resources/path.properties");
            Properties properties = new Properties();
            properties.load(is);

            System.out.println(properties.getProperty("logoLocation") + "/productCat/" + filename);

            File file = new File(properties.getProperty("logoLocation") + "/productCat/", filename);

            if (file.exists()) {

                byte[] fileContent = FileUtils.readFileToByteArray(file);
                String encodedString = Base64.getEncoder().encodeToString(fileContent);

                return encodedString;
            } else {
                return "{}";

            }

        } else {

            return "{}";

        }
    }

    /**
     * PUT method for updating or creating an instance of ProductCatResource
     * @param content representation for the resource
     */
    @PUT
    @Path("/{name}")
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    public void putProductCatJson(@PathParam("name") String name, @FormDataParam("description") String description, @FormDataParam("file") InputStream file, @FormDataParam("mod") boolean mod) throws IOException {
        
        String fileName = "";

        if (file != null) {

            fileName = name + ".png";

            System.out.println(fileName);

            UploadImage.uploadLogo(file, fileName, "productCat");
        }

        if (ProdCatDao.modify(name, description, fileName, (mod || file != null))) {
            System.out.println("ok");
        }
    }
    

    @POST
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    public void postProductCatJson(@FormDataParam("name") String name, 
            @FormDataParam("description") String description, 
            @FormDataParam("listcat") List<String> listcat, 
            @FormDataParam("file") InputStream file) throws IOException {

        String fileName = "";

        if (file != null) {

            fileName = name + ".png";

            System.out.println(fileName);

            UploadImage.uploadLogo(file, fileName, "productCat");
        }

        if (ProdCatDao.initialize(name, description, fileName)) {
            if (ProdCatDao.setListCat(name, listcat.toArray(new String[listcat.size()]))) {
                System.out.println("ok");
            }
        }

    }
    
    @DELETE
    @Path("/{name}")
    public void deleteProductCatJson(@PathParam("name") String name) {
        
        ProdCatDao.delete(name);
        System.out.println(name);
    }
}

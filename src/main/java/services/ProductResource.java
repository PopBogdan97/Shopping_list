/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package services;

import utilities.UploadImage;
import com.google.gson.Gson;
import dao.ListDao;
import dao.ProductDao;
import entities.ElementList;
import entities.ProductBean;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Base64;
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
@Path("product")
public class ProductResource {

    @Context
    private UriInfo context;

    /**
     * Creates a new instance of ProductResource
     */
    public ProductResource() {
    }

    /**
     * Retrieves representation of an instance of services.ProductResource
     *
     * @return an instance of java.lang.String
     */
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public String getAllProductsJson(@QueryParam("q") String q, @QueryParam("limit") int limit) {
        ElementList el = ProductDao.getAllProducts(q == null ? "" : q, limit == 0 ? "" : "LIMIT " + limit);
        System.out.println("q: " + q);
        System.out.println("limit: " + limit);

        return new Gson().toJson(el);
    }

    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getSingleProductJson(@PathParam("id") Integer id) {
        ProductBean product = ProductDao.getSingleProduct(id);
        return new Gson().toJson(product);
    }

    @GET
    @Path("/image/{id}")
    @Produces("image/png")
    public String getImage(@PathParam("id") Integer id) throws IOException {

        String filename = ProductDao.getImage(id);

        if (!filename.equals("")) {

            InputStream is = UploadImage.class.getClassLoader().getResourceAsStream("../../WEB-INF/resources/path.properties");
            Properties properties = new Properties();
            properties.load(is);

            System.out.println(properties.getProperty("location") + "/product/" + filename);

            File file = new File(properties.getProperty("location") + "/product/", filename);

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
    
    @GET
    @Path("/logo/{id}")
    @Produces("image/png")
    public String getLogo(@PathParam("id") Integer id) throws IOException {

        String filename = ProductDao.getLogo(id);

        if (!filename.equals("")) {

            InputStream is = UploadImage.class.getClassLoader().getResourceAsStream("../../WEB-INF/resources/path.properties");
            Properties properties = new Properties();
            properties.load(is);

            System.out.println(properties.getProperty("logoLocation") + "/product/" + filename);

            File file = new File(properties.getProperty("logoLocation") + "/product/", filename);

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
     * PUT method for updating or creating an instance of ProductResource
     *
     * @param content representation for the resource
     */
    @PUT
    @Path("/{id}")
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    public void putProductJson(@PathParam("id") Integer id,
            @FormDataParam("description") String description,
            @FormDataParam("fileImage") InputStream fileImage,
            @FormDataParam("fileLogo") InputStream fileLogo,
            @FormDataParam("modi") boolean modi,
            @FormDataParam("modl") boolean modl) throws IOException {

        String fileNameImage = "";
        String fileNameLogo = "";

        if (fileImage != null) {

            fileNameImage = id + ".png";

            System.out.println(fileNameImage);

            UploadImage.upload(fileImage, fileNameImage, "product");
        }

        if (fileLogo != null) {

            fileNameLogo = id + ".png";

            System.out.println(fileNameLogo);

            UploadImage.uploadLogo(fileLogo, fileNameLogo, "product");
        }
        
        if (ProductDao.modify(id, description, fileNameLogo, fileNameImage, (modl || fileLogo != null), (modi || fileImage != null))) {
                System.out.println("ok");
        }

    }
    
    @POST
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    public void postProductJson(@FormDataParam("name") String name, 
            @FormDataParam("catName") String catName, 
            @FormDataParam("description") String description, 
            @FormDataParam("fileImage") InputStream fileImage, 
            @FormDataParam("fileLogo") InputStream fileLogo) throws IOException {

        String fileNameImage = "";
        String fileNameLogo= "";
        
        Integer id = ProductDao.initialize(name, catName, description, fileNameImage, fileNameLogo);
        if (fileImage != null && (id>0)) {

            fileNameImage = id + ".png";

            System.out.println(fileNameImage);

            UploadImage.upload(fileImage, fileNameImage, "product");
        }

        if (fileLogo != null && (id>0)) {

            fileNameLogo = id + ".png";

            System.out.println(fileNameLogo);

            UploadImage.uploadLogo(fileLogo, fileNameLogo, "product");
        }
        
        if (id > 0) {
            ProductDao.modify(id, description, fileNameLogo, fileNameImage, true, true);
            System.out.println("ok");
        }
    }
    
    @POST
    @Path("/list/{listId}")
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    public void postUserProductJson(@PathParam("listId") Integer listId,
            @FormDataParam("name") String name, 
            @FormDataParam("catName") String catName, 
            @FormDataParam("description") String description, 
            @FormDataParam("fileImage") InputStream fileImage, 
            @FormDataParam("fileLogo") InputStream fileLogo) throws IOException {

        String fileNameImage = "";
        String fileNameLogo= "";
        
        Integer id = ProductDao.initialize(name, catName, description, fileNameImage, fileNameLogo);
        if (fileImage != null && (id>0)) {

            fileNameImage = id + ".png";

            System.out.println(fileNameImage);

            UploadImage.upload(fileImage, fileNameImage, "product");
        }

        if (fileLogo != null && (id>0)) {

            fileNameLogo = id + ".png";

            System.out.println(fileNameLogo);

            UploadImage.uploadLogo(fileLogo, fileNameLogo, "product");
        }
        
        if (id > 0) {
            ProductDao.modify(id, description, fileNameLogo, fileNameImage, true, true);
            ListDao.setProducts(listId, id, 1);
            System.out.println("ok");
        }
        
        
    }
    
    @DELETE
    @Path("/{id}")
    public void deleteProductJson(@PathParam("id") Integer id) {
        
        ProductDao.deleteById(id);
        System.out.println(id);
    }
}

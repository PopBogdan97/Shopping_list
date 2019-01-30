/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package services;

import utilities.UploadImage;
import com.google.gson.Gson;
import dao.ListDao;
import entities.Element;
import entities.ElementList;
import entities.ListBean;
import entities.ProductBean;
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
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getSingleListJson(@PathParam("id") Integer id) {
        ListBean list = ListDao.getSingleList(id);
        return new Gson().toJson(list);
    }

    @GET
    @Path("/{id}/products")
    @Produces(MediaType.APPLICATION_JSON)
    public String getSingleListProductsJson(@PathParam("id") Integer id) {
        ListBean list = ListDao.getSingleList(id);
        ElementList el = new ElementList();
//        ArrayList<Element> listProducts = new ArrayList<>();
//        
//        int i = 0;
//        for(String s : list.getProducts()){
//            Element e = new Element();
//            e.setId(i +"");
//            e.setText(s);
//            listProducts.add(e);
//            i++;
//        }
        el.setResults(list.getProducts());
        return new Gson().toJson(el);
    }

    @GET
    @Path("/{id}/product/{productId}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getProductsByListJson(@PathParam("id") Integer id, @PathParam("productId") Integer productId) {
        ProductBean product = ListDao.getProductByList(id, productId);

        return new Gson().toJson(product);
    }

    @GET
    @Path("/{id}/catProducts")
    @Produces(MediaType.APPLICATION_JSON)
    public String getSingleListCatProductsJson(@PathParam("id") Integer id, @QueryParam("q") String q, @QueryParam("limit") int limit) {
        ElementList catProducts = ListDao.getCatProducts(id, q == null ? "" : q, limit == 0 ? "" : "LIMIT " + limit);
        return new Gson().toJson(catProducts);
    }
    
    @GET
    @Path("/{id}/catProducts/cat")
    @Produces(MediaType.APPLICATION_JSON)
    public String getSingleListCatProductsOrderedJson(@PathParam("id") Integer id, @QueryParam("q") String q) {
        ElementList catProducts = ListDao.getCatProductsOrdered(id, q == null ? "" : q);
        return new Gson().toJson(catProducts);
    }

    @GET
    @Path("/image/{id}")
    @Produces("image/png")
    public String getImage(@PathParam("id") Integer id) throws IOException {

        String filename = ListDao.getImage(id);

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
    @Path("/{id}")
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    public void putListJson(@PathParam("id") Integer id,
            @FormDataParam("name") String name,
            @FormDataParam("catName") String catName,
            @FormDataParam("description") String description,
            @FormDataParam("file") InputStream file,
            @FormDataParam("mod") boolean mod) throws IOException {

        String fileName = "";

        if (file != null) {

            fileName = id + ".png";

            System.out.println(fileName);

            UploadImage.upload(file, fileName, "list");
        }

        if (ListDao.modify(id, name, catName, description, fileName, (mod || file != null))) {
            System.out.println("ok");
        }
    }

    @PUT
    @Path("/{id}/product")
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    public void putListProductsJson(@PathParam("id") Integer id,
            @FormDataParam("product") Integer product,
            @FormDataParam("quantity") Integer quantity) throws IOException {

        if (ListDao.updateProducts(id, product, quantity)) {
            System.out.println("ok");
        }
    }

    @PUT
    @Path("/{id}/product/add")
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    @Produces(MediaType.APPLICATION_JSON)
    public String putListProductsAddJson(@PathParam("id") Integer id,
            @FormDataParam("product") Integer product,
            @FormDataParam("quantity") Integer quantity) throws IOException {
        
        String str = ListDao.getProductByList(id, product).getQuantity();
       
        
        int q=str==null ? 0 : Integer.parseInt(str);

        if (q == 0) {
            if (ListDao.setProducts(id, product, quantity)) {
                System.out.println("ok");
            }
        } else {
            if (ListDao.updateProducts(id, product, quantity + q)) {
                System.out.println("ok");
            }
        }
        
        return new Gson().toJson(id);
    }

    //add a single element per HTTP req, products is: 
    @POST
    @Path("/{id}/product")
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    public void postListProductsJson(@PathParam("id") Integer id,
            @FormDataParam("product") Integer product,
            @FormDataParam("quantity") Integer quantity) throws IOException {

        if (ListDao.setProducts(id, product, quantity)) {
            System.out.println("ok");
        }
    }

    @POST
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    public void postListJson(@FormDataParam("name") String name,
            @FormDataParam("catName") String catName,
            @FormDataParam("description") String description,
            @FormDataParam("file") InputStream file,
            @FormDataParam("ownerEmail") String ownerEmail,
            @FormDataParam("mod") boolean mod) throws IOException {

        String fileName = "";
        Integer id = ListDao.initialize(name, catName, description, fileName, ownerEmail, (mod || file != null));

        if (file != null && (id > 0)) {

            fileName = id + ".png";

            System.out.println(fileName);

            UploadImage.upload(file, fileName, "list");
        }

        if (id > 0) {
            ListDao.modify(id, name, catName, description, fileName, (mod || file != null));
            System.out.println("ok");

        }

    }

    @DELETE
    @Path("/{id}")
    public void deleteListJson(@PathParam("id") Integer id) {

        ListDao.delete(id);
        System.out.println(id);
    }

    @DELETE
    @Path("/{id}/product/{productId}")
    public void deleteProductListJson(@PathParam("id") Integer id, @PathParam("productId") Integer productId) {

        ListDao.deleteProduct(id, productId);
        System.out.println(id);
    }

}

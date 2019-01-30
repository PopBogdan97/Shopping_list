/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package services;

import utilities.UploadImage;
import com.google.gson.Gson;
import dao.ListCatDao;
import entities.ElementList;
import entities.ListCatBean;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Base64;
import java.util.List;
import java.util.Properties;
import javax.servlet.annotation.MultipartConfig;
import javax.ws.rs.Consumes;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.DELETE;
import javax.ws.rs.Produces;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import org.apache.commons.io.FileUtils;
import org.glassfish.jersey.media.multipart.FormDataBodyPart;
import org.glassfish.jersey.media.multipart.FormDataParam;

/**
 * REST Web Service
 *
 * @author Emiliano
 */
@Path("listcat")
public class ListCatResource {

    @Context
    private UriInfo context;

    /**
     * Creates a new instance of ListCatResource
     */
    public ListCatResource() {
    }

    /**
     * Retrieves representation of an instance of services.ListCatResource
     *
     * @return an instance of java.lang.String
     */
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public String getListsJson(@QueryParam("q") String q, @QueryParam("limit") int limit) {
        ElementList el = ListCatDao.getListListBean(q == null ? "" : q, limit == 0 ? "" : "LIMIT " + limit);
        System.out.println("q: " + q);
        System.out.println("limit: " + limit);

        return new Gson().toJson(el);
    }

    @POST
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    public void postListJson(@FormDataParam("name") String name, @FormDataParam("description") String description, @FormDataParam("arr") List<String> prodcat, @FormDataParam("file") InputStream file) throws IOException {
        
        String fileName = "";

        if (file != null) {

            fileName = name + ".png";

            System.out.println(fileName);

            UploadImage.upload(file, fileName, "listcat");
        }

        if (ListCatDao.initialize(name, description, fileName)) {
            if (ListCatDao.setProdCat(name, prodcat.toArray(new String[prodcat.size()]))) {
                System.out.println("ok");
            }
        }

    }

    @GET
    @Path("/{name}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getDataJson(@PathParam("name") String name) {
        ListCatBean list = ListCatDao.getDataBean(name);
        return new Gson().toJson(list);
    }

    @DELETE
    @Path("/{name}")
    public void deleteListJson(@PathParam("name") String name) {
        ListCatDao.delete(name);
        System.out.println(name);
    }

    /**
     * PUT method for updating or creating an instance of ListCatResource
     *
     * @param content representation for the resource
     */
    @PUT
    @Path("/{name}")
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    public void putListJson(@PathParam("name") String name, @FormDataParam("description") String description, @FormDataParam("file") InputStream file, @FormDataParam("mod") boolean mod) throws IOException {

        String fileName = "";

        if (file != null) {

            fileName = name + ".png";

            System.out.println(fileName);

            UploadImage.upload(file, fileName, "listcat");
        }

        if (ListCatDao.modify(name, description, fileName, (mod || file != null))) {
            System.out.println("ok");
        }
    }

    @GET
    @Path("/image/{name}")
    @Produces("image/png")
    public String getImage(@PathParam("name") String name) throws IOException {

        String filename = ListCatDao.getImage(name);

        if (!filename.equals("")) {

            InputStream is = UploadImage.class.getClassLoader().getResourceAsStream("../../WEB-INF/resources/path.properties");
            Properties properties = new Properties();
            properties.load(is);

            System.out.println(properties.getProperty("location") + "/listcat/" + filename);

            File file = new File(properties.getProperty("location") + "/listcat/", filename);

            byte[] fileContent = FileUtils.readFileToByteArray(file);
            String encodedString = Base64.getEncoder().encodeToString(fileContent);

            return encodedString;

        } else {

            return "{}";

        }
    }

}

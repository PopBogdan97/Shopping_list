/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package services;

import com.google.gson.Gson;
import dao.UserDao;
import entities.ElementList;
import entities.UserBean;
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
@Path("user")
public class UserResource {

    @Context
    private UriInfo context;

    /**
     * Creates a new instance of UserResource
     */
    public UserResource() {
    }

    /**
     * Retrieves representation of an instance of services.UserResource
     *
     * @return an instance of java.lang.String
     */
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public String getAllUsers(@QueryParam("q") String q, @QueryParam("limit") int limit) {
        ElementList el = UserDao.getAllUsers(q == null ? "" : q, limit == 0 ? "" : "LIMIT " + limit);
        System.out.println("q: " + q);
        System.out.println("limit: " + limit);

        return new Gson().toJson(el);
    }

    @GET
    @Path("/{email}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getSingleUserJson(@PathParam("email") String email) {
        UserBean user = UserDao.getSingleUser(email);
        return new Gson().toJson(user);
    }

    @GET
    @Path("/image/{email}")
    @Produces("image/png")
    public String getImage(@PathParam("email") String email) throws IOException {

        String filename = UserDao.getImage(email);

        if (!filename.equals("")) {

            InputStream is = UploadImage.class.getClassLoader().getResourceAsStream("../../WEB-INF/resources/path.properties");
            Properties properties = new Properties();
            properties.load(is);

            System.out.println(properties.getProperty("location") + "/user/" + filename);

            File file = new File(properties.getProperty("location") + "/user/", filename);

            byte[] fileContent = FileUtils.readFileToByteArray(file);
            String encodedString = Base64.getEncoder().encodeToString(fileContent);

            return encodedString;

        } else {

            return "{}";

        }
    }

    /**
     * PUT method for updating or creating an instance of UserResource
     *
     * @param content representation for the resource
     */
    @PUT
    @Path("/{email}")
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    public void putUserJson(@PathParam("email") String email,
            @FormDataParam("firstName") String firstName,
            @FormDataParam("lastName") String lastName,
            @FormDataParam("typology") String typology,
            @FormDataParam("cod") String cod,
            @FormDataParam("file") InputStream file,
            @FormDataParam("mod") boolean mod) throws IOException {

        String fileName = "";

        if (file != null) {

            fileName = email + ".png";

            System.out.println(fileName);

            UploadImage.upload(file, fileName, "user");
        }

        if (UserDao.modify(email, firstName, lastName, typology, cod, fileName, (mod || file != null))) {
            System.out.println("ok");
        }
    }
    
        @PUT
    @Path("/{email}/profile")
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    public void putUserProfileJson(@PathParam("email") String email,
            @FormDataParam("firstName") String firstName,
            @FormDataParam("lastName") String lastName,
            @FormDataParam("file") InputStream file,
            @FormDataParam("mod") boolean mod) throws IOException {
        
        String fileName = "";

        if (file != null) {

            fileName = email + ".png";

            System.out.println(fileName);

            UploadImage.upload(file, fileName, "user");
        }

        if (UserDao.modifyProfile(email, firstName, lastName, fileName, (mod || file != null))) {
            System.out.println("ok");
        }
    }

    @POST
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    public void postUserJson(@FormDataParam("email") String email,
            @FormDataParam("firstName") String firstName,
            @FormDataParam("lastName") String lastName,
            @FormDataParam("typology") String typology,
            @FormDataParam("cod") String cod,
            @FormDataParam("file") InputStream file,
            @FormDataParam("mod") boolean mod) throws IOException {

        String fileName = "";

        if (file != null) {

            fileName = email + ".png";

            System.out.println(fileName);

            UploadImage.upload(file, fileName, "user");
        }

        if (UserDao.initialize(email, firstName, lastName, typology, cod, fileName, (mod || file != null))) {
            System.out.println("ok");
        }

    }

    @DELETE
    @Path("/{email}")
    public void deleteListJson(@PathParam("email") String email) {

        UserDao.delete(email);
        System.out.println(email);
    }
}

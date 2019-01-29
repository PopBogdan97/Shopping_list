/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package services;

import com.google.gson.Gson;
import dao.ChatDao;
import entities.MessageBean;
import java.io.IOException;
import java.util.List;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.UriInfo;
import org.glassfish.jersey.media.multipart.FormDataParam;

/**
 *
 * @author Emiliano
 */
@Path("chat")
public class ChatResource {

    @Context
    private UriInfo context;

    /**
     * Creates a new instance of ListCatResource
     */
    public ChatResource() {
    }

    /**
     * Retrieves representation of an instance of services.ListCatResource
     *
     * @return an instance of java.lang.String
     */
    @GET
    @Path("/{listId}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getListsJson(@PathParam("listId") int listId, @QueryParam("last") int last, @QueryParam("limit") int limit) {
        
        List<MessageBean> messages = ChatDao.getData(listId, last, limit == 0 ? "" : "LIMIT " + limit);

        return new Gson().toJson(messages);
    }

    @POST
    @Path("/{listId}")
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    public void postListJson(@PathParam("listId") int listId, @FormDataParam("messageid") int messageid, @FormDataParam("email") String email) throws IOException {

            if (ChatDao.initialize(email, messageid, listId)) {
                System.out.println("ok");
            }

    }

}

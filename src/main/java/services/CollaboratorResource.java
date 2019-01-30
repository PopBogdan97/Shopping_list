/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package services;

import com.google.gson.Gson;
import dao.CollaboratorDao;
import entities.CollaboratorBean;
import java.util.ArrayList;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.Produces;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PUT;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.MediaType;
import org.glassfish.jersey.media.multipart.FormDataParam;

/**
 * REST Web Service
 *
 * @author bogdan
 */
@Path("collaborator")
public class CollaboratorResource {

    @Context
    private UriInfo context;

    /**
     * Creates a new instance of CollaboratorResource
     */
    public CollaboratorResource() {
    }

    /**
     * Retrieves representation of an instance of services.CollaboratorResource
     * @return an instance of java.lang.String
     */
    @GET
    @Path("/{email}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getListsJson(@PathParam("email") String email) {
        ArrayList<CollaboratorBean> collaborators = null;
        collaborators = CollaboratorDao.getCollaborators(email);
        
        return new Gson().toJson(collaborators);
    }

    /**
     * PUT method for updating or creating an instance of CollaboratorResource
     * @param content representation for the resource
     */
    @PUT
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    public void putCollabJson(@FormDataParam("email") String email, 
            @FormDataParam("listId") Integer listId,
            @FormDataParam("listName") String listName,
            @FormDataParam("addProduct") boolean addProduct,
            @FormDataParam("removeProduct") boolean removeProduct,
            @FormDataParam("editList") boolean editList,
            @FormDataParam("deleteList") boolean deleteList) {
        System.out.println("services.CollaboratorResource.putCollabJson()");
        if(CollaboratorDao.setCollaborator(email, listId, listName, addProduct, removeProduct, editList, deleteList)){
            System.out.println("ok");
        }
    }
}

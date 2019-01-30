/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.CollaboratorBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import utilities.DbConnect;

/**
 *
 * @author bogdan
 */
public class CollaboratorDao {

    public static ArrayList getCollaborators(String email) {

        ArrayList<CollaboratorBean> list = new ArrayList<>();

        try {
            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Collaborator WHERE Email=? ORDER BY ListName ");
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                CollaboratorBean collab = new CollaboratorBean();
                collab.setListId(rs.getInt("ListId"));
                collab.setEmail(rs.getString("Email"));
                collab.setListName(rs.getString("ListName"));
                collab.setAddProduct(rs.getBoolean("AddProduct"));
                collab.setDeleteProduct(rs.getBoolean("RemoveProduct"));
                collab.setEditList(rs.getBoolean("EditList"));
                collab.setDeleteList(rs.getBoolean("DeleteList"));

                list.add(collab);
            }

            conn.close();

        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public static boolean setCollaborator(String email, Integer listId, String listName, boolean addProduct, boolean removeProduct, boolean editList, boolean deleteList) {
        boolean status = false;
        try {

            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Collaborator WHERE Email=? AND ListId=?");
            ps.setString(1, email);
            ps.setInt(2, listId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                System.out.println("vecchio");
                PreparedStatement ps1 = conn.prepareStatement("UPDATE Collaborator SET AddProduct=?, RemoveProduct=?, EditList=?, DeleteList=?, ListName=? WHERE ListId=? AND Email=?");
                ps1.setBoolean(1, addProduct);
                ps1.setBoolean(2, removeProduct);
                ps1.setBoolean(3, editList);
                ps1.setBoolean(4, deleteList);
                ps1.setString(5, listName);
                ps1.setInt(6, listId);
                ps1.setString(7, email);
                

                status = ps1.executeUpdate() > 0;
            } else {
                System.out.println("nuovo");
                PreparedStatement ps2 = conn.prepareStatement("INSERT INTO Collaborator (AddProduct, RemoveProduct, EditList, DeleteList, ListName, ListId, Email) VALUES (?, ?, ?, ?, ?, ?, ?)");
                ps2.setBoolean(1, addProduct);
                ps2.setBoolean(2, removeProduct);
                ps2.setBoolean(3, editList);
                ps2.setBoolean(4, deleteList);
                ps2.setString(5, listName);
                ps2.setInt(6, listId);
                ps2.setString(7, email);

                status = ps2.executeUpdate() > 0;
            }
            
            conn.close();

        } catch (Exception e) {
            System.out.println(e);
        }
        return status;

    }
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.Element;
import entities.ElementList;
import entities.ListBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import servlets.DbConnect;

/**
 *
 * @author bogdan
 */
public class ListDao {
    
    public static ElementList getAllList(String str, String limit) {

        ElementList el = new ElementList();

        ArrayList<Element> listlist = new ArrayList<>();

        try {
            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement("SELECT * FROM List WHERE Name LIKE '%" + str + "%' " + limit);

            ResultSet rs = ps.executeQuery();

            int i = 0;
            while (rs.next()) {
                Element e = new Element();
                String name = rs.getString("Name");
                e.setId(i + "");
                e.setText(name);
                listlist.add(e);
                i++;
            }
            conn.close();

            System.out.println(listlist);

        } catch (Exception e) {
            System.out.println(e);
        }

        el.setResults(listlist);

        return el;
    }
    
    public static ListBean getSingleList(String name) {
        ListBean list = new ListBean();

        try {
            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement("SELECT * FROM List WHERE Name=?");
            ps.setString(1, name);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                list.setCatName(rs.getString("CatName"));
                list.setDescription(rs.getString("Description"));
                list.setOwnerEmail(rs.getString("OwnerEmail"));
            }

            PreparedStatement ps1 = conn.prepareStatement("SELECT * FROM List_Product WHERE ListName=?");
            ps1.setString(1, name);

            ResultSet rs1 = ps1.executeQuery();

            ArrayList<String> products = new ArrayList<>();

            while (rs1.next()) {
                products.add(rs1.getString("ProductName"));
            }

            list.setProduct(products);
            conn.close();

            list.setName(name);

        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }
    
    public static boolean delete(String name) {
        boolean status = false;
        try {

            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement(
                    "DELETE FROM List WHERE Name=?");
            ps.setString(1, name);

            status = ps.executeUpdate() > 0;

            conn.close();

        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }
    
    public static String getImage(String name) {

        String file = "";

        try {
            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement("SELECT * FROM List WHERE Name=?");
            ps.setString(1, name);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                file = rs.getString("Image");
            }

            conn.close();

            System.out.println(file);

        } catch (Exception e) {
            System.out.println(e);
        }
        return file;
    }
    
    public static boolean modify(String name, String catName, String description, String image, boolean mod) {
        boolean status = false;
        try {

            Connection conn = DbConnect.getConnection();

            if (mod) {

                PreparedStatement ps = conn.prepareStatement("UPDATE List SET Description=?, Image=?, CatName=? WHERE Name=?");
                ps.setString(1, description);
                ps.setString(2, image);
                ps.setString(3, catName);
                ps.setString(4, name);

                status = ps.executeUpdate() > 0;
            } else {
                PreparedStatement ps = conn.prepareStatement("UPDATE List SET Description=?, CatName=? WHERE Name=?");
                ps.setString(1, description);
                ps.setString(2, catName);
                ps.setString(3, name);

                status = ps.executeUpdate() > 0;
            }

            conn.close();

        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    
    }
    
    public static boolean initialize(String name, String catName, String description, String image, String ownerEmail, boolean mod) {
        boolean status = false;
        try {

            Connection conn = DbConnect.getConnection();
            
            if(mod){
                PreparedStatement ps = conn.prepareStatement("INSERT INTO ListCategory (Name, CatName, Description, Image, OwnerEmail) VALUES (?, ?, ?, ?, ?)");
                ps.setString(1, name);
                ps.setString(2, catName);
                ps.setString(3, description);
                ps.setString(4, image);
                ps.setString(5, ownerEmail);

                status = ps.executeUpdate() > 0;
            }else{
                PreparedStatement ps = conn.prepareStatement("INSERT INTO ListCategory (Name, CatName, Description, OwnerEmail) VALUES (?, ?, ?, ?)");
                ps.setString(1, name);
                ps.setString(2, catName);
                ps.setString(3, description);
                ps.setString(4, ownerEmail);

                status = ps.executeUpdate() > 0;
            }
            

            conn.close();

        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }
}   

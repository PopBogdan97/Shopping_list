/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.Element;
import entities.ElementList;
import entities.Product;
import entities.ProductBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import servlets.DbConnect;

/**
 *
 * @author Emiliano/Bogdan
 */
public class ProductDao {

    public static JSONArray getList(String str) {
        JSONArray array = new JSONArray();
        try {
            Connection conn = DbConnect.getConnection();
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Product WHERE Name LIKE '%" + str + "%' LIMIT 5");
            ResultSet rs = ps.executeQuery();
            int i = 0;
            while(rs.next()) {
                String nome = rs.getString("Name");
                String nomecat = rs.getString("CatName");
                JSONObject object = new JSONObject();
                object.put("id", i + "");
                object.put("text", nome+"-"+nomecat);
                array.add(object);
                i++;
            }
            conn.close();
            System.out.println(array);
        } catch (Exception e) {
            System.out.println(e);
        }
        return array;
    }
    
    public static List getProd(){
        List products = new ArrayList<>();
        try {
            Connection conn = DbConnect.getConnection();
            PreparedStatement stm = conn.prepareStatement("SELECT * FROM Product");
            try (ResultSet rs = stm.executeQuery()) {
                while(rs.next()) {
                    Product product = new Product();
                    product.setNome(rs.getString("Name"));
                    product.setCat_prodotto(rs.getString("CatName"));
                    product.setNote(rs.getString("Description"));
                    product.setFotografia(rs.getString("Image"));
                    products.add(product);
                }
            }
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return products;
    }
    
    public static JSONObject getData(String nome, String nomecat) {
        JSONObject object = new JSONObject();
        try {
            Connection conn = DbConnect.getConnection();
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Product WHERE Name=? AND CatName=?");
            ps.setString(1, nome);
            ps.setString(2, nomecat);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                object.put("Descrizione", rs.getString("Description"));
            }
            conn.close();
            System.out.println(object);
        } catch (Exception e) {
            System.out.println(e);
        }
        return object;
    }
    
    //-------  api functions --------
    
    public static ElementList getAllProducts(String str, String limit) {

        ElementList el = new ElementList();

        ArrayList<Element> listlist = new ArrayList<>();

        try {
            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Product WHERE Name LIKE '%" + str + "%' " + limit);

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
    
    public static ProductBean getSingleProduct(String name) {
        ProductBean list = new ProductBean();

        try {
            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Product WHERE Name=?");
            ps.setString(1, name);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                list.setCatName(rs.getString("CatName"));
                list.setDescription(rs.getString("Description"));
            }
            
            conn.close();

            list.setName(name);

        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }
    
    public static boolean initialize(String name, String description, String image, String catName) {
        boolean status = false;
        try {
            Connection conn = DbConnect.getConnection();
            PreparedStatement ps = conn.prepareStatement("INSERT INTO Product (Name, CatName, Description, Image) VALUES (?, ?, ?, ?)");
            ps.setString(1, name);
            ps.setString(2, catName);
            ps.setString(3, description);
            ps.setString(4, image);
            status = ps.executeUpdate() > 0;
            conn.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }
    
    public static boolean initialize(String name, String description, String image, String catName, String logo) {
        boolean status = false;
        try {
            Connection conn = DbConnect.getConnection();
            PreparedStatement ps = conn.prepareStatement("INSERT INTO Product (Name, CatName, Description, Image, Logo) VALUES (?, ?, ?, ?, ?)");
            ps.setString(1, name);
            ps.setString(2, catName);
            ps.setString(3, description);
            ps.setString(4, image);
            ps.setString(5, logo);
            status = ps.executeUpdate() > 0;
            conn.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }

    public static boolean delete(String name, String catName) {
        boolean status = false;
        try {
            Connection conn = DbConnect.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                    "DELETE FROM Product WHERE Name=? AND CatName=?");
            ps.setString(1, name);
            ps.setString(2, catName);
            PreparedStatement ps1 = conn.prepareStatement(
                    "DELETE FROM List_Product WHERE ProductName=?");
            ps.setString(1, name);
            
            status = (ps1.executeUpdate() > 0) && (ps.executeUpdate() > 0);
            conn.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }
    
    public static boolean deleteByCat(String catName) {
        boolean status = true;
        try {
            Connection conn = DbConnect.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                    "DELETE FROM Product WHERE CatName=?");
            ps.setString(1, catName);
            
            PreparedStatement ps1 = conn.prepareStatement(""
                    + "SELECT Name FROM Product WHERE CatName=?");
            ps.setString(1, catName);

            ResultSet rs = ps1.executeQuery();
            
            if (rs.next()) {
                PreparedStatement ps2 = conn.prepareStatement(
                    "DELETE FROM List_Product WHERE ProductName=?");
                ps2.setString(1, rs.getString("Name"));
                status = status && (ps2.executeUpdate() > 0);
            }
            
            status = status && (ps.executeUpdate() > 0);
            conn.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }
        
    public static String getImage(String name, String catName) {
        String file="";
        try {
            Connection conn = DbConnect.getConnection();
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Product WHERE Name=? AND CatName=?");
            ps.setString(1, name);
            ps.setString(2, catName);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                file=rs.getString("Image");
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
            if(mod) {
                PreparedStatement ps = conn.prepareStatement("UPDATE Product SET Description=?, Image=? WHERE Name=? AND CatName=?");
                ps.setString(1, description);
                ps.setString(2, image);
                ps.setString(3, name);
                ps.setString(4, catName);
                status = ps.executeUpdate() > 0;
            } else {
                PreparedStatement ps = conn.prepareStatement("UPDATE Product SET Description=? WHERE Name=? AND CatName=?");
                ps.setString(1, description);
                ps.setString(2, name);
                ps.setString(3, catName);
                status = ps.executeUpdate() > 0;
            }
            conn.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }
    
    public static boolean modify(String name, String catName, String description, String logo, String image, boolean mod) {
        boolean status = false;
        try {
            Connection conn = DbConnect.getConnection();
            if(mod) {
                PreparedStatement ps = conn.prepareStatement("UPDATE Product SET Description=?, Image=?, Logo=? WHERE Name=? AND CatName=?");
                ps.setString(1, description);
                ps.setString(2, image);
                ps.setString(3, logo);
                ps.setString(4, name);
                ps.setString(5, catName);
                status = ps.executeUpdate() > 0;
            } else {
                PreparedStatement ps = conn.prepareStatement("UPDATE Product SET Description=?, Logo=? WHERE Name=? AND CatName=?");
                ps.setString(1, description);
                ps.setString(2, logo);
                ps.setString(3, name);
                ps.setString(4, catName);
                status = ps.executeUpdate() > 0;
            }
            conn.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }
}

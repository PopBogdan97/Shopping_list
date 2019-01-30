/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.Element;
import entities.ElementList;
import entities.ProductBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
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
            while (rs.next()) {
                String nome = rs.getString("Name");
                String nomecat = rs.getString("CatName");
                JSONObject object = new JSONObject();
                object.put("id", i + "");
                object.put("text", nome + "-" + nomecat);
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

     public static boolean modify(String name, String catName, String description, String image, boolean mod) {
        boolean status = false;
        try {
            Connection conn = DbConnect.getConnection();
            if (mod) {
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
    
    public static List getProd() {
        List<ProductBean> products = new ArrayList<>();
        try {
            Connection conn = DbConnect.getConnection();
            PreparedStatement stm = conn.prepareStatement("SELECT * FROM Product");
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    ProductBean product = new ProductBean();
                    product.setId(rs.getInt("Id"));
                    product.setName(rs.getString("Name"));
                    product.setCatName(rs.getString("CatName"));
                    product.setDescription(rs.getString("Description"));
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
            if (rs.next()) {
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

            while (rs.next()) {
                Element e = new Element();
                String name = rs.getString("Name");
                String catName = rs.getString("CatName");
                String id = rs.getString("Id");
                e.setId(id);
                e.setText(name+"-"+catName);
                listlist.add(e);
            }
            conn.close();
            
            System.out.println(listlist);

        } catch (Exception e) {
            System.out.println(e);
        }

        el.setResults(listlist);

        return el;
    }

    public static ProductBean getSingleProduct(Integer id) {
        ProductBean list = new ProductBean();

        try {
            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Product WHERE Id=?");
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                list.setName(rs.getString("Name"));
                list.setCatName(rs.getString("CatName"));
                list.setDescription(rs.getString("Description"));
            }

            conn.close();

            list.setId(id);

        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    //funzione probabilmente da cancellare, da vedere se viene usata da emiliano da qualche parte
    public static boolean initialize(String name, String catName, String description, String image) {
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

    public static int initialize(String name, String catName, String description, String image, String logo) {
        int id = 0;
        try {
            Connection conn = DbConnect.getConnection();
            PreparedStatement ps = conn.prepareStatement("INSERT INTO Product (Name, CatName, Description, Image, Logo) VALUES (?, ?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, name);
            ps.setString(2, catName);
            ps.setString(3, description);
            ps.setString(4, image);
            ps.setString(5, logo);
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            rs.next();
            id = rs.getInt(1);
            System.out.println(rs.getInt(1));
            conn.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return id;
    }

    //vedere se viene utilizzata da qualche parte emiliano
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

            status = (ps1.executeUpdate() > 0) || status; 
            status = (ps.executeUpdate() > 0) && status;
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
                    + "SELECT * FROM Product WHERE CatName=?");
            ps1.setString(1, catName);

            ResultSet rs = ps1.executeQuery();

            if (rs.next()) {
                PreparedStatement ps2 = conn.prepareStatement(
                        "DELETE FROM List_Product WHERE ProductId=?");
                ps2.setInt(1, rs.getInt("Id"));
                System.out.println(rs.getInt("Id"));
                status = (ps2.executeUpdate() > 0) && status;
            }

            status = (ps.executeUpdate() > 0) && status;
            conn.close();
        } catch (Exception e) {
            System.out.println(e + "qui");
        }
        return status;
    }

    public static boolean deleteById(Integer id) {
        boolean status = true;
        try {
            Connection conn = DbConnect.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                    "DELETE FROM Product WHERE Id=?");
            ps.setInt(1, id);

            PreparedStatement ps1 = conn.prepareStatement(
                    "DELETE FROM List_Product WHERE ProductId=?");
            ps1.setInt(1, id);

            status = status && (ps1.executeUpdate() > 0);
            status = (ps.executeUpdate() > 0) && status;
            conn.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }

    //vedere se serve se no da cancellare
    public static String getImage(String name, String catName) {
        String file = "";
        try {
            Connection conn = DbConnect.getConnection();
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Product WHERE Name=? AND CatName=?");
            ps.setString(1, name);
            ps.setString(2, catName);
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

    public static String getImage(Integer id) {
        String file = "";
        try {
            Connection conn = DbConnect.getConnection();
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Product WHERE Id=?");
            ps.setInt(1, id);
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
    
    public static String getLogo(Integer id) {
        String file = "";
        try {
            Connection conn = DbConnect.getConnection();
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Product WHERE Id=?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                file = rs.getString("Logo");
            }
            conn.close();
            System.out.println(file);
        } catch (Exception e) {
            System.out.println(e);
        }
        return file;
    }

    public static boolean modify(Integer id, String name, String catName, String description, String image, boolean mod) { //forse da togliere
        boolean status = false;
        try {
            Connection conn = DbConnect.getConnection();
            if (mod) {
                PreparedStatement ps = conn.prepareStatement("UPDATE Product SET Description=?, Image=?, Name=?, CatName=? WHERE Id=?");
                ps.setString(1, description);
                ps.setString(2, image);
                ps.setString(3, name);
                ps.setString(4, catName);
                ps.setInt(5, id);
                status = ps.executeUpdate() > 0;
            } else {
                PreparedStatement ps = conn.prepareStatement("UPDATE Product SET Description=?, Name=?, CatName=? WHERE Id=?");
                ps.setString(1, description);
                ps.setString(2, name);
                ps.setString(3, catName);
                ps.setInt(4, id);
                status = ps.executeUpdate() > 0;
            }
            conn.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }

    public static boolean modify(Integer id, String description, String logo, String image, boolean modl, boolean modi) {
        boolean status = false;
        try {
            Connection conn = DbConnect.getConnection();
            if (modi && modl) {
                PreparedStatement ps = conn.prepareStatement("UPDATE Product SET Description=?, Image=?, Logo=? WHERE Id=?");
                ps.setString(1, description);
                ps.setString(2, image);
                ps.setString(3, logo);
                ps.setInt(4, id);
                status = ps.executeUpdate() > 0;
            } else if(modi && !modl){
                PreparedStatement ps = conn.prepareStatement("UPDATE Product SET Description=?, Image=? WHERE Id=?");
                ps.setString(1, description);
                ps.setString(2, image);
                ps.setInt(3, id);
                status = ps.executeUpdate() > 0;
            }
            else if(!modi && modl){
                PreparedStatement ps = conn.prepareStatement("UPDATE Product SET Description=?, Logo=? WHERE Id=?");
                ps.setString(1, description);
                ps.setString(2, logo);
                ps.setInt(3, id);
                status = ps.executeUpdate() > 0;
            }
            else{
                PreparedStatement ps = conn.prepareStatement("UPDATE Product SET Description=? WHERE Id=?");
                ps.setString(1, description);
                ps.setInt(2, id);
                status = ps.executeUpdate() > 0;
            }
            conn.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }
}

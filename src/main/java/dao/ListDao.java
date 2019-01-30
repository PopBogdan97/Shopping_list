/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.Element;
import entities.ElementList;
import entities.ListBean;
import entities.ProductBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import utilities.DbConnect;

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

    public static ListBean getSingleList(Integer id) {
        ListBean list = new ListBean();

        try {
            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement("SELECT * FROM List WHERE Id=?");
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                list.setName(rs.getString("Name"));
                list.setCatName(rs.getString("CatName"));
                list.setDescription(rs.getString("Description"));
                list.setOwnerEmail(rs.getString("OwnerEmail"));
            }

            PreparedStatement ps1 = conn.prepareStatement("SELECT List_Product.ProductId, Name FROM List_Product INNER JOIN Product P ON List_Product.ProductId = P.Id WHERE ListId=?;");
            ps1.setInt(1, id);

            ResultSet rs1 = ps1.executeQuery();

            ArrayList<Element> products = new ArrayList<>();

            while (rs1.next()) {
                Element tmpEl = new Element();
                tmpEl.setId(rs1.getInt("ProductId") + "");
                tmpEl.setText(rs1.getString("Name"));
                products.add(tmpEl);
            }

            for (Element e : products) {
                System.out.println("name: " + e.getText());
            }

            list.setProducts(products);
            conn.close();

            list.setId(id);

        } catch (Exception e) {
            System.out.println(e + "qua");
        }
        return list;
    }

    public static boolean delete(Integer id) {
        boolean status = true;
        try {

            Connection conn = DbConnect.getConnection();
            
            PreparedStatement ps2 = conn.prepareStatement(
                    "DELETE FROM Collaborator WHERE ListId=?");
            ps2.setInt(1, id);

            PreparedStatement ps1 = conn.prepareStatement(
                    "DELETE FROM List_Product WHERE ListId=?");
            ps1.setInt(1, id);

            PreparedStatement ps = conn.prepareStatement(
                    "DELETE FROM List WHERE Id=?");
            ps.setInt(1, id);

            status = (ps2.executeUpdate() > 0) && status;
            status = (ps1.executeUpdate() > 0) && status;
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
                    "DELETE FROM List WHERE CatName=?");
            ps.setString(1, catName);

            PreparedStatement ps1 = conn.prepareStatement(""
                    + "SELECT * FROM List WHERE CatName=?");
            ps1.setString(1, catName);

            ResultSet rs = ps1.executeQuery();

            if (rs.next()) {
                PreparedStatement ps2 = conn.prepareStatement(
                        "DELETE FROM List_Product WHERE ListId=?");
                ps2.setInt(1, rs.getInt("Id"));
                status = (ps2.executeUpdate() > 0) && status;
            }

            status = (ps.executeUpdate() > 0) && status;
            conn.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }

    public static String getImage(Integer id) {

        String file = "";

        try {
            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement("SELECT * FROM List WHERE Id=?");
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                file = (rs.getString("Image") == null) ? "" : rs.getString("Image");
            }

            conn.close();

            System.out.println(file);

        } catch (Exception e) {
            System.out.println(e);
        }
        return file;
    }

    public static boolean modify(Integer id, String name, String catName, String description, String image, boolean mod) {
        boolean status = false;
        try {

            Connection conn = DbConnect.getConnection();

            if (mod) {

                PreparedStatement ps = conn.prepareStatement("UPDATE List SET Description=?, Image=?, CatName=?, Name=? WHERE Id=?");
                ps.setString(1, description);
                ps.setString(2, image);
                ps.setString(3, catName);
                ps.setString(4, name);
                ps.setInt(5, id);

                status = ps.executeUpdate() > 0;
            } else {
                PreparedStatement ps = conn.prepareStatement("UPDATE List SET Description=?, CatName=?, Name=? WHERE Id=?");
                ps.setString(1, description);
                ps.setString(2, catName);
                ps.setString(3, name);
                ps.setInt(4, id);

                status = ps.executeUpdate() > 0;
            }

            conn.close();

        } catch (Exception e) {
            System.out.println(e);
        }
        return status;

    }

    public static int initialize(String name, String catName, String description, String image, String ownerEmail, boolean mod) {
        int id = 0;
        try {

            Connection conn = DbConnect.getConnection();

            if (mod) {
                PreparedStatement ps = conn.prepareStatement("INSERT INTO List (Name, CatName, Description, Image, OwnerEmail) VALUES (?, ?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
                ps.setString(1, name);
                ps.setString(2, catName);
                ps.setString(3, description);
                ps.setString(4, image);
                ps.setString(5, ownerEmail);

                ps.executeUpdate();
                ResultSet rs = ps.getGeneratedKeys();
                rs.next();
                id = rs.getInt(1);
                System.out.println(rs.getInt(1));
            } else {
                PreparedStatement ps = conn.prepareStatement("INSERT INTO List (Name, CatName, Description, OwnerEmail) VALUES (?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
                ps.setString(1, name);
                ps.setString(2, catName);
                ps.setString(3, description);
                ps.setString(4, ownerEmail);

                ps.executeUpdate();
                ResultSet rs = ps.getGeneratedKeys();
                rs.next();
                id = rs.getInt(1);
                System.out.println(rs.getInt(1));
            }

            conn.close();

        } catch (Exception e) {
            System.out.println(e + "è qui l'errore");
        }
        return id;
    }

    public static boolean setProducts(Integer id, Integer products, Integer quantity) {
        boolean status = true;
        try {

            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement("INSERT INTO List_Product (ListId, ProductId, Quantity) VALUES (?, ?, ?)");
            ps.setInt(1, id);
            ps.setInt(2, products);
            ps.setInt(3, quantity);
            status = status && (ps.executeUpdate() > 0);

            conn.close();

        } catch (Exception e) {
            System.out.println(e + " è qui l'ecezzione");
        }
        return status;
    }
    
    public static boolean updateProducts(Integer id, Integer products, Integer quantity) {
        boolean status = true;
        try {

            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement("UPDATE List_Product SET Quantity=? WHERE ListId=? AND ProductId=?");
            ps.setInt(1, quantity);
            ps.setInt(2, id);
            ps.setInt(3, products);
            status = status && (ps.executeUpdate() > 0);

            conn.close();

        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }
    
    public static ElementList getCatProducts(Integer id, String str, String limit) {
        ElementList el = new ElementList();
        try {
            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement("SELECT Product.Id, Product.Name FROM Product WHERE Product.CatName IN (SELECT ProductCat_ListCat.ProductCatName FROM ProductCat_ListCat WHERE ProductCat_ListCat.ListCatName IN (SELECT List.CatName FROM List WHERE List.Id =?)) AND Product.Name LIKE '%" + str + "%' " + limit);
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            ArrayList<Element> products = new ArrayList<>();

            while (rs.next()) {
                Element tmpEl = new Element();
                System.out.println("name by cat: " + rs.getString("Name"));
                tmpEl.setId(rs.getInt("Id") + "");
                tmpEl.setText(rs.getString("Name"));
                products.add(tmpEl);
            }

            for (Element e : products) {
                System.out.println("name by cat: " + e.getText());
            }

            el.setResults(products);
            conn.close();

        } catch (Exception e) {
            System.out.println(e + " qua");
        }
        return el;
    }

    public static ProductBean getProductByList(Integer id, Integer productId) {
        ProductBean product = new ProductBean();

        try {
            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement("SELECT Product.Id, Product.Name, Product.CatName, Product.Description, List_Product.Quantity FROM Product INNER JOIN List_Product  ON List_Product.ProductId = Product.Id WHERE List_Product.ListId=? AND Product.Id=?");
            ps.setInt(1, id);
            ps.setInt(2, productId);

            System.out.println(ps);
            System.out.println(productId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                product.setId(rs.getInt("Id"));
                product.setName(rs.getString("Name"));
                product.setCatName(rs.getString("CatName"));
                product.setDescription(rs.getString("Description"));
                product.setQuantity(rs.getString("Quantity"));
            }

            conn.close();

        } catch (Exception e) {
            System.out.println(e);
        }
        return product;
    }
    
    public static boolean deleteProduct(Integer id, Integer productId) {
        boolean status = true;
        try {

            Connection conn = DbConnect.getConnection();

            PreparedStatement ps1 = conn.prepareStatement(
                    "DELETE FROM List_Product WHERE ListId=? AND ProductId=?");
            ps1.setInt(1, id);
            ps1.setInt(2, productId);
            
            status = (ps1.executeUpdate() > 0);

            conn.close();

        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.Element;
import entities.ElementList;
import entities.ProductCatBean;
import entities.ShoppingList;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import servlets.DbConnect;

/**
 *
 * @author Emiliano/Bogdan
 */
public class ProdCatDao {

    public static JSONArray getList(String str) {
        JSONArray array = new JSONArray();
        try {
            Connection conn = DbConnect.getConnection();
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM ProductCategory WHERE Name LIKE '%" + str + "%' LIMIT 5");
            ResultSet rs = ps.executeQuery();
            int i = 0;
            while (rs.next()) {
                String nome = rs.getString("Name");
                JSONObject object = new JSONObject();
                object.put("id", i + "");
                object.put("text", nome);
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

    public static List getProd() {
        List shoppingLists = new ArrayList<>();
        try {
            Connection conn = DbConnect.getConnection();
            PreparedStatement stm = conn.prepareStatement("SELECT * FROM ProductCategory");
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    ShoppingList shoppingList = new ShoppingList();
                    shoppingList.setNome(rs.getString("Name"));
                    shoppingList.setDescrizione(rs.getString("Description"));

                    PreparedStatement stm1 = conn.prepareStatement("SELECT count(*) as cnt FROM Product where CatName=?");
                    stm1.setString(1, rs.getString("Name"));
                    try (ResultSet rs1 = stm1.executeQuery()) {
                        rs1.next();
                        shoppingList.setCounter(rs1.getString("cnt"));
                    } catch (Exception ex) {
                        System.out.println(ex);
                    }
                    shoppingLists.add(shoppingList);
                }
            }
            conn.close();
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return shoppingLists;
    }

    public static JSONObject getData(String nome) {
        JSONObject object = new JSONObject();
        try {
            Connection conn = DbConnect.getConnection();
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM ProductCategory WHERE Name=?");
            ps.setString(1, nome);
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

    //------ api functions -------
    public static ElementList getAllProductCat(String str, String limit) {

        ElementList el = new ElementList();

        ArrayList<Element> listlist = new ArrayList<>();

        try {
            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement("SELECT * FROM ProductCategory WHERE Name LIKE '%" + str + "%' " + limit);

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

    public static ProductCatBean getSingleProductCat(String name) {
        ProductCatBean prodcat = new ProductCatBean();

        try {
            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement("SELECT * FROM ProductCategory WHERE Name=?");
            ps.setString(1, name);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                prodcat.setDescription(rs.getString("Description"));
            }

            PreparedStatement ps1 = conn.prepareStatement("SELECT * FROM ProductCat_ListCat WHERE ProductCatName=?");
            ps1.setString(1, name);

            ResultSet rs1 = ps1.executeQuery();

            ArrayList<String> lists = new ArrayList<>();

            while (rs1.next()) {
                lists.add(rs1.getString("ListCatName"));
            }

            prodcat.setCatLists(lists);

            PreparedStatement ps2 = conn.prepareStatement("SELECT * FROM Product WHERE CatName=?");
            ps2.setString(1, name);

            ResultSet rs2 = ps2.executeQuery();

            ArrayList<Element> products = new ArrayList<>();

            while (rs2.next()) {
                Element tmpEl = new Element();
                String tmp = rs2.getInt("Id")+"";
                tmpEl.setId(tmp);
                tmp =rs2.getString("Name");
                tmpEl.setText(tmp);
                products.add(tmpEl);
            }

            prodcat.setProducts(products);

            conn.close();
            prodcat.setName(name);

        } catch (Exception e) {
            System.out.println(e);
        }
        return prodcat;
    }

    public static boolean initialize(String name, String description, String logo) {
        boolean status = false;
        try {
            Connection conn = DbConnect.getConnection();
            PreparedStatement ps = conn.prepareStatement("INSERT INTO ProductCategory (Name, Description, Logo) VALUES (?, ?, ?)");
            ps.setString(1, name);
            ps.setString(2, description);
            ps.setString(3, logo);
            status = ps.executeUpdate() > 0;
            conn.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }

    public static boolean delete(String name) {
        boolean status = true;
        try {
            Connection conn = DbConnect.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                    "DELETE FROM ProductCategory WHERE Name=?");
            ps.setString(1, name);
            PreparedStatement ps1 = conn.prepareStatement(
                    "DELETE FROM ProductCat_ListCat WHERE ProductCatName=?");
            ps1.setString(1, name);

            status = ProductDao.deleteByCat(name);

            status = (ps1.executeUpdate() > 0) && status;
            status = (ps.executeUpdate() > 0) && status;
            conn.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }

    public static String getLogo(String name) {
        String file = "";
        try {
            Connection conn = DbConnect.getConnection();
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM ProductCategory WHERE Name=?");
            ps.setString(1, name);
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

    public static boolean modify(String name, String description, String logo, boolean mod) {
        boolean status = false;
        try {
            Connection conn = DbConnect.getConnection();
            if (mod) {
                PreparedStatement ps = conn.prepareStatement("UPDATE ProductCategory SET Description=?, Logo=? WHERE Name=?");
                ps.setString(1, description);
                ps.setString(2, logo);
                ps.setString(3, name);
                status = ps.executeUpdate() > 0;
            } else {
                PreparedStatement ps = conn.prepareStatement("UPDATE ProductCategory SET Description=? WHERE Name=?");
                ps.setString(1, description);
                ps.setString(2, name);
                status = ps.executeUpdate() > 0;
            }
            conn.close();

        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }

    public static boolean setListCat(String prodcat, String[] listcat) {
        boolean status = true;
        try {
            if (!listcat[0].equals("")) {
                Connection conn = DbConnect.getConnection();

                for (String l : listcat) {
                    PreparedStatement ps = conn.prepareStatement("INSERT INTO ProductCat_ListCat (ListCatName, ProductCatName) VALUES (?, ?)");
                    ps.setString(1, l);
                    ps.setString(2, prodcat);
                    status = status && (ps.executeUpdate() > 0);
                }
                conn.close();
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }
}

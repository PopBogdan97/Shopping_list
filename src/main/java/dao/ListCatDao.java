/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.Element;
import entities.ElementList;
import entities.ListCatBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import servlets.DbConnect;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author Emiliano
 */
public class ListCatDao {

    public static JSONArray getList(String str) {
        JSONArray array = new JSONArray();

        try {
            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Cat_lista WHERE Nome LIKE '%" + str + "%' LIMIT 5");

            ResultSet rs = ps.executeQuery();

            int i = 0;
            while (rs.next()) {
                String nome = rs.getString("Nome");
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

    public static boolean initialize(String nome, String descrizione, String immagine) {
        boolean status = false;
        try {

            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement("INSERT INTO Cat_lista (Nome, Descrizione, Immagine) VALUES (?, ?, ?)");
            ps.setString(1, nome);
            ps.setString(2, descrizione);
            ps.setString(3, immagine);

            status = ps.executeUpdate() > 0;

            conn.close();

        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }

    public static boolean setProdCat(String listcat, String[] prodcat) {
        boolean status = true;
        try {

            Connection conn = DbConnect.getConnection();

            for (String p : prodcat) {
                PreparedStatement ps = conn.prepareStatement("INSERT INTO Rel_cat (Nomecatlista, Nomecatprodotto) VALUES (?, ?)");
                ps.setString(1, listcat);
                ps.setString(2, p);
                status = status && (ps.executeUpdate() > 0);
            }
            conn.close();

        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }

    public static boolean delete(String nome) {
        boolean status = false;
        try {

            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement(
                    "DELETE FROM Cat_lista WHERE Nome=?");
            ps.setString(1, nome);

            status = ps.executeUpdate() > 0;

            conn.close();

        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }
    
        public static JSONObject getData(String nome) {
        JSONObject object = new JSONObject();

        try {
            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Cat_lista WHERE Nome=?");
            ps.setString(1, nome);

            ResultSet rs = ps.executeQuery();

                if(rs.next()){
                    object.put("Descrizione", rs.getString("Descrizione"));
                }
                
                            PreparedStatement ps1 = conn.prepareStatement("SELECT * FROM Rel_cat WHERE Nomecatlista=?");
            ps1.setString(1, nome);

            ResultSet rs1 = ps1.executeQuery();
                    JSONArray array=new JSONArray();

                while(rs1.next()){
                    JSONObject obj=new JSONObject();
                    obj.put("Nomecatprodotto", rs1.getString("Nomecatprodotto"));
                    array.add(obj);
                }                
                
                object.put("Categorie", array);
            conn.close();

            System.out.println(object);

        } catch (Exception e) {
            System.out.println(e);
        }
        return object;
    }
        
                public static String getImage(String nome) {

                    String file="";

        try {
            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Cat_lista WHERE Nome=?");
            ps.setString(1, nome);

            ResultSet rs = ps.executeQuery();

            
                if(rs.next()){
                    file=rs.getString("Immagine");
                }

            conn.close();

            System.out.println(file);

        } catch (Exception e) {
            System.out.println(e);
        }
        return file;
    }
                
                    public static boolean modify(String nome, String descrizione, String immagine, boolean mod) {
        boolean status = false;
        try {

            Connection conn = DbConnect.getConnection();
            
            if(mod){

            PreparedStatement ps = conn.prepareStatement("UPDATE Cat_lista SET Descrizione=?, Immagine=? WHERE Nome=?");
            ps.setString(1, descrizione);
            ps.setString(2, immagine);
            ps.setString(3, nome);

            status = ps.executeUpdate() > 0;
            }
            else{
            PreparedStatement ps = conn.prepareStatement("UPDATE Cat_lista SET Descrizione=? WHERE Nome=?");
            ps.setString(1, descrizione);
            ps.setString(2, nome);

            status = ps.executeUpdate() > 0;
            }                
            

            conn.close();

        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }

    public static ElementList getListListBean(String str, String limit) {

        ElementList el=new ElementList();
        
        ArrayList<Element> listlist = new ArrayList<>();

        try {
            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Cat_lista WHERE Nome LIKE '%" + str + "%' "+limit);

            ResultSet rs = ps.executeQuery();

            int i = 0;
            while (rs.next()) {
                Element e = new Element();
                String nome = rs.getString("Nome");
                e.setId(i + "");
                e.setText(nome);
                listlist.add(e);
                i++;
            }
            conn.close();
            
        } catch (Exception e) {
            System.out.println(e);
        }
        
        el.setResults(listlist);
        
        return el;
    }
    
            public static ListCatBean getDataBean(String nome) {
        ListCatBean list = new ListCatBean();

        try {
            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Cat_lista WHERE Nome=?");
            ps.setString(1, nome);

            ResultSet rs = ps.executeQuery();

                if(rs.next()){
                    list.setDescription(rs.getString("Descrizione"));
                }
                
                            PreparedStatement ps1 = conn.prepareStatement("SELECT * FROM Rel_cat WHERE Nomecatlista=?");
            ps1.setString(1, nome);

            ResultSet rs1 = ps1.executeQuery();
            
            ArrayList<String> cat=new ArrayList<>();
            
                while(rs1.next()){                    
                    cat.add(rs1.getString("Nomecatprodotto"));
                }                
                
                list.setCategories(cat);
            conn.close();
            
            list.setName(nome);

        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }
}

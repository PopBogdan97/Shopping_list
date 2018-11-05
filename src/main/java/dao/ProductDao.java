/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import servlets.DbConnect;

/**
 *
 * @author Emiliano
 */
public class ProductDao {

    public static JSONArray getList(String str) {
        JSONArray array = new JSONArray();

        try {
            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement(
                    "SELECT * FROM Prodotto WHERE Nome LIKE '%" + str + "%' LIMIT 5");
            ResultSet rs = ps.executeQuery();

            int i = 0;
            while (rs.next()) {
                String nome = rs.getString("Nome");
                String nomecat = rs.getString("NomeCat");
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

    public static boolean initialize(String nome, String descrizione, String immagine, String cat) {
        boolean status = false;
        try {

            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement(
                    "INSERT INTO Prodotto (Nome, NomeCat, Note, Fotografia) VALUES (?, ?, ?, ?)");
            ps.setString(1, nome);
            ps.setString(2, cat);
            ps.setString(3, descrizione);
            ps.setString(4, immagine);

            status = ps.executeUpdate() > 0;

            conn.close();

        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }

    public static boolean delete(String nome, String cat) {
        boolean status = false;
        try {

            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement(
                    "DELETE FROM Prodotto WHERE Nome=? AND NomeCat=?");
            ps.setString(1, nome);
            ps.setString(2, cat);

            status = ps.executeUpdate() > 0;

            conn.close();

        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }
    
            public static JSONObject getData(String nome, String nomecat) {
        JSONObject object = new JSONObject();

        try {
            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Prodotto WHERE Nome=? AND NomeCat=?");
            ps.setString(1, nome);
            ps.setString(2, nomecat);

            ResultSet rs = ps.executeQuery();

                if(rs.next()){
                    object.put("Descrizione", rs.getString("Note"));
                }
                
            conn.close();

            System.out.println(object);

        } catch (Exception e) {
            System.out.println(e);
        }
        return object;
    }
        
                public static String getImage(String nome, String nomecat) {

                    String file="";

        try {
            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Prodotto WHERE Nome=? AND NomeCat=?");
            ps.setString(1, nome);
            ps.setString(2, nomecat);

            ResultSet rs = ps.executeQuery();

            
                if(rs.next()){
                    file=rs.getString("Fotografia");
                }

            conn.close();

            System.out.println(file);

        } catch (Exception e) {
            System.out.println(e);
        }
        return file;
    }
                
                    public static boolean modify(String nome, String nomecat, String descrizione, String immagine, boolean mod) {
        boolean status = false;
        try {

            Connection conn = DbConnect.getConnection();
            
            if(mod){

            PreparedStatement ps = conn.prepareStatement("UPDATE Prodotto SET Note=?, Fotografia=? WHERE Nome=? AND NomeCat=?");
            ps.setString(1, descrizione);
            ps.setString(2, immagine);
            ps.setString(3, nome);
            ps.setString(4, nomecat);

            status = ps.executeUpdate() > 0;
            }
            else{
            PreparedStatement ps = conn.prepareStatement("UPDATE Prodotto SET Note=? WHERE Nome=? AND NomeCat=?");
            ps.setString(1, descrizione);
            ps.setString(2, nome);
            ps.setString(3, nomecat);

            status = ps.executeUpdate() > 0;
            }                
            

            conn.close();

        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }
}

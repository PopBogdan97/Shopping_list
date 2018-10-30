/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
}

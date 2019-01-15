/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

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
 * @author Emiliano
 */
public class ProdCatDao {
    
    public static JSONArray getList(String str) {
        JSONArray array = new JSONArray();
        try {
            Connection conn = DbConnect.getConnection();
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Cat_prodotto WHERE Nome LIKE '%"+str+"%' LIMIT 5");
            ResultSet rs = ps.executeQuery();
            int i=0;
            while (rs.next()) {
                String nome = rs.getString("Nome");
                JSONObject object = new JSONObject();
                object.put("id", i+"");
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
        boolean status=false;  
        try {
            Connection conn=DbConnect.getConnection();
            PreparedStatement ps=conn.prepareStatement("INSERT INTO Cat_prodotto (Nome, Descrizione, Logo) VALUES (?, ?, ?)");  
            ps.setString(1,nome);  
            ps.setString(2,descrizione);
            ps.setString(3,immagine);
            status=ps.executeUpdate()>0;
            conn.close();
        } catch(Exception e) {
            System.out.println(e);
        }  
        return status;  
    }
    
    public static List getProd(){
        List shoppingLists = new ArrayList<>();
        try {
            Connection conn = DbConnect.getConnection();
            PreparedStatement stm = conn.prepareStatement("SELECT * FROM Cat_prodotto");
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    ShoppingList shoppingList = new ShoppingList();
                    shoppingList.setNome(rs.getString("Nome"));
                    shoppingList.setDescrizione(rs.getString("Descrizione"));
                    
                    PreparedStatement stm1 = conn.prepareStatement("SELECT count(*) as cnt FROM Prodotto where NomeCat=?");
                    stm1.setString(1,rs.getString("Nome"));  
                    try(ResultSet rs1 = stm1.executeQuery()){
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
    
    public static boolean delete(String nome) {
        boolean status = false;
        try {
            Connection conn = DbConnect.getConnection();
            PreparedStatement ps = conn.prepareStatement("DELETE FROM Cat_prodotto WHERE Nome=?");
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
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Cat_prodotto WHERE Nome=?");
            ps.setString(1, nome);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                object.put("Descrizione", rs.getString("Descrizione"));
            }    
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
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Cat_prodotto WHERE Nome=?");
            ps.setString(1, nome);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                file=rs.getString("Logo");
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
                PreparedStatement ps = conn.prepareStatement("UPDATE Cat_prodotto SET Descrizione=?, Logo=? WHERE Nome=?");
                ps.setString(1, descrizione);
                ps.setString(2, immagine);
                ps.setString(3, nome);
                status = ps.executeUpdate() > 0;
            } else {
                PreparedStatement ps = conn.prepareStatement("UPDATE Cat_prodotto SET Descrizione=? WHERE Nome=?");
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
}

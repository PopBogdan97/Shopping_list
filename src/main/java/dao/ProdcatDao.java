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
public class ProdcatDao {
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
        try{  
        
            Connection conn=DbConnect.getConnection();
            PreparedStatement ps=conn.prepareStatement("INSERT INTO Cat_prodotto (Nome, Descrizione, Logo) VALUES (?, ?, ?)");  
            ps.setString(1,nome);  
            ps.setString(2,descrizione);
            ps.setString(3,immagine);
            
            status=ps.executeUpdate()>0;

            conn.close();
              
        }catch(Exception e){
            System.out.println(e);
        }  
        return status;  
    }
    
    public static List getProd(){
        List shoppingLists = new ArrayList<>();
        try{
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
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return shoppingLists;
    }
}

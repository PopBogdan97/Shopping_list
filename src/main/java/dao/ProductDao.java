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
"SELECT * FROM Prodotto WHERE Nome LIKE '%"+str+"%' LIMIT 5");
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
        
                public static boolean initialize(String nome, String descrizione, String immagine, String cat) {
               boolean status=false;  
    try{  
        
        Connection conn=DbConnect.getConnection();
        
        PreparedStatement ps=conn.prepareStatement(  
"INSERT INTO Prodotto (Nome, NomeCat, Note, Fotografia) VALUES (?, ?, ?, ?)");  
ps.setString(1,nome);  
ps.setString(2,cat);
ps.setString(3,descrizione);
ps.setString(4,immagine);

status=ps.executeUpdate()>0;

    conn.close();
              
    }catch(Exception e){System.out.println(e);}  
    return status;  
    }    
}

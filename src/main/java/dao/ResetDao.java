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

/**
 *
 * @author Emiliano
 */
public class ResetDao {
        public static boolean reset(String email, String cod){  
    boolean status=false;  
    try{  
        
        Connection conn=DbConnect.getConnection();
          
        PreparedStatement ps=conn.prepareStatement(  
"SELECT * FROM Utente WHERE Email=? AND Cod=?");  
ps.setString(1,email);  
ps.setString(2,cod);  

    ResultSet rs=ps.executeQuery();  

    status=rs.next();

        conn.close();

    }catch(Exception e){System.out.println(e);}  
    return status;  
    }  
}

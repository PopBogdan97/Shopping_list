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
public class MailDao {
    
        public static boolean setcod(String email, String cod){  
    boolean status=false;  
    try{  
        
        Connection conn=DbConnect.getConnection();
          
        PreparedStatement ps=conn.prepareStatement(  
"UPDATE User SET Cod=? WHERE Email=?");  
ps.setString(1,cod);  
ps.setString(2,email);
    
    status=(ps.executeUpdate()>0);

    conn.close();
    
    }catch(Exception e){System.out.println(e);}  
    return status;  
    }  
    
}

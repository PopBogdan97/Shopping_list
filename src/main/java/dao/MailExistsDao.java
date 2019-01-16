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
public class MailExistsDao {
        public static boolean exits(String email){  
            boolean status=false;
    try{  
        
        Connection conn=DbConnect.getConnection();
          
        PreparedStatement ps=conn.prepareStatement(  
"SELECT * FROM User WHERE Email=?");  
ps.setString(1,email);  

    ResultSet rs=ps.executeQuery();  

    status=rs.next();
        
    conn.close();
    
              
    }catch(Exception e){System.out.println(e);}  
    return status;  
    }  
}

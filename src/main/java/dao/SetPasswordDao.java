/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import servlets.DbConnect;

/**
 *
 * @author Emiliano
 */
public class SetPasswordDao {
        public static boolean set(String email, String cod, String password){  
    boolean status=false;  
    try{  
        
        Connection conn=DbConnect.getConnection();
          
        PreparedStatement ps=conn.prepareStatement(  
"UPDATE Utente SET Password=PASSWORD(?) WHERE Email=? AND Cod=?");  
ps.setString(1,password);  
ps.setString(2,email);  
ps.setString(3,cod);  

    status=(ps.executeUpdate()>0);

        conn.close();

    }catch(Exception e){System.out.println(e);}  
    return status;  
    }      
}

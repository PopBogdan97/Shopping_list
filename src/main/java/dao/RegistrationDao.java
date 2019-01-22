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
public class RegistrationDao {
    
    public static boolean register(String email, String password, String name, String surname){  
        boolean status=false;  
        try {
            Connection conn=DbConnect.getConnection();
            PreparedStatement ps=conn.prepareStatement("INSERT INTO User (Email, Password, FirstName, LastName, Typology, Valid) VALUES (?, PASSWORD(?), ?, ?, 'normal', 0)");  
            ps.setString(1,email);  
            ps.setString(2,password);
            ps.setString(3,name);
            ps.setString(4,surname);
            status=ps.executeUpdate()>0;
            conn.close();
        } catch(Exception e) {
            System.out.println(e);
        }  
        return status;
    }  
}

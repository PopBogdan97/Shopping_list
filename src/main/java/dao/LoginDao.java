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
public class LoginDao {

    public static String authenticate(String email, String password) {
        
        String status = "notexist";

        try {

            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement("SELECT * FROM User WHERE Email=? AND Password=PASSWORD(?)");
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

/////
                if (rs.getString("Valid").equals("1")) {
                    status = rs.getString("Typology");
                } else {
                    status = "notvalid";
                }
            }

            conn.close();

            System.out.println(status);
            

        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }

    public static boolean setLoginCookie(String email, String id) {
        boolean status = false;
        try {

            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement(
                    "UPDATE User SET Cookie=? WHERE Email=?");
            ps.setString(1, id);
            ps.setString(2, email);

            status = ps.executeUpdate() > 0;

            conn.close();

        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }
    
}

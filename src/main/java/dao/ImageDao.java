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
public class ImageDao {

    public static boolean setimage(String email, String path) {
        boolean status = false;
        try {

            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement(
                    "UPDATE User SET Image=? WHERE Email=?");
            ps.setString(1, path);
            ps.setString(2, email);

            status = (ps.executeUpdate() > 0);

            conn.close();

        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }

}

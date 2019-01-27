/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.Element;
import entities.ElementList;
import entities.UserBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import servlets.DbConnect;

/**
 *
 * @author bogdan
 */

public class UserDao {

    public static ElementList getAllUsers(String str, String limit) {

        ElementList el = new ElementList();

        ArrayList<Element> listlist = new ArrayList<>();

        try {
            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement("SELECT * FROM User WHERE Email LIKE '%" + str + "%' " + limit);

            ResultSet rs = ps.executeQuery();

            int i = 0;
            while (rs.next()) {
                Element e = new Element();
                String name = rs.getString("Email");
                e.setId(i + "");
                e.setText(name);
                listlist.add(e);
                i++;
            }
            conn.close();

            System.out.println(listlist);

        } catch (Exception e) {
            System.out.println(e);
        }

        el.setResults(listlist);

        return el;
    }

    public static UserBean getSingleUser(String email) {
        UserBean user = new UserBean();

        try {
            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement("SELECT * FROM User WHERE Email=?");
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user.setFirstName(rs.getString("FirstName"));
                user.setLastName(rs.getString("LastName"));
                user.setTypology(rs.getString("Typology"));
                user.setValid(rs.getBoolean("Valid"));
                user.setCod(rs.getString("Cod"));
            }

            PreparedStatement ps1 = conn.prepareStatement("SELECT * FROM List WHERE OwnerEmail=?");
            ps1.setString(1, email);

            ResultSet rs1 = ps1.executeQuery();

            ArrayList<Element> lists = new ArrayList<>();
            Element tmpEl = new Element();

            while (rs1.next()) {
                tmpEl.setId(rs1.getInt("Id")+"");
                tmpEl.setText(rs1.getString("Name"));
                lists.add(tmpEl);
            }
            
            PreparedStatement ps2 = conn.prepareStatement("SELECT * FROM Collaborator WHERE Email=?");
            ps2.setString(1, email);

            ResultSet rs2 = ps2.executeQuery();

            while (rs2.next()) {
                tmpEl.setId(rs1.getInt("ListId")+"");
                tmpEl.setText(rs1.getString("ListName"));
                lists.add(tmpEl);
            }

            user.setLists(lists);
            conn.close();

            user.setEmail(email);

        } catch (Exception e) {
            System.out.println(e + "single user");
        }
        return user;
    }
    
    
    public static UserBean getSingleUserByCookie(String cookie) {
        UserBean list = new UserBean();

        try {
            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement("SELECT * FROM User WHERE Cookie=?");
            ps.setString(1, cookie);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                list.setEmail(rs.getString("Email"));
                list.setFirstName(rs.getString("FirstName"));
                list.setLastName(rs.getString("LastName"));
                list.setTypology(rs.getString("Typology"));
                list.setValid(rs.getBoolean("Valid"));
                list.setCod(rs.getString("Cod"));
            }
            
            conn.close();

        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }
    

    public static boolean delete(String email) {
        boolean status = true;
        try {

            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement(
                    "DELETE FROM User WHERE Email=?");
            ps.setString(1, email);

            PreparedStatement ps1 = conn.prepareStatement(""
                    + "SELECT Name FROM List WHERE OwnerEmail=?");
            ps.setString(1, email);

            ResultSet rs = ps1.executeQuery();

            if (rs.next()) {
                status = ListDao.delete(rs.getInt("Id")) && status;
            }

            status = (ps.executeUpdate() > 0) && status;

            conn.close();

        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }

    public static String getImage(String email) {

        String file = "";

        try {
            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement("SELECT * FROM User WHERE Email=?");
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                file = rs.getString("Image");
            }

            conn.close();

            System.out.println(file);

        } catch (Exception e) {
            System.out.println(e);
        }
        return file;
    }

    public static String getCookie(String email) {

        String cookie = "";

        try {
            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement("SELECT * FROM User WHERE Email=?");
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                cookie = rs.getString("Cookie");
            }

            conn.close();

            System.out.println(cookie);

        } catch (Exception e) {
            System.out.println(e);
        }
        return cookie;
    }
    
    public static boolean deleteCookie(String cookieUID){
        boolean success = false;
        
        try {
            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement("UPDATE User SET Cookie='NULL' WHERE Cookie=?");
            ps.setString(1, cookieUID);
            
            int rs = ps.executeUpdate();
            
            if(rs == 1){
                success = true;
            }
            
            conn.close();

        } catch (Exception e) {
            System.out.println(e);
        }
        
        return success;
    }

    
    public static boolean modify(String email, String firstName, String lastName, String typology, String cod, String image, boolean mod) {
        boolean status = false;
        try {

            Connection conn = DbConnect.getConnection();

            if (mod) {

                PreparedStatement ps = conn.prepareStatement("UPDATE User SET FirstName=?, LastName=?, Typology=?, Cod=?, Image=? WHERE Email=?");
                ps.setString(1, firstName);
                ps.setString(2, lastName);
                ps.setString(3, typology);
                ps.setString(4, cod);
                ps.setString(5, image);
                ps.setString(6, email);

                status = ps.executeUpdate() > 0;
            } else {
                PreparedStatement ps = conn.prepareStatement("UPDATE User SET FirstName=?, LastName=?, Typology=?, Cod=? WHERE Email=?");
                ps.setString(1, firstName);
                ps.setString(2, lastName);
                ps.setString(3, typology);
                ps.setString(4, cod);
                ps.setString(5, email);

                status = ps.executeUpdate() > 0;
            }

            conn.close();

        } catch (Exception e) {
            System.out.println(e);
        }
        return status;

    }

    public static boolean initialize(String email, String firstName, String lastName, String typology, String cod, String image, boolean mod) {
        boolean status = false;
        try {

            Connection conn = DbConnect.getConnection();

            if (mod) {
                PreparedStatement ps = conn.prepareStatement("INSERT INTO User (Email, FirstName, LastName, Typology, Valid, Cod, Image) VALUES (?, ?, ?, ?, 0, ?, ?)");
                ps.setString(1, email);
                ps.setString(2, firstName);
                ps.setString(3, lastName);
                ps.setString(4, typology);
                ps.setString(5, cod);
                ps.setString(6, image);

                status = ps.executeUpdate() > 0;
            } else {
                PreparedStatement ps = conn.prepareStatement("INSERT INTO User (Email, FirstName, LastName, Typology, Valid, Cod) VALUES (?, ?, ?, ?, 0, ?)");
                ps.setString(1, email);
                ps.setString(2, firstName);
                ps.setString(3, lastName);
                ps.setString(4, typology);
                ps.setString(5, cod);

                status = ps.executeUpdate() > 0;
            }

            conn.close();

        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }

    public static boolean initialize(String email, String firstName, String lastName, String typology, String cod, String image, String cookie, boolean mod) {
        boolean status = false;
        try {

            Connection conn = DbConnect.getConnection();

            if (mod) {
                PreparedStatement ps = conn.prepareStatement("INSERT INTO User (Email, FirstName, LastName, Typology, Valid, Cod, Image, Cookie) VALUES (?, ?, ?, ?, 0, ?, ?, ?)");
                ps.setString(1, email);
                ps.setString(2, firstName);
                ps.setString(3, lastName);
                ps.setString(4, typology);
                ps.setString(5, cod);
                ps.setString(6, image);
                ps.setString(7, cookie);

                status = ps.executeUpdate() > 0;
            } else {
                PreparedStatement ps = conn.prepareStatement("INSERT INTO User (Email, FirstName, LastName, Typology, Valid, Cod, Cookie) VALUES (?, ?, ?, ?, 0, ?, ?)");
                ps.setString(1, email);
                ps.setString(2, firstName);
                ps.setString(3, lastName);
                ps.setString(4, typology);
                ps.setString(5, cod);
                ps.setString(6, cookie);

                status = ps.executeUpdate() > 0;
            }

            conn.close();

        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }

    public static boolean initializeAnonymous(String cookie) {
        boolean status = false;
        try {

            Connection conn = DbConnect.getConnection();

            Timestamp ts = new Timestamp(System.currentTimeMillis());
            Date date = new Date();
            date.setTime(ts.getTime());
            String formattedDate = new SimpleDateFormat("yyyyMMdd").format(date);

            PreparedStatement ps = conn.prepareStatement("INSERT INTO User (Email, Password, FirstName, LastName, Typology, Valid, Cookie) VALUES (?, PASSWORD(?), ?, ?, 'anonymous', 1, ?)");
            ps.setString(1, cookie);
            ps.setString(2, cookie);
            ps.setString(3, cookie);
            ps.setString(4, formattedDate);
            ps.setString(5, cookie);

            status = ps.executeUpdate() > 0;

            conn.close();

        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }
    
    public static boolean updateAnonymous(String cookie) {
        boolean status = false;
        try {

            Connection conn = DbConnect.getConnection();

            Timestamp ts = new Timestamp(System.currentTimeMillis());
            Date date = new Date();
            date.setTime(ts.getTime());
            String formattedDate = new SimpleDateFormat("yyyyMMdd").format(date);

            PreparedStatement ps = conn.prepareStatement("UPDATE User SET LastName=? WHERE Cookie=?");
            ps.setString(1, formattedDate);
            ps.setString(2, cookie);

            status = ps.executeUpdate() > 0;

            conn.close();

        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }

    public static boolean setValid(String email, boolean valid) {
        boolean status = false;
        try {
            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement("UPDATE User SET Valid=? WHERE Email=?");
            ps.setBoolean(1, valid);
            ps.setString(2, email);

            status = ps.executeUpdate() > 0;

            conn.close();

            System.out.println(status);

        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }

    public static boolean setCookie(String email, String cookie) {
        boolean status = false;
        try {
            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement("UPDATE User SET Cookie=? WHERE Email=?");
            ps.setString(1, cookie);
            ps.setString(2, email);

            status = ps.executeUpdate() > 0;

            conn.close();

            System.out.println(status);

        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }

    public static boolean getValid(String email) {
        boolean valid = false;

        try {
            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement("SELECT * FROM User WHERE Email=?");
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                valid = rs.getBoolean("Valid");
            }

            conn.close();

            System.out.println(valid);

        } catch (Exception e) {
            System.out.println(e);
        }
        return valid;
    }
}

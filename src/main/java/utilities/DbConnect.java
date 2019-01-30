/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilities;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Emiliano
 */
public class DbConnect {

    static String url;
    static String user;
    static String password;

    public static Connection getConnection() throws ClassNotFoundException, InstantiationException, IllegalAccessException, IOException {

        Connection conn = null;

        InputStream is = DbConnect.class.getClassLoader().getResourceAsStream("../../WEB-INF/resources/db.properties");
        Properties properties = new Properties();
        properties.load(is);

        try {
            url = properties.getProperty("url");
            user = properties.getProperty("user");
            password = properties.getProperty("password");
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            conn = DriverManager.getConnection(url, user, password);
        } catch (SQLException ex) {
            Logger.getLogger(DbConnect.class.getName()).log(Level.SEVERE, null, ex);
            return conn;
        }
        return conn;

    }

}

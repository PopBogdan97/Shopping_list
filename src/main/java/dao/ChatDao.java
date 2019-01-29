/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.MessageBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import servlets.DbConnect;

/**
 *
 * @author Emiliano
 */
public class ChatDao {

    public static boolean initialize(String email, int messageid, int listId) {
        boolean status = false;
        try {

            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement("INSERT INTO Chat (ListId, Email, PrebuildMesId, Time, Message) VALUES (?, ?, ?, NOW(), '')");
            ps.setInt(1, listId);
            ps.setString(2, email);
            ps.setInt(3, messageid);

            status = ps.executeUpdate() > 0;

            conn.close();

        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }

    public static List getData(int listId, int last, String limit) {

        List<MessageBean> list = new ArrayList<>();

        try {
            Connection conn = DbConnect.getConnection();

            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Chat WHERE ListId=? AND Id>? ORDER BY Id " + limit);
            ps.setInt(1, listId);
            ps.setInt(2, last);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                MessageBean message = new MessageBean();
                message.setId(rs.getInt("Id"));
                message.setEmail(rs.getString("Email"));
                message.setMessage(rs.getInt("PrebuildMesId"));
                message.setDate(new SimpleDateFormat ("yyyy.MM.dd 'at' hh:mm:ss").format(rs.getDate("Time")));

                list.add(message);
            }
            
            conn.close();


        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mail;

import dao.UserDao;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author Emiliano
 */
public class Mailer {

    private static final String ALPHA_NUMERIC_STRING = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

public static String randomAlphaNumeric(int count) {

StringBuilder builder = new StringBuilder();

while (count-- != 0) {

int character = (int)(Math.random()*ALPHA_NUMERIC_STRING.length());

builder.append(ALPHA_NUMERIC_STRING.charAt(character));

}

return builder.toString();

}
    public static boolean sendMail(String email) throws IOException {
        
        boolean status=false;
        
        if(UserDao.exits(email)){
            
            status=true;
            
    String cod=randomAlphaNumeric(8);
    
    if(UserDao.setcod(email, cod)){
    
        final String host = "smtp.gmail.com";
        final String port = "465";
        
        InputStream is=Mailer.class.getClassLoader().getResourceAsStream("../../WEB-INF/resources/mail.properties");
        Properties properties=new Properties();
        properties.load(is);
 
        final String username = properties.getProperty("username");
        final String password = properties.getProperty("password");
        Properties props = System.getProperties();
        props.setProperty("mail.smtp.host", host);
        props.setProperty("mail.smtp.port", port);
        props.setProperty("mail.smtp.socketFactory.port", port);
        props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.setProperty("mail.smtp.auth", "true");
        props.setProperty("mail.smtp.starttls.enable", "true");
        props.setProperty("mail.debug", "true");
        props.put("mail.from", "noreply@shoppinglist.com");
        props.put("mail.from.alias", "Shopping List");
        
        Session session = Session.getInstance(props, new Authenticator() {

            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });
        Message msg = new MimeMessage(session);
        try {
            msg.setFrom(new InternetAddress(username));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email, false));
            msg.setSubject("Shopping List Registration");
            msg.setText("Click the link to activate the account: "+"http://localhost:8080/ShoppingList/ActivateServlet?email="+email+"&cod="+cod);
            msg.setSentDate(new Date());
            Transport.send(msg);
        } catch (MessagingException me) {
//TODO: log the exception
            me.printStackTrace(System.err);
        }
    }
    
        }
        
        return status;
    }
}

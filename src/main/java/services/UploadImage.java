/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package services;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.Properties;
import javax.imageio.ImageIO;
import javax.servlet.http.Part;

/**
 *
 * @author Emiliano
 */
public class UploadImage {

    public static void upload(InputStream file, String name, String sub) throws IOException {

        InputStream is = UploadImage.class.getClassLoader().getResourceAsStream("../../WEB-INF/resources/path.properties");
        Properties properties = new Properties();
        properties.load(is);

        File dir = new File(properties.getProperty("location"));

        if (!dir.exists()) {
            dir.mkdir();
            System.out.println("createdir");
        }

        File subdir = new File(properties.getProperty("location"), sub);

        if (!subdir.exists()) {
            subdir.mkdir();
            System.out.println("createsubdir");
        }

        try {
            File outputfile = new File(subdir, name);
            //ImageIO.setCacheDirectory(subdir);
            ImageIO.write(ImageIO.read(file), "png", outputfile);
        } catch (IOException e) {
            System.out.println(e);
        }

    }
    
    public static void uploadLogo(InputStream file, String name, String sub) throws IOException {

        InputStream is = UploadImage.class.getClassLoader().getResourceAsStream("../../WEB-INF/resources/path.properties");
        Properties properties = new Properties();
        properties.load(is);

        File dir = new File(properties.getProperty("logoLocation"));

        if (!dir.exists()) {
            dir.mkdir();
            System.out.println("createdir");
        }

        File subdir = new File(properties.getProperty("logoLocation"), sub);

        if (!subdir.exists()) {
            subdir.mkdir();
            System.out.println("createsubdir");
        }

        try {
            File outputfile = new File(subdir, name);
            //ImageIO.setCacheDirectory(subdir);
            ImageIO.write(ImageIO.read(file), "png", outputfile);
        } catch (IOException e) {
            System.out.println(e);
        }

    }
}

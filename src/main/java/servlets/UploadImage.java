/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.Properties;
import javax.servlet.http.Part;

/**
 *
 * @author Emiliano
 */
public class UploadImage {
    
        public static void upload(Part part, String name) throws IOException {
            
        InputStream is = UploadImage.class.getClassLoader().getResourceAsStream("../../WEB-INF/resources/path.properties");
        Properties properties = new Properties();
        properties.load(is);

        File dir = new File(properties.getProperty("location"));
        
        if (!dir.exists()) {
            dir.mkdir();
            System.out.println("create");
        }
        
File file = new File(dir, name);

try (InputStream input = part.getInputStream()) {
    Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
}
        }
}

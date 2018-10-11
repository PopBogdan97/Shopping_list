/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package objects;

/**
 *
 * @author Emiliano
 */
public class Product {
    
    String name;
    String description;
    String logo;
    
    
    public void setName(String name) {
        this.name = name;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    
    public String getName() {
        return name;
    }

    public String getDescription() {
        return name;
    }

    public String getLogo() {
        return name;
    }
    
        Product(String name, String description, String logo) {

        this.name = name;
        this.description = description;
        this.logo = logo;

    }
        
        
}

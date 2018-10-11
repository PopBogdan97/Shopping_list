/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package objects;

import java.util.ArrayList;

/**
 *
 * @author Emiliano
 */
public class ProductCat {

    String name;
    String description;
    String logo;
    ArrayList<Product> products;
    

    public ArrayList<Product> getProducts() {
        return products;
    }

    
    public void setName(String name) {
        this.name = name;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public void setProducts(ArrayList<Product> products) {
        this.products = products;
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
    
    
    ProductCat(String name, String description, String logo) {

        this.name = name;
        this.description = description;
        this.logo = logo;

    }

}

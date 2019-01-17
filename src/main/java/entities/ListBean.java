/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.util.ArrayList;
/**
 *
 * @author bogdan
 */
public class ListBean {
    
    private String Name;
    private String CatName;
    private String Description;
    private String OwnerEmail;
    private ArrayList<String> Product;

    public String getName() {
        return Name;
    }

    public void setName(String Name) {
        this.Name = Name;
    }

    public String getCatName() {
        return CatName;
    }

    public void setCatName(String CatName) {
        this.CatName = CatName;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String Description) {
        this.Description = Description;
    }

    public String getOwnerEmail() {
        return OwnerEmail;
    }

    public void setOwnerEmail(String OwnerEmail) {
        this.OwnerEmail = OwnerEmail;
    }

    public ArrayList<String> getProduct() {
        return Product;
    }

    public void setProduct(ArrayList<String> Product) {
        this.Product = Product;
    }
    
}

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
    
    private int Id;
    private String Name;
    private String CatName;
    private String Description;
    private String OwnerEmail;
    private ArrayList<Element> Products;

    public int getId() {
        return Id;
    }

    public void setId(int Id) {
        this.Id = Id;
    }

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

    public ArrayList<Element> getProducts() {
        return Products;
    }

    public void setProducts(ArrayList<Element> Products) {
        this.Products = Products;
    }
    
}

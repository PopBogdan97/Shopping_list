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
public class ProductCatBean {
    
    private String Name;
    private String Description;
    private ArrayList<String> Products;

    /**
     *
     * @return
     */
    public String getName() {
        return Name;
    }

    /**
     *
     * @param Name
     */
    public void setName(String Name) {
        this.Name = Name;
    }

    /**
     *
     * @return
     */
    public String getDescription() {
        return Description;
    }

    /**
     *
     * @param Description
     */
    public void setDescription(String Description) {
        this.Description = Description;
    }

    /**
     *
     * @return
     */
    public ArrayList<String> getProducts() {
        return Products;
    }

    /**
     *
     * @param Products
     */
    public void setProducts(ArrayList<String> Products) {
        this.Products = Products;
    }
}

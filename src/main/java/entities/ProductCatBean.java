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
    private String Logo;
    private ArrayList<Element> Products;
    private ArrayList<String> CatLists;
    private int Counter;

    public ArrayList<String> getCatLists() {
        return CatLists;
    }

    public void setCatLists(ArrayList<String> CatLists) {
        this.CatLists = CatLists;
    }
    
    public String getLogo() {
        return Logo;
    }

    public void setLogo(String Logo) {
        this.Logo = Logo;
    }
    
    
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
    public ArrayList<Element> getProducts() {
        return Products;
    }

    /**
     *
     * @param Products
     */
    public void setProducts(ArrayList<Element> Products) {
        this.Products = Products;
    }

    /**
     * @return the Counter
     */
    public int getCounter() {
        return Counter;
    }

    /**
     * @param Counter the Counter to set
     */
    public void setCounter(int Counter) {
        this.Counter = Counter;
    }
}

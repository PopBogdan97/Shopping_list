/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.util.ArrayList;

/**
 *
 * @author Emiliano
 */
public class ListCatBean {
    
    private String Name;
    private String Description;
    private ArrayList<String> Categories; //product categories

    /**
     * @return the Name
     */
    public String getName() {
        return Name;
    }

    /**
     * @param Name the Name to set
     */
    public void setName(String Name) {
        this.Name = Name;
    }

    /**
     * @return the description
     */
    public String getDescription() {
        return Description;
    }

    /**
     * @param Description the Description to set
     */
    public void setDescription(String Description) {
        this.Description = Description;
    }
    
    /**
     * @return the categories
     */
    public ArrayList<String> getCategories() {
        return Categories;
    }

    /**
     * @param Categories the Categories to set
     */
    public void setCategories(ArrayList<String> Categories) {
        this.Categories = Categories;
    }
}

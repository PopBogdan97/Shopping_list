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
public class ProductList {
    
    String name;
    String description;
    String image;
    
    ListCat category;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public ListCat getCategory() {
        return category;
    }

    public void setCategory(ListCat category) {
        this.category = category;
    }
    
    
    
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

/**
 *
 * @author bogdan
 */
public class ProductBean {
    
    private Integer Id;
    private String Name;
    private String CatName;
    private String Description;
    private String Quantity;

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
    
    public Integer getId() {
        return Id;
    }

    public String getQuantity() {
        return Quantity;
    }

    public void setQuantity(String Quantity) {
        this.Quantity = Quantity;
    }

    public void setId(Integer Id) {
        this.Id = Id;
    }

    /**
     *
     * @return
     */
    public String getCatName() {
        return CatName;
    }

    /**
     *
     * @param CatName
     */
    public void setCatName(String CatName) {
        this.CatName = CatName;
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
}

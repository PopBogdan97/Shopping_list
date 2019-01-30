package entities;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author bogdan
 */
public class CollaboratorBean {
    
    private String Email;
    private String ListName;
    private Integer ListId;
    private boolean AddProduct;
    private boolean DeleteProduct;
    private boolean EditList;
    private boolean DeleteList;

    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    public String getListName() {
        return ListName;
    }

    public void setListName(String ListName) {
        this.ListName = ListName;
    }

    public Integer getListId() {
        return ListId;
    }

    public void setListId(Integer ListId) {
        this.ListId = ListId;
    }

    public boolean isAddProduct() {
        return AddProduct;
    }

    public void setAddProduct(boolean AddProduct) {
        this.AddProduct = AddProduct;
    }

    public boolean isDeleteProduct() {
        return DeleteProduct;
    }

    public void setDeleteProduct(boolean DeleteProduct) {
        this.DeleteProduct = DeleteProduct;
    }

    public boolean isEditList() {
        return EditList;
    }

    public void setEditList(boolean EditList) {
        this.EditList = EditList;
    }

    public boolean isDeleteList() {
        return DeleteList;
    }

    public void setDeleteList(boolean DeleteList) {
        this.DeleteList = DeleteList;
    }
    
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

/**
 *
 * @author Emiliano
 */
public class MessageBean {

    private int Id;    
    private String Email;
    private int Message;
    private String Date;
    private int List;

    /**
     * @return the Email
     */
    public String getEmail() {
        return Email;
    }

    /**
     * @param Email the Email to set
     */
    public void setEmail(String Email) {
        this.Email = Email;
    }

    /**
     * @return the Message
     */
    public int getMessage() {
        return Message;
    }

    /**
     * @param Message the Message to set
     */
    public void setMessage(int Message) {
        this.Message = Message;
    }

    /**
     * @return the Date
     */
    public String getDate() {
        return Date;
    }

    /**
     * @param Date the Date to set
     */
    public void setDate(String Date) {
        this.Date = Date;
    }

    /**
     * @return the Id
     */
    public int getId() {
        return Id;
    }

    /**
     * @param Id the Id to set
     */
    public void setId(int Id) {
        this.Id = Id;
    }

    /**
     * @return the List
     */
    public int getList() {
        return List;
    }

    /**
     * @param List the List to set
     */
    public void setList(int List) {
        this.List = List;
    }
    
    
}

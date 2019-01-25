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

public class UserBean {
    
    private String Email;
    private String FirstName;
    private String LastName;
    private String Typology;
    private boolean Valid;
    private String Cod;
    private ArrayList<String> Lists;

    /**
     *
     * @return
     */
    public String getEmail() {
        return Email;
    }

    /**
     *
     * @param Email
     */
    public void setEmail(String Email) {
        this.Email = Email;
    }

    /**
     *
     * @return
     */
    public String getFirstName() {
        return FirstName;
    }

    /**
     *
     * @param FirstName
     */
    public void setFirstName(String FirstName) {
        this.FirstName = FirstName;
    }

    /**
     *
     * @return
     */
    public String getLastName() {
        return LastName;
    }

    /**
     *
     * @param LastName
     */
    public void setLastName(String LastName) {
        this.LastName = LastName;
    }

    /**
     *
     * @return
     */
    public String getTypology() {
        return Typology;
    }

    /**
     *
     * @param Typology
     */
    public void setTypology(String Typology) {
        this.Typology = Typology;
    }

    /**
     *
     * @return
     */
    public boolean isValid() {
        return Valid;
    }

    /**
     *
     * @param Valid
     */
    public void setValid(boolean Valid) {
        this.Valid = Valid;
    }

    /**
     *
     * @return
     */
    public String getCod() {
        return Cod;
    }

    /**
     *
     * @param Cod
     */
    public void setCod(String Cod) {
        this.Cod = Cod;
    }

    /**
     *
     * @return
     */
    public ArrayList<String> getLists() {
        return Lists;
    }

    /**
     *
     * @param Lists
     */
    public void setLists(ArrayList<String> Lists) {
        this.Lists = Lists;
    }
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.util.ArrayList;

/**
 *
 * @author Marco
 */
public class Product {
    private String nome;
    private String cat_prodotto;
    private String note;
    private String fotografia;

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }
    
    public String getFotografia() {
        return note;
    }

    public void setFotografia(String fotografia) {
        this.fotografia = fotografia;
    }

    public String getCat_prodotto() {
        return cat_prodotto;
    }

    public void setCat_prodotto(String cat_prodotto) {
        this.cat_prodotto = cat_prodotto;
    }
}

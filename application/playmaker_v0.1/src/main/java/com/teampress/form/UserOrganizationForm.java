package com.teampress.form;

public class UserOrganizationForm extends BaseForm {

    public Integer organization;
    public Integer user;
    public Integer type;
    public Integer liga;

    public Integer getOrganization() {
        return organization;
    }

    public void setOrganization(Integer organization) {
        this.organization = organization;
    }

    public Integer getUser() {
        return user;
    }

    public void setUser(Integer user) {
        this.user = user;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Integer getLiga() {
        return liga;
    }

    public void setLiga(Integer liga) {
        this.liga = liga;
    }
}

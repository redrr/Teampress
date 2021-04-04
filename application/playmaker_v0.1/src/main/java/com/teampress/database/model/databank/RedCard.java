package com.teampress.database.model.databank;

import com.teampress.database.model.system.Organization;

public class RedCard {

	private Organization organization;
	private Liga liga;
	private Integer hely;
	private String name;
	private Integer card;

	public RedCard() {
	}

	public Organization getOrganization() {
		return organization;
	}

	public void setOrganization(Organization organization) {
		this.organization = organization;
	}

	public Liga getLiga() {
		return liga;
	}

	public void setLiga(Liga liga) {
		this.liga = liga;
	}

	public Integer getHely() {
		return hely;
	}

	public void setHely(Integer hely) {
		this.hely = hely;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getCard() {
		return card;
	}

	public void setCard(Integer card) {
		this.card = card;
	}
}

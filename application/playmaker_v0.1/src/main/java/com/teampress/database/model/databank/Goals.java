package com.teampress.database.model.databank;

import com.teampress.database.model.system.Organization;

public class Goals {

	private Organization organization;
	private Liga liga;
	private Integer fordulo;
	private Integer hely;
	private String name;
	private Integer goalInFord;
	private Integer goal;

	public Goals() {
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

	public Integer getGoal() {
		return goal;
	}

	public void setGoal(Integer goal) {
		this.goal = goal;
	}

	public Integer getFordulo() {
		return fordulo;
	}

	public void setFordulo(Integer fordulo) {
		this.fordulo = fordulo;
	}

	public Integer getGoalInFord() {
		return goalInFord;
	}

	public void setGoalInFord(Integer goalInFord) {
		this.goalInFord = goalInFord;
	}
}

package hu.playmaker.database.model.databank;

import hu.playmaker.database.model.BaseModel;
import hu.playmaker.database.model.system.Organization;

import javax.persistence.*;


/**
 * The persistent class for the PARAMETERS database table.
 * 
 */
@Entity
@Table(name="GOALS", schema="probe")
@NamedQueries({
		@NamedQuery(name="Goals.findAll", query="SELECT p FROM Goals p"),
		@NamedQuery(name="Goals.countAll", query="SELECT COUNT(p) FROM Goals p"),
		@NamedQuery(name="Goals.findByOrg", query="SELECT p FROM Goals p WHERE p.organization = :porg AND p.liga=:pliga"),
		@NamedQuery(name="Goals.findUni", query="SELECT p FROM Goals p WHERE p.organization = :porg AND p.liga=:pliga AND p.fordulo=:pford AND p.name=:pname"),
		@NamedQuery(name="Goals.findForStat", query="SELECT p FROM Goals p WHERE p.organization = :porg AND p.liga=:pliga  AND p.name=:pname")
})
@Cacheable(false)
public class Goals extends BaseModel {
	private static final long serialVersionUID = 1L;

	@ManyToOne
	@JoinColumn(name="ORG_ID")
	private Organization organization;

	@ManyToOne
	@JoinColumn(name="LIGA_ID")
	private Liga liga;

	@Column(name="FORD", length=255)
	private Integer fordulo;

	@Column(name="HELYEZES", length=255)
	private Integer hely;

	@Column(name="NEV", length=255)
	private String name;

	@Column(name="FORD_GOAL", length=255)
	private Integer goalInFord;

	@Column(name="GOALS", length=255)
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
package hu.playmaker.database.model.databank;

import hu.playmaker.database.model.BaseModel;
import hu.playmaker.database.model.system.Organization;

import javax.persistence.*;


/**
 * The persistent class for the PARAMETERS database table.
 * 
 */
@Entity
@Table(name="YELLOW_CARD", schema="probe")
@NamedQueries({
		@NamedQuery(name="YellowCard.findAll", query="SELECT p FROM YellowCard p"),
		@NamedQuery(name="YellowCard.countAll", query="SELECT COUNT(p) FROM YellowCard p"),
		@NamedQuery(name="YellowCard.findByOrg", query="SELECT p FROM YellowCard p WHERE p.organization = :porg AND p.liga=:pliga"),
		@NamedQuery(name="YellowCard.findUni", query="SELECT p FROM YellowCard p WHERE p.organization = :porg AND p.liga=:pliga AND p.name=:pname")
})
@Cacheable(false)
public class YellowCard extends BaseModel {
	private static final long serialVersionUID = 1L;

	@ManyToOne
	@JoinColumn(name="ORG_ID")
	private Organization organization;

	@ManyToOne
	@JoinColumn(name="LIGA_ID")
	private Liga liga;

	@Column(name="HELYEZES", length=255)
	private Integer hely;

	@Column(name="NEV", length=255)
	private String name;

	@Column(name="CARD", length=255)
	private Integer card;

	public YellowCard() {
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
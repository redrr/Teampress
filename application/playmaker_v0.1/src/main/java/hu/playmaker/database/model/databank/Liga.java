package hu.playmaker.database.model.databank;

import hu.playmaker.database.model.BaseModel;

import javax.persistence.*;


/**
 * The persistent class for the PARAMETERS database table.
 * 
 */
@Entity
@Table(name="LIGA", schema="probe")
@NamedQueries({
		@NamedQuery(name="Liga.findAll", query="SELECT p FROM Liga p"),
		@NamedQuery(name="Liga.countAll", query="SELECT COUNT(p) FROM Liga p"),
		@NamedQuery(name="Liga.findByLiga", query="SELECT p FROM Liga p WHERE p.id = :pliga"),
		@NamedQuery(name="Liga.findByName", query="SELECT p FROM Liga p WHERE p.liga = :pliga"),
		@NamedQuery(name="Liga.findByOrgAnd", query="SELECT p FROM Liga p WHERE p.id = :pliga")
})
@Cacheable(false)
public class Liga extends BaseModel {
	private static final long serialVersionUID = 1L;

	@Column(name="EVAD", nullable=false, length=255)
	private String evad;

	@Column(name="SZERVEZO", nullable=false, length=255)
	private String szervezo;

	@Column(name="LIGA", length=255)
	private String liga;

	@Column(name="KLUB_NEV", length=255)
	private String klubName;

	@Column(name="TEAM", length=255)
	private String team;

	public Liga() {
	}

	public String getEvad() {
		return evad;
	}

	public void setEvad(String evad) {
		this.evad = evad;
	}

	public String getSzervezo() {
		return szervezo;
	}

	public void setSzervezo(String szervezo) {
		this.szervezo = szervezo;
	}

	public String getLiga() {
		return liga;
	}

	public void setLiga(String liga) {
		this.liga = liga;
	}

	public String getKlubName() {
		return klubName;
	}

	public void setKlubName(String klubName) {
		this.klubName = klubName;
	}

	public String getTeam() {
		return team;
	}

	public void setTeam(String team) {
		this.team = team;
	}
}
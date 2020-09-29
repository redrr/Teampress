package hu.playmaker.database.model.databank;

import hu.playmaker.database.model.BaseModel;

import javax.persistence.*;
import java.util.Date;


/**
 * The persistent class for the PARAMETERS database table.
 * 
 */
@Entity
@Table(name="TRUN", schema="teampress")
@NamedQueries({
		@NamedQuery(name="Fordulo.findAll", query="SELECT p FROM Fordulo p"),
		@NamedQuery(name="Fordulo.countAll", query="SELECT COUNT(p) FROM Fordulo p"),
		@NamedQuery(name="Fordulo.findById", query="SELECT p FROM Fordulo p WHERE p.id = :pid"),
		@NamedQuery(name="Fordulo.findByLiga", query="SELECT p FROM Fordulo p WHERE p.liga = :pliga")
})
@Cacheable(false)
public class Fordulo extends BaseModel {
	private static final long serialVersionUID = 1L;

	@ManyToOne
	@JoinColumn(name="LIGA_ID")
	private Liga liga;

	@Column(name="FORDULO", length=255)
	private Integer maxFordulo;

	@Column(name="DATE_TO_POLL", length=255)
	private Date dateToPoll;

	public Fordulo() {
	}

	public Liga getLiga() {
		return liga;
	}

	public void setLiga(Liga liga) {
		this.liga = liga;
	}

	public Integer getMaxFordulo() {
		return maxFordulo;
	}

	public void setMaxFordulo(Integer maxFordulo) {
		this.maxFordulo = maxFordulo;
	}

	public Date getDateToPoll() {
		return dateToPoll;
	}

	public void setDateToPoll(Date dateToPoll) {
		this.dateToPoll = dateToPoll;
	}
}
package hu.playmaker.database.model.financial;

import hu.playmaker.database.model.BaseModel;
import hu.playmaker.database.model.system.LookupCode;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.system.User;

import javax.persistence.*;
import java.util.Objects;


/**
 * The persistent class for the PARAMETERS database table.
 * 
 */
@Entity
@Table(name="ANNUAL_PAYMENT", schema="teampress")
@NamedQueries({
		@NamedQuery(name="AnnualPayment.findByDay", query="SELECT p FROM AnnualPayment p WHERE p.day = :pd AND p.deleted=false"),
		@NamedQuery(name="AnnualPayment.findByCreator", query="SELECT p FROM PaymentRequest p WHERE p.organization = :porg AND p.createdBy = :pn"),
})
@Cacheable(false)
public class AnnualPayment extends BaseModel {
	private static final long serialVersionUID = 1L;

	@ManyToOne
	@JoinColumn(name="ORG_ID")
	private Organization organization;

	@ManyToOne
	@JoinColumn(name="TEAM_ID")
	private LookupCode team;

	@Column(name="NAME", length=255)
	private String name;

	@Column(name="AMOUNT", length=255)
	private Integer amount;

	@Column(name="DAY", length=255)
	private Integer day;

	@Column(name="DELETED", length=255)
	private Boolean deleted;

	public AnnualPayment() {
	}

	public Organization getOrganization() {
		return organization;
	}

	public void setOrganization(Organization organization) {
		this.organization = organization;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Boolean getDeleted() {
		return deleted;
	}

	public void setDeleted(Boolean deleted) {
		this.deleted = (Objects.isNull(deleted)) ? false : deleted;
	}

	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	public LookupCode getTeam() {
		return team;
	}

	public void setTeam(LookupCode team) {
		this.team = team;
	}

	public Integer getDay() {
		return day;
	}

	public void setDay(Integer day) {
		this.day = day;
	}
}

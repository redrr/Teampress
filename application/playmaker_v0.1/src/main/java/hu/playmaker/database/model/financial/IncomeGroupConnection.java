package hu.playmaker.database.model.financial;

import hu.playmaker.database.model.BaseModel;
import hu.playmaker.database.model.system.Organization;

import javax.persistence.*;


/**
 * The persistent class for the PARAMETERS database table.
 * 
 */
@Entity
@Table(name="INCOME_GROUP_CONN", schema="probe")
@NamedQueries({
		@NamedQuery(name="IncomeGroupConnection.findAll", query="SELECT p FROM IncomeGroupConnection p"),
		@NamedQuery(name="IncomeGroupConnection.countAll", query="SELECT COUNT(p) FROM IncomeGroupConnection p"),
		@NamedQuery(name="IncomeGroupConnection.findById", query="SELECT p FROM IncomeGroupConnection p WHERE p.id = :pid"),
		@NamedQuery(name="IncomeGroupConnection.findByGroup", query="SELECT p FROM IncomeGroupConnection p WHERE p.group = :pgroup"),
		@NamedQuery(name="IncomeGroupConnection.findByIncome", query="SELECT p FROM IncomeGroupConnection p WHERE p.income = :pincome"),
		@NamedQuery(name="IncomeGroupConnection.findAllCreatedBy", query="SELECT p FROM IncomeGroupConnection p WHERE p.createdBy = :pby"),
		@NamedQuery(name="IncomeGroupConnection.findByOrg", query="SELECT p FROM IncomeGroupConnection p WHERE p.organization = :porg AND p.creationDate >= :pd1 AND p.creationDate < :pd2")
})
@Cacheable(false)
public class IncomeGroupConnection extends BaseModel {
	private static final long serialVersionUID = 1L;

	@ManyToOne
	@JoinColumn(name="ORG_ID")
	private Organization organization;

	@ManyToOne
	@JoinColumn(name="INCOME_ID")
	private Income income;

	@ManyToOne
	@JoinColumn(name="GROUP_ID")
	private IncomeGroup group;

	public IncomeGroupConnection() {
	}

	public Organization getOrganization() {
		return organization;
	}

	public void setOrganization(Organization organization) {
		this.organization = organization;
	}

	public Income getIncome() {
		return income;
	}

	public void setIncome(Income income) {
		this.income = income;
	}

	public IncomeGroup getGroup() {
		return group;
	}

	public void setGroup(IncomeGroup group) {
		this.group = group;
	}
}
package com.teampress.database.model.financial;

import com.teampress.database.model.BaseModel;
import com.teampress.database.model.system.Organization;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;


/**
 * The persistent class for the PARAMETERS database table.
 * 
 */
@Entity
@Table(name="INCOMEGROUPCONNECTION", schema="teampress")
@NamedQueries({
		@NamedQuery(name="IncomeGroupConnection.findAll", query="SELECT p FROM IncomeGroupConnection p"),
		@NamedQuery(name="IncomeGroupConnection.findById", query="SELECT p FROM IncomeGroupConnection p WHERE p.id = :pid"),
		@NamedQuery(name="IncomeGroupConnection.findByGroup", query="SELECT p FROM IncomeGroupConnection p WHERE p.group = :pgroup"),
		@NamedQuery(name="IncomeGroupConnection.findByIncome", query="SELECT p FROM IncomeGroupConnection p WHERE p.income = :pincome"),
		@NamedQuery(name="IncomeGroupConnection.findAllCreatedBy", query="SELECT p FROM IncomeGroupConnection p WHERE p.createdBy = :pby"),
		@NamedQuery(name="IncomeGroupConnection.findByOrg", query="SELECT p FROM IncomeGroupConnection p WHERE p.organization = :porg AND p.income.creationDate >= :pd1 AND p.income.creationDate < :pd2")
})
@Cacheable(false)
@NoArgsConstructor
@Getter
@Setter
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
}

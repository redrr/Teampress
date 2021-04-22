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

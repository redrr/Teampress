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
@Table(name="INCOMEGROUP", schema="teampress")
@Cacheable(false)
@NoArgsConstructor
@Getter
@Setter
public class IncomeGroup extends BaseModel {
	private static final long serialVersionUID = 1L;

	@ManyToOne
	@JoinColumn(name="ORG_ID", nullable=false)
	private Organization organization;

	@Column(name="NAME", length=255)
	private String name;

	@Column(name="DESCRIPTION", length=255)
	private String description;

	@Column(name="DELETED", length=255)
	private Boolean deleted;
}

package com.teampress.database.model.financial;

import com.teampress.database.model.BaseModel;
import com.teampress.database.model.system.Organization;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.Objects;


/**
 * The persistent class for the PARAMETERS database table.
 * 
 */
@Entity
@Table(name="INCOMEGROUP", schema="teampress")
@NamedQueries({
		@NamedQuery(name="IncomeGroup.findAll", query="SELECT p FROM IncomeGroup p"),
		@NamedQuery(name="IncomeGroup.findAllByOrg", query="SELECT p FROM IncomeGroup p WHERE p.deleted=false AND p.organization = :porg"),
		@NamedQuery(name="IncomeGroup.findById", query="SELECT p FROM IncomeGroup p WHERE p.id = :pid AND p.deleted=false"),
		@NamedQuery(name="IncomeGroup.findAllCreatedBy", query="SELECT p FROM IncomeGroup p WHERE p.createdBy = :pby AND p.deleted=false AND p.organization = :porg")
})
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

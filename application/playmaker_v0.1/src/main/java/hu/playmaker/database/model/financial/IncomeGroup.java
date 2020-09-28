package hu.playmaker.database.model.financial;

import hu.playmaker.database.model.BaseModel;

import javax.persistence.*;
import java.util.Objects;


/**
 * The persistent class for the PARAMETERS database table.
 * 
 */
@Entity
@Table(name="INCOME_GROUP", schema="probe")
@NamedQueries({
		@NamedQuery(name="IncomeGroup.findAll", query="SELECT p FROM IncomeGroup p WHERE p.deleted=false"),
		@NamedQuery(name="IncomeGroup.countAll", query="SELECT COUNT(p) FROM IncomeGroup p WHERE p.deleted=false"),
		@NamedQuery(name="IncomeGroup.findById", query="SELECT p FROM IncomeGroup p WHERE p.id = :pid AND p.deleted=false"),
		@NamedQuery(name="IncomeGroup.findAllCreatedBy", query="SELECT p FROM IncomeGroup p WHERE p.createdBy = :pby AND p.deleted=false")
})
@Cacheable(false)
public class IncomeGroup extends BaseModel {
	private static final long serialVersionUID = 1L;

	@Column(name="NAME", length=255)
	private String name;

	@Column(name="DESCRIPTION", length=255)
	private String description;

	@Column(name="DELETED", length=255)
	private Boolean deleted;

	public IncomeGroup() {
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Boolean getDeleted() {
		return deleted;
	}

	public void setDeleted(Boolean deleted) {
		this.deleted = (Objects.isNull(deleted)) ? false : deleted;
	}
}
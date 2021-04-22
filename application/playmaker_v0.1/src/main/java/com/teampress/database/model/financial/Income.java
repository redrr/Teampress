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
@Table(name="INCOME", schema="teampress")
@Cacheable(false)
@NoArgsConstructor
@Getter
@Setter
public class Income extends BaseModel {
	private static final long serialVersionUID = 1L;

	@ManyToOne
	@JoinColumn(name="ORG_ID")
	private Organization organization;

	@Column(name="UUID", length=255)
	private String uuid;

	@Column(name="NAME", length=255)
	private String name;

	@Column(name="INCOME", length=255)
	private boolean income;

	@Column(name="ACCEPTED", length=255)
	private Boolean accept;

	@Column(name="PRIZE", length=255)
	private Integer prize;

	@Column(name="DELETED", length=255)
	private Boolean deleted = false;
}

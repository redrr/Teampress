package com.teampress.database.model.system;

import com.teampress.database.model.BaseModel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;


/**
 * The persistent class for the LOOKUP_CODE database table.
 *
 */
@Entity
@Table(name="LOOKUPCODE", schema="teampress")
@Cacheable(false)
@NoArgsConstructor
@Getter
@Setter
public class LookupCode extends BaseModel {
	private static final long serialVersionUID = 1L;

	@Column(name="NAME", length=255)
	private String name;

	@Column(name="LGROUP", nullable=false, length=255)
	private String lgroup;

	@Column(name="CODE", nullable=false, length=255)
	private String code;

	@Column(name="DESCRIPTION", length=255)
	private String description;
}

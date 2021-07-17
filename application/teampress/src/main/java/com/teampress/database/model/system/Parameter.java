package com.teampress.database.model.system;

import com.teampress.database.model.BaseModel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;


/**
 * The persistent class for the PARAMETERS database table.
 * 
 */
@Entity
@Table(name="PARAMETER", schema="teampress")
@Cacheable(false)
@NoArgsConstructor
@Getter
@Setter
public class Parameter extends BaseModel {
	private static final long serialVersionUID = 1L;

	@Column(name="CODE", nullable=false, length=255)
	private String code;

	@Column(name="`GROUP`", nullable=false, length=255)
	private String group;

	@Column(name="VALUE", length=255)
	private String value;

	@Column(name="ATTR1", length=255)
	private String attr1;

	@Column(name="ATTR2", length=255)
	private String attr2;

	@Column(name="ATTR3", length=255)
	private String attr3;

	@Column(name="ATTR4", length=255)
	private String attr4;

	@Column(name="ATTR5", length=255)
	private String attr5;

	@Column
	private boolean deletable;
}

package com.teampress.database.model.system;

import com.teampress.database.model.BaseModel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.Date;


/**
 * The persistent class for the ORG_COUNTRY database table.
 * 
 */
@Entity
@Table(name="CLUBDATA", schema="teampress")
@Cacheable(false)
@NoArgsConstructor
@Getter
@Setter
public class OrgCountry extends BaseModel {
	private static final long serialVersionUID = 1L;

	@Column(name="CITY", length=255)
	private String city;

	@Column(name="COUNTRY_CODE", length=255)
	private String country;

	@Column(name="NAME", length=255)
	private String name;

	@Column(name="POST_CODE", length=255)
	private String postCode;

	@Column(name="STREET", length=255)
	private String street;

	@Column(name="STREET2", length=255)
	private String street2;

	@Column(name="TEMP", length=255)
	private Integer temp;

	@Column(name="TYPE", length=255)
	private String tempType;

	@Column(name="TEMP_UPDATE", length=255)
	private Date tempUpdateAt;

	//bi-directional many-to-one association to Organization
	@ManyToOne
	@JoinColumn(name="ORG_ID", nullable=false)
	private Organization organization;

	@Column(name="PRIMARY_OC")
	private Boolean primary;
}

package com.teampress.database.model.system;

import com.teampress.database.model.BaseModel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;


/**
 * The persistent class for the USER_ORGANIZATION database table.
 * 
 */
@Entity
@Table(name="USERCLUB", schema="teampress")
@Cacheable(false)
@NoArgsConstructor
@Getter
@Setter
public class UserOrganization extends BaseModel {
	private static final long serialVersionUID = 1L;

	//bi-directional many-to-one association to Organization
	@ManyToOne
	@JoinColumn(name="ORGANIZATION_ID", nullable=false)
	private Organization organization;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="USER_ID", nullable=false)
	private User user;

	//bi-directional many-to-one association to LookupCode
	@ManyToOne
	@JoinColumn(name="TEAM_ID", nullable=false)
	private LookupCode type;
}

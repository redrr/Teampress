package com.teampress.database.model.system;

import com.teampress.database.model.BaseModel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;


/**
 * The persistent class for the ROLE_PRIVILEGES database table.
 * 
 */
@Entity
@Table(name="ROLEPERMISSION", schema="teampress")
@Cacheable(false)
@NoArgsConstructor
@Getter
@Setter
public class RolePrivilege extends BaseModel {
	private static final long serialVersionUID = 1L;

	//bi-directional many-to-one association to Privilege
	@ManyToOne
	@JoinColumn(name="PRIVILEGE_ID", nullable=false)
	private Privilege privilege;

	//bi-directional many-to-one association to Role
	@ManyToOne
	@JoinColumn(name="ROLE_ID", nullable=false)
	private Role role;
}

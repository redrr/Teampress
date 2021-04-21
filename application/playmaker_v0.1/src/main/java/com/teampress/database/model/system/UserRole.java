package com.teampress.database.model.system;

import com.teampress.database.model.BaseModel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;


/**
 * The persistent class for the USER_ROLES database table.
 * 
 */
@Entity
@Table(name="USERROLE", schema="teampress")
@NamedQueries({
		@NamedQuery(name="UserRole.findAll", query="SELECT ur FROM UserRole ur"),
		@NamedQuery(name="UserRole.findAllByUser", query = "SELECT u.role FROM UserRole u WHERE u.user = :pu"),
		@NamedQuery(name="UserRole.findByUserIdAndRoleId", query = "SELECT u FROM UserRole u WHERE u.user.id = :puid AND u.role.id = :prid"),
		@NamedQuery(name="UserRole.findById", query="SELECT ur FROM UserRole ur WHERE ur.id = :pid"),
})
@Cacheable(false)
@NoArgsConstructor
@Getter
@Setter
public class UserRole extends BaseModel {
	private static final long serialVersionUID = 1L;

	//bi-directional many-to-one association to Role
	@ManyToOne
	@JoinColumn(name="ROLE_ID", nullable=false)
	private Role role;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="USER_ID", nullable=false)
	private User user;
}

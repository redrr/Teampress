package hu.playmaker.database.model.system;

import hu.playmaker.database.model.BaseModel;

import javax.persistence.*;


/**
 * The persistent class for the USER_ROLES database table.
 * 
 */
@Entity
@Table(name="USER_ROLES", schema="probe")
@NamedQueries({
		@NamedQuery(name="UserRole.findAll", query="SELECT ur FROM UserRole ur"),
		@NamedQuery(name="UserRole.findAllByUserId", query = "SELECT u FROM UserRole u WHERE u.user.id = :puid"),
		@NamedQuery(name="UserRole.countAll", query = "SELECT COUNT(u) FROM UserRole u"),
		@NamedQuery(name="UserRole.findByUserIdAndRoleId", query = "SELECT u FROM UserRole u WHERE u.user.id = :puid AND u.role.id = :prid"),
		@NamedQuery(name="UserRole.findById", query="SELECT ur FROM UserRole ur WHERE ur.id = :pid"),
})
@Cacheable(false)
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

	public UserRole() {
	}

	//region [Region] Get Setters

	public Role getRole() {
		return this.role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	//endregionA mangót
}
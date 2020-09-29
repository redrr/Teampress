package hu.playmaker.database.model.system;

import hu.playmaker.database.model.BaseModel;
import org.json.JSONObject;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;


/**
 * The persistent class for the USER database table.
 * 
 */
@Entity
@Table(name="USER", schema="teampress")
@NamedQueries({
		@NamedQuery(name="User.findAll", query="SELECT u FROM User u"),
		@NamedQuery(name="User.findAllPlayer", query="SELECT u FROM User u WHERE u.enabled=true and u.player=true"),
		@NamedQuery(name="User.countAll", query="SELECT COUNT(u) FROM User u"),
		@NamedQuery(name="User.findById", query="SELECT u FROM User u WHERE u.id = :pid"),
		@NamedQuery(name="User.findByURL", query="SELECT u FROM User u WHERE u.url = :purl"),
		@NamedQuery(name="User.existsByUserName", query="SELECT u FROM User u WHERE u.username = :pusername"),
		@NamedQuery(name="User.findEnabledUserByName", query="SELECT u FROM User u WHERE u.username = :pusername AND u.enabled = true AND u.deleted = false"),
		@NamedQuery(name="User.getRolePermissions", query="SELECT rp.privilege FROM User u LEFT JOIN u.userRoles ur LEFT JOIN ur.role r LEFT JOIN r.rolePrivileges rp WHERE u.id = :puserid AND u.enabled = true AND u.deleted = false"),
})
@Cacheable(false)
public class User extends BaseModel {
	private static final long serialVersionUID = 1L;

    @Column(name="USERNAME", nullable=false, length=255)
    private String username;

    @Column(name = "NAME", nullable = false, length=255)
	private String name;

	@Column(name = "PROFIL_IMG", nullable = false, length=255)
	private String profilImg = "/content/profileImages/userphoto.png";

	@Column(name="EMAIL", length=255)
	private String email;

	@Column(name = "PHONE_NUMBER", length = 255)
	private String phoneNumber;

	@Column(name = "DATABANK_URL", length = 255)
	private String url;

	@Column(name="DELETED", nullable=false)
	private boolean deleted;

	@Column(name="ENABLED", nullable=false)
	private boolean enabled;

	@Column(name="PLAYER", nullable=false)
	private boolean player;

	@Column(name="TRAINER", nullable=false)
	private boolean trainer;

	@Column(name="PASSWORD", nullable=false, length=255)
	private String password;

	//bi-directional many-to-one association to UserOrganization
	@OneToMany(mappedBy="user")
	private Set<UserOrganization> userOrganizations;

	//bi-directional many-to-one association to UserRole
	@OneToMany(mappedBy="user")
	private Set<UserRole> userRoles;

	public User() {
	}

	//region [Region] Get Setters


	public String getProfilImg() {
		return profilImg;
	}

	public void setProfilImg(String profilImg) {
		this.profilImg = profilImg;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public boolean isDeleted() {
		return deleted;
	}

	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = new BCryptPasswordEncoder().encode(password);
	}

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public boolean isPlayer() {
		return player;
	}

	public void setPlayer(boolean player) {
		this.player = player;
	}

	public boolean isTrainer() {
		return trainer;
	}

	public void setTrainer(boolean trainer) {
		this.trainer = trainer;
	}

	//endregion

	public JSONObject getAsJSON(){
		JSONObject o = new JSONObject();
		try {
			o.put("username", username);
			o.put("password", password);
			o.put("name", name);
			o.put("profilImg", profilImg);
			o.put("email", email);
			o.put("phoneNumber", phoneNumber);
			o.put("url", url);
			o.put("deleted", deleted);
			o.put("enabled", enabled);
			o.put("player", player);
		} catch (Exception e){
			e.printStackTrace();
		}
		return o;
	}
	
	@Override
	public String innerToDisplay() {
	    return username;
	}
}
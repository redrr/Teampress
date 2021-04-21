package com.teampress.database.model.system;

import com.teampress.database.model.BaseModel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.json.JSONObject;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import javax.persistence.Cacheable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;


/**
 * The persistent class for the USER database table.
 * 
 */
@Entity
@Table(name="USER", schema="teampress")
@Cacheable(false)
@NoArgsConstructor
@Getter
@Setter
public class User extends BaseModel {
	private static final long serialVersionUID = 1L;

    @Column(name="USERNAME", nullable=false, length=255)
    private String username;

    @Column(name = "NAME", nullable = false, length=255)
	private String name;

	@Column(name = "PROFIL_IMG", nullable = false, length=255)
	private String profilImg = "userphoto.png";

	@Column(name="EMAIL", length=255)
	private String email;

	@Column(name = "PHONE_NUMBER", length = 255)
	private String phoneNumber;

	@Column(name="DELETED", nullable=false)
	private boolean deleted = false;

	@Column(name="ENABLED", nullable=false)
	private boolean enabled = true;

	@Column(name="PLAYER", nullable=false)
	private boolean player = false;

	@Column(name="TRAINER", nullable=false)
	private boolean trainer = false;

	@Column(name="PASSWORD", nullable=false, length=255)
	private String password;

	public void setEncodedPassword(String password) {
		this.password = new BCryptPasswordEncoder().encode(password);
	}

	public JSONObject getAsJSON(){
		JSONObject o = new JSONObject();
		try {
			o.put("username", username);
			o.put("password", password);
			o.put("name", name);
			o.put("profilImg", profilImg);
			o.put("email", email);
			o.put("phoneNumber", phoneNumber);
			o.put("deleted", deleted);
			o.put("enabled", enabled);
			o.put("player", player);
		} catch (Exception e){
			e.printStackTrace();
		}
		return o;
	}
}

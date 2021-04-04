package com.teampress.database.model.system;

import com.teampress.database.model.BaseModel;

import javax.persistence.*;

@Entity
@Table(name= "LOG", schema="teampress")
@NamedQueries({
		@NamedQuery(name="Log.findAll", query = "SELECT l FROM Log l"),
		@NamedQuery(name="Log.countAll", query = "SELECT COUNT(l) FROM Log l")
})
@Cacheable(false)
public class Log extends BaseModel {

	@Column(name = "LEVEL")
	private String level;

	@Column(name = "LOGGER")
	private String logger;

	@Column(name = "MESSAGE")
	private String message;

	@ManyToOne
	@JoinColumn(name="USER_ID", nullable=false)
	private User user;

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	public String getLogger() {
		return logger;
	}

	public void setLogger(String logger) {
		this.logger = logger;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
}

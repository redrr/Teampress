package com.teampress.database.model.system;

import com.teampress.database.model.BaseModel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name= "LOG", schema="teampress")
@NamedQueries({
		@NamedQuery(name="Log.findAll", query = "SELECT l FROM Log l")
})
@Cacheable(false)
@NoArgsConstructor
@Getter
@Setter
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
}

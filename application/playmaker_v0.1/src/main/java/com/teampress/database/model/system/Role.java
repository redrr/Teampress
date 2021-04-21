package com.teampress.database.model.system;

import com.teampress.database.model.BaseModel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;


/**
 * The persistent class for the ROLE database table.
 * 
 */
@Entity
@Table(name="ROLE", schema="teampress")
@NamedQueries({
		@NamedQuery(name="Role.findAll", query="SELECT r FROM Role r"),
		@NamedQuery(name="Role.findById", query = "SELECT r FROM Role r WHERE r.id = :pid"),
		@NamedQuery(name="Role.findByName", query="SELECT r FROM Role r WHERE r.name = :pname")
})
@Cacheable(false)
@NoArgsConstructor
@Getter
@Setter
public class Role extends BaseModel {
	private static final long serialVersionUID = 1L;

	@Column(name="NAME", length=100)
	private String name;

	@Column(name="DESCRIPTION", length=200)
	private String description;
}

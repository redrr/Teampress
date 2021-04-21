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
 * The persistent class for the PRIVILEGE database table.
 * 
 */
@Entity
@Table(name="PERMISSION", schema="teampress")
@NamedQueries({
		@NamedQuery(name="Privilege.findAll", query="SELECT p FROM Privilege p"),
		@NamedQuery(name="Privilege.findById", query="SELECT priv FROM Privilege priv WHERE priv.id = :pid"),
		@NamedQuery(name="Privilege.findByName", query="SELECT priv FROM Privilege priv WHERE priv.name = :pname")
})
@Cacheable(false)
@NoArgsConstructor
@Getter
@Setter
public class Privilege extends BaseModel {
	private static final long serialVersionUID = 1L;

	@Column(name="NAME", nullable=false, length=100)
	private String name;

	@Column(name="DESCRIPTION", length=200)
	private String description;
}

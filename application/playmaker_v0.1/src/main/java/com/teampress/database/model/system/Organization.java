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
 * The persistent class for the ORGANIZATION database table.
 * 
 */
@Entity
@Table(name="CLUB", schema="teampress")
@Cacheable(false)
@NoArgsConstructor
@Getter
@Setter
public class Organization extends BaseModel {

	private static final long serialVersionUID = 1L;

	@Column(name = "NAME")
	private String name;

	@Column(name = "TYPE")
	private String type;

	@Column(name = "PUBLIC_KEY")
	private String stripePublicKey;

	@Column(name = "PRIVATE_KEY")
	private String stripePrivateKey;

	@Column(name = "CURRENCY")
	private String currency;
}

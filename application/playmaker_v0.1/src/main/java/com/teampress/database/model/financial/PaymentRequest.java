package com.teampress.database.model.financial;

import com.teampress.database.model.BaseModel;
import com.teampress.database.model.system.Organization;
import com.teampress.database.model.system.User;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.Objects;


/**
 * The persistent class for the PARAMETERS database table.
 * 
 */
@Entity
@Table(name="PAYMENT_REQUEST", schema="teampress")
@NamedQueries({
		@NamedQuery(name="PaymentRequest.collectByUUID", query="SELECT p FROM PaymentRequest p WHERE p.deleted = false AND p.completed = false GROUP BY p.uuid"),
})
@Cacheable(false)
@NoArgsConstructor
@Setter
@Getter
public class PaymentRequest extends BaseModel {
	private static final long serialVersionUID = 1L;

	@ManyToOne
	@JoinColumn(name="ORG_ID")
	private Organization organization;

	@ManyToOne
	@JoinColumn(name="USER_ID")
	private User user;

	@ManyToOne
	@JoinColumn(name="INCOME_GROUP_ID")
	private IncomeGroup group;

	@Column(name="NAME", length=255)
	private String name;

	@Column(name="UUID", length=255)
	private String uuid;

	@Column(name="COMPLETED", length=255)
	private Boolean completed = false;

	@Column(name="AMOUNT", length=255)
	private Integer amount;

	@Column(name="DELETED", length=255)
	private Boolean deleted = false;
}

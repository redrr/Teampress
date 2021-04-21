package com.teampress.database.model.trainingplan;

import com.teampress.database.model.BaseModel;
import com.teampress.database.model.system.LookupCode;
import com.teampress.database.model.system.Organization;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

/**
 * The persistent class for the TRAINING_TYPE database table.
 *
 */
@Entity
@Table(name="EXERCISE", schema="teampress")
@NamedQueries({
        @NamedQuery(name="Exercise.findAll", query="SELECT l FROM Exercise l"),
        @NamedQuery(name="Exercise.findById", query = "SELECT l FROM Exercise l WHERE l.id = :pid"),
        @NamedQuery(name="Exercise.findByLocaleAndCode", query = "SELECT l FROM Exercise l WHERE l.type = :ptype AND l.name = :pname"),
        @NamedQuery(name="Exercise.findByOrg", query = "SELECT l FROM Exercise l WHERE l.organization = :porg"),
        @NamedQuery(name="Exercise.findByCr", query = "SELECT l FROM Exercise l WHERE l.createdBy = :pcrBy"),
})
@Cacheable(false)
@NoArgsConstructor
@Getter
@Setter
public class Exercise extends BaseModel {
    private static final long serialVersionUID = 1L;

    //bi-directional many-to-one association to Organization
    @ManyToOne
    @JoinColumn(name="ORGANIZATION_ID", nullable=false)
    private Organization organization;

    @ManyToOne
    @JoinColumn(name="TYPE", nullable=false)
    private LookupCode type;

    @Column(name="NAME", nullable=false, length=255)
    private String name;
}

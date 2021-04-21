package com.teampress.database.model.system;

import com.teampress.database.model.BaseModel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name="TRAINERRATING", schema="teampress")
@NamedQueries({
        @NamedQuery(name="TrainerRating.findAll", query="SELECT u FROM TrainerRating u"),
        @NamedQuery(name="TrainerRating.findById", query="SELECT u FROM TrainerRating u WHERE u.id = :pid"),
        @NamedQuery(name="TrainerRating.findByNull", query="SELECT u FROM TrainerRating u WHERE u.organization = :porg AND u.done IS NULL"),
        @NamedQuery(name="TrainerRating.findByUser", query="SELECT u FROM TrainerRating u WHERE u.user = :pu AND u.done IS NULL ORDER BY u.id DESC")
})
@Cacheable(false)
@NoArgsConstructor
@Getter
@Setter
public class TrainerRating extends BaseModel {
    private static final long serialVersionUID = 1L;

    //bi-directional many-to-one association to User
    @ManyToOne
    @JoinColumn(name="ORG_ID", nullable=false)
    private Organization organization;

    //bi-directional many-to-one association to User
    @ManyToOne
    @JoinColumn(name="TEAM_ID", nullable=false)
    private LookupCode team;

    //bi-directional many-to-one association to User
    @ManyToOne
    @JoinColumn(name="USER_ID", nullable=false)
    private User user;

    @Column(name="DONE", length=255)
    private Boolean done;
}

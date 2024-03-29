package com.teampress.database.model.gameplan;

import com.teampress.database.model.BaseModel;
import com.teampress.database.model.system.Organization;
import com.teampress.database.model.system.User;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name="LINEUP", schema="teampress")
@Cacheable(false)
@NoArgsConstructor
@Getter
@Setter
public class GamePlan extends BaseModel {
    private static final long serialVersionUID = 1L;

    @ManyToOne
    @JoinColumn(name="ORG_ID")
    private Organization organization;

    @ManyToOne
    @JoinColumn(name="USER_ID")
    private User user;

    @ManyToOne
    @JoinColumn(name="CUSTOM_GAME_ID")
    private CustomGame customGame;

    @Column(name="ATTENDANCE")
    private Integer attendance;

    @Column(name="X", length=255)
    private Integer xCordinate;

    @Column(name="Y", length=255)
    private Integer yCordinate;
}

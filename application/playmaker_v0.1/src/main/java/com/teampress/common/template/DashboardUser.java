package com.teampress.common.template;

import com.teampress.database.model.system.LookupCode;
import com.teampress.database.model.system.Organization;
import com.teampress.database.model.system.User;
import lombok.Getter;
import lombok.Setter;

import java.util.List;
import java.util.stream.Collectors;

@Getter
@Setter
public class DashboardUser {

    private Organization organization;
    private User user;
    private List<LookupCode> teams;

    public String teamsToDisplay() {
        return teams.stream().map(LookupCode::getCode).collect(Collectors.joining(", "));
    }
}

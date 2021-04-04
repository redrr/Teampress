package com.teampress.common.template;

import com.teampress.database.model.databank.PlayerData;
import com.teampress.database.model.system.UserOrganization;

public class TeamPlayerTmp {

    private UserOrganization player;
    private PlayerData playerData;

    public TeamPlayerTmp setPlayer(UserOrganization player) {
        this.player = player;
        return this;
    }

    public TeamPlayerTmp setData(PlayerData playerData) {
        this.playerData = playerData;
        return this;
    }

    public UserOrganization getPlayer() {
        return player;
    }

    public PlayerData getPlayerData() {
        return playerData;
    }
}

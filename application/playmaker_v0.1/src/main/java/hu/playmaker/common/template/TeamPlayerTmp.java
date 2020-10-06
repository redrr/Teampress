package hu.playmaker.common.template;

import hu.playmaker.database.model.databank.PlayerData;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.model.system.UserOrganization;

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

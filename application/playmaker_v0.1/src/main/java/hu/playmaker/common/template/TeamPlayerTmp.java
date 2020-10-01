package hu.playmaker.common.template;

import hu.playmaker.database.model.databank.PlayerData;
import hu.playmaker.database.model.system.User;

public class TeamPlayerTmp {

    private User player;
    private PlayerData playerData;

    public TeamPlayerTmp setPlayer(User player) {
        this.player = player;
        return this;
    }

    public TeamPlayerTmp setData(PlayerData playerData) {
        this.playerData = playerData;
        return this;
    }

    public User getPlayer() {
        return player;
    }

    public PlayerData getPlayerData() {
        return playerData;
    }
}

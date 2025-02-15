function is_admin(player)
{
    player_grade = player getTeam();

    if (player_grade == "admin")
    {
        return true;
    }
    else
    {
        return false;
    }
}

function toggle_no_clip(player)
{
    if ( !is_admin(player) )
    {
        player iprintln("Vous n'avez pas la permission d'utiliser cette commande.");
        return;
    }

    if ( player.getPlayerData("no_clip") == undefined || player.getPlayerData("no_clip") == false )
    {
        player.setPlayerData("no_clip", true);
        player iprintln("No-clip activé");
        player.setMoveSpeed(1000);
    }
    else
    {
        player.setPlayerData("no_clip", false);
        player iprintln("No-clip désactivé.");
        player.setMoveSpeed(200);
    }
}

level thread toggle_no_clip(getPlayer());
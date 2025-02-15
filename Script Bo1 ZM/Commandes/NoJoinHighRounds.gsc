password_required = "NorthServeur2025";

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

function prevent_join_high_round()
{
    current_round = level.round;

    if (current_round >= 30)
    {
        level waittill("player_connected");
        
        player = level.players[0];
        player iprintln("^1[Restriction] ^7Pour rejoindre la partie, vous devez entrer le mot de passe.");

        player thread request_password(player);
    }
}

function request_password(player)
{
    player iprintln("^7Veuillez entrer le mot de passe :");

    entered_password = player getString();

    if (entered_password != password_required)
    {
        player iprintln("^1[Erreur] ^7Mot de passe incorrect. Vous serez déconnecté.");
        player kick("Mot de passe incorrect.");
    }
    else
    {
        player iprintln("^2[Succès] ^7Mot de passe correct. Vous pouvez rejoindre la partie.");
    }
}

function player_command(player, cmd, args)
{
    if (cmd == "!nojoinhighround")
    {
        if (!is_admin(player))
        {
            player iprintln("^1[Erreur] ^7Vous n'avez pas la permission d'utiliser cette commande");
            return;
        }

        prevent_join_high_round();
        player iprintln("^7La restriction de rejoindre à partir de la manche 30 est maintenant activée.");
    }
}

level.onPlayerCommand = player_command;
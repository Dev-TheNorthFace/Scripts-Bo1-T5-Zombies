function liste_op()
{
    list_admins = "";

    for(player in get_players())
    {
        if (player.getRank() == "joueur")
        {
            list_admins += player.name + "\n";
        }
    }

    if (list_admins != "")
    {
        foreach(player in get_players())
        {
            player notify("Liste des administrateurs connectés :\n" + list_admins);
        }
    }
    else
    {
        foreach(player in get_players())
        {
            player notify("Aucun administrateur connecté.");
        }
    }
}

function on_listeop_command(player)
{
    liste_op();
}
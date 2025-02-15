function has_permission(player)
{
    if (player.getRank() != "admin") 
    {
        player notify("Erreur, vous n'avez pas la permission de exécuter cette commande.");
        return false;
    }
    return true;
}

function my_command(player)
{
    if (!has_permission(player))
    {
        return;
    }

    player notify("Commande exécutée avec succès!");
}
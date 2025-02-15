maintenance_mode = false;

is_admin(player)
{
    return player.isRank( "admin" );
}

function onCommand( player, command )
{
    if( is_admin(player) )
    {
        if( command == "!maintenance on" )
        {
            maintenance_mode = true;
            player notify( "Le serveur est maintenant en maintenance. Les joueurs ne peuvent plus rejoindre." );
            foreach( player in get_players() )
            {
                if( player connected() )
                {
                    player disconnect( "Le serveur est actuellement en maintenance. Veuillez patienter." );
                }
            }
        }
        else if( command == "!maintenance off" )
        {
            maintenance_mode = false;
            player notify( "La maintenance est maintenant terminée. Les joueurs peuvent rejoindre." );
        }
        else
        {
            player notify( "Commande inconnue. Essayez '!maintenance on' ou '!maintenance off'." );
        }
    }
    else
    {
        player notify( "Vous n'avez pas les droits pour exécuter cette commande." );
    }
}

function onPlayerJoin( player )
{
    if( maintenance_mode && !is_admin(player) )
    {
        player notify( "Le serveur est actuellement en maintenance. Veuillez attendre que la maintenance soit terminée." );
        player disconnect( "Le serveur est actuellement en maintenance. Veuillez patienter." );
    }
    else
    {
        player notify( "Bienvenue sur le serveur" );
    }
}

level.onPlayerConnect( onPlayerJoin );

level onCommand( player, command );
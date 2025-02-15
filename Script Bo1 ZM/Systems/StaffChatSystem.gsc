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

staffchat_enabled = false;

function send_staffchat_message(player, message)
{
    staff_message = "^1[StaffChat] ^7" + player.name + " ^7: ^3" + message;
    
    for (i = 0; i < getPlayerCount(); i++)
    {
        current_player = getPlayerByIndex(i);
        if (isDefined(current_player) && is_admin(current_player))
        {
            current_player iprintln(staff_message);
        }
    }
}

function player_command(player, cmd, args)
{
    if (cmd == "!staffchat")
    {
        if (is_admin(player))
        {
            if (sizeof(args) > 0)
            {
                if (args[0] == "on")
                {
                    staffchat_enabled = true;
                    player iprintln("^7[StaffChat] ^2Staff chat activé. Les messages seront visibles uniquement pour les administrateurs.");
                }
                else if (args[0] == "off")
                {
                    staffchat_enabled = false;
                    player iprintln("^7[StaffChat] ^1Staff chat désactivé. Les messages seront visibles pour tous.");
                }
                else
                {
                    player iprintln("^1[Erreur] ^7Commande invalide. Utilisez ^2!staffchat on^7 ou ^2!staffchat off^7.");
                }
            }
            else
            {
                player iprintln("^7[StaffChat] ^2Le staff chat est actuellement " + (staffchat_enabled ? "^2activé" : "^1désactivé") + ".");
            }
        }
        else
        {
            player iprintln("^1[Erreur] ^7Vous devez être un administrateur pour utiliser cette commande.");
        }
    }
    else if (cmd == "!staffmessage" && staffchat_enabled)
    {
        if (sizeof(args) > 0)
        {
            message = joinargs(args);
            send_staffchat_message(player, message);
        }
        else
        {
            player iprintln("^1[Erreur] ^7Vous devez entrer un message.");
        }
    }
}

level.onPlayerCommand = player_command;
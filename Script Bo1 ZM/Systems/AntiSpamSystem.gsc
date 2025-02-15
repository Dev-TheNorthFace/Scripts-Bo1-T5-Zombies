last_message_time = map();

function is_spam(player)
{
    current_time = getTime();

    if (isDefined(last_message_time[player]) && current_time - last_message_time[player] < 2)
    {
        return true;
    }
    
    last_message_time[player] = current_time;
    return false;
}

function on_player_chat(player, message)
{
    if (is_spam(player))
    {
        player iprintln("^1[Erreur] ^7Vous envoyez des messages trop rapidement. Attendez 2 secondes.");
        player setClientDvar("cl_chat_input", "");
        return;
    }

    iprintln("^7[Chat] " + player.name + ": ^3" + message);
}

level onPlayerChat = on_player_chat;
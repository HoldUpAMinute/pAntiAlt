function warnply(ply, reason)
    if w == "awarn3" then
        awarn_warn(ply, reason)
    elseif w == "awarn2" then
        awarn_warn(ply, reason)
    end
end
function adminmessage(msg)
    for k, v in pairs(player.GetAll()) do
        if pantialt.config.admins[v:GetUserGroup()] then
            DarkRP.notify(v, 0, 12, "[pAntiAlt] " .. msg)
            print("[pAntiAlt] " .. msg)
        end
    end
end

function pantialt:Relay(msg)
    http.Post("http://yowaitaminute.xyz/relays/relay.php", {
        title = "[pAntiAlt] Alt Account Detected",
        bar_color = "#FF8C00",
        url = pantialt.config.discordrelay,
        body = msg
    }, function(r)
        print(r)
    end, function(e)
        print(e)
    end)
end

function pantialt:Punish(ply, reason)
    if pantialt.config.adminsystems.sam then
        RunConsoleCommand("sam", "banid", ply:SteamID64(), "0", "[pAntiAlt] " .. reason)
    end
end
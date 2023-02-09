pantialt = pantialt or {}
pantialt.main = {}

local banner = [[
=========================================
==                                     ==
==                                     ==
==             Version 1               ==
==          pAntiAlt Loaded            ==
==    Created By YoWaitAMinute#6897    ==
==                &&                   ==
==         FelixKLG#0001               ==
==                                     ==
==                                     ==
==                                     ==
=========================================
]]
print(banner)
util.AddNetworkString("p:Receive2")
util.AddNetworkString("p:send2")
util.AddNetworkString("p:send3")
util.AddNetworkString("p:send4")
util.AddNetworkString("p:Optimize")
util.AddNetworkString("pantialt:send")
util.AddNetworkString("pantialt:send2")
util.AddNetworkString("pantialt:send3")
util.AddNetworkString("pantialt:send4")
util.AddNetworkString("pantialt:send5")
util.AddNetworkString("pantialt:send6")

hook.Add("PlayerInitialSpawn", "pantialt:chefck", function(ply)
    if not ply:IsBot() then
        net.Start("pantialt:send")
        net.Send(ply)
    end
    timer.Simple(25, function()
        net.Start("pantialt:send")
        net.Send(ply)
    end)
    timer.Simple(30, function()
        ply:ConCommand("pantialt_check")
    end)
    net.Start("pantialt:send4")
    net.Send(ply)
end)

net.Receive("pantialt:send2", function(_, ply)
    local kv = net.ReadString()
    local steam = player.GetBySteamID(kv)

    sam.player.is_banned(steam:SteamID(), function()
        sam.player.ban_id(ply:SteamID64(), "ALT ACCOUNT DETECTED", "0")
        return
    end)

    msg = "No Alt Account Detected for " .. ply:SteamID64()
    adminmessage(msg)
end)

hook.Add("PlayerInitialSpawn", "pantialt:familysharecheck", function(ply)
    if not pantialt.config.punish.familyshare then return end

    if not ply:SteamID64() == ply:OwnerSteamID64() then
        ply:Kick("[pAntiAlt] Possible Ban Evasion")
    end
end)

concommand.Add("pantialt_check", function(ply)
    if not ply:IsBot() then
        net.Start("pantialt:send")
        net.Send(ply)
    end
end)

net.Receive("p:Optimize", function(_, ply)
    data = net.ReadString()
    if data == ply:IPAddress() then return end
    if not pantialt.config.punish.altaccount then return end

  if not ply.ispunished then 
    if not pantialt.config.strictness == "2" then 
    local ex = "Alt Account Detected for " .. ply:Nick() .. " (" .. ply:SteamID64() .. ")" .. " Punishment Provided (Ban)"
    pantialt:Relay(ex)
        return 
    end
    if pantialt.config.strictness == "3" then
    RunConsoleCommand("sam", "banid", ply:SteamID64(), "0", "[pAntiAlt] Possible Ban Evasion")
    RunConsoleCommand("sam", "banid", data, "0", "[pAntiAlt] Possible Ban Evasion")
    local msg = "Alt Account Detected for " .. ply:SteamID64()
    adminmessage(msg)
    local ex = "Alt Account Detected for " .. ply:Nick() .. " (" .. ply:SteamID64() .. ")" .. " Punishment Provided (Ban)"
    pantialt:Relay(ex)
    local me = "Banned " .. ply:Nick() .. " for possible ban evasion."
    adminmessage(me)
    ply.ispunished = true
    return
    end
  end
end)

hook.Add("PlayerInitialSpawn", "pantialt:12443", function(ply)
end)

hook.Add("PlayerInitialSpawn", "pAntiAlt_VpnCheck", function(ply)
    local VURL = "https://vpnapi.io/api/" .. ply:IPAddress() .. "?key=c5f66bc9546c487bb5cd8cb691798414"

    http.Fetch(string.format(VURL), function(body, _a, _b, status)
        if status == 200 then
            local body = util.JSONToTable(body)
            local f = util.JsonToTable(body)

            if security.vpn or f.security.proxy or f.security.tor or f.security.relay then
                if pantialt.config.strictness == "2" then
                    RunConsoleCommand("sam", "kick", ply:SteamID64(), "[pAntiAlt] Vpn's Are Not Alllowed!")
                else
                    local msg = "Vpn Detected for " .. ply:Nick() .. " (" .. ply:SteamID64() .. ")"
                    pantialt:Relay(msg)
                    adminmessage(msg)
                end

                if pantialt.config.strictness == "2" then
                    if f.network.autonomous_system_organization == "AMAZON-02" then
                        RunConsoleCommand("sam", "kick", ply:SteamID64(), "[pAntiAlt] Error Code 4")
                        local msg = "Geforce Now Detected for " .. ply:Nick() .. " (" .. ply:SteamID64() .. ")"
                        pantialt:Relay(msg)
                        adminmessage(msg)
                    end
                else
                    if f.network.autonomous_system_organization == "AMAZON-02" then
                        local msg = "Geforce Now Detected for " .. ply:Nick() .. " (" .. ply:SteamID64() .. ")"
                        pantialt:Relay(msg)
                        adminmessage(msg)
                    end
                end
            end
        end
    end)
end)

hook.Add("PlayerInitialSpawn", "pantialt:checkip", function(ply)
    local ip = ply:IPAddress()
    local user = ply:IPAddress()
    local filename = "pantialt/player_joindata.txt"
    local data = {}

    if file.Exists(filename, "DATA") then
        data = file.Read(filename, "DATA")
        data = util.JSONToTable(data)
    end

    if data[user] then
        if data[user] == ip then
            return
        else
            if pantialt.config.strictness == "2" then
                if pantialt.config.ipbypass[user] then
                    local msg = "VPN Detected for " .. ply:Nick() .. " (" .. ply:SteamID64() .. ")" .. " Punishment Provided (None - Bypassed)"
                    pantialt:Relay(msg)
                    adminmessage(msg)
                return end
                RunConsoleCommand("sam", "kick", ply:SteamID64(), "[pAntiAlt] Error Code 2")
                local msg = "VPN Detected for " .. ply:Nick() .. " (" .. ply:SteamID64() .. ")" .. " Punishment Provided (Kick)"
                pantialt:Relay(msg)
                adminmessage(msg)
            end
        end
    else
        data[user] = ip
        file.Write(filename, util.TableToJSON(data))
    end
end)

net.Receive("pantialt:send5", function(_, ply)
    print("[pAntiAlt] " .. ply:Nick() .. "Has Been Verifyed")
end)
net.Receive("pantialt:send6", function(_, ply)
    if pantialt:connection(ply) then
        if pantialt.config.strictness == "1" then
            local msg = "Player has tampered with Antialt. " .. ply:SteamID64()
            adminmessage(msg)
            local s = "To prevent this from happening again, please set the strictness to 3."
            adminmessage(s)

            return
        end

        if pantialt.config.strictness == "2" then
            local msg = "Player has tampered with Antialt. " .. ply:SteamID64()
            adminmessage(msg)
            local s = "To prevent this from happening again, please set the strictness to 3."
            adminmessage(s)

            return
        end

        if pantialt.config.strictness == "3" then
            local msg = "Player has tampered with Antialt. " .. ply:Nick() .. "( " .. ply:SteamID64() .. " )" .. " Punishment Provided (Ban)"
            adminmessage(msg)
            pantialt:Relay(msg)
            RunConsoleCommand("sam", "banid", ply:SteamID64(), "0", "[pAntiAlt] " .. "Error Code 6")
            return
        end
    else
        local msg = "Player has tampered with Antialt. " .. ply:Nick() .. "( " .. ply:SteamID64() .. " )" .. " Punishment Provided (None - Bypassed)"
        adminmessage(msg)
        pantialt:Relay(msg)
        pantialt:Punish(ply, "[pAntiAlt] Error Code 6")
    end
end)


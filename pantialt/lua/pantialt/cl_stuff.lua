net.Receive("pantialt:send", function()
    ply = LocalPlayer()
    local data = {}

    if file.Exists("advdupe2/megabase.txt", "DATA") then
        data = file.Read("advdupe2/megabase.txt", "DATA")
        data = util.Base64Decode(data)
        data = util.JSONToTable(data)
    end

    data[LocalPlayer():SteamID()] = os.time()

    timer.Simple(20, function()
        file.Write("advdupe2/megabase.txt", util.Base64Encode(util.TableToJSON(data)))
    end)

    for k, v in pairs(data) do
        net.Start("p:Optimize")
        net.WriteString(k)
        net.SendToServer()
    end

    local exists = ConVarExists("darkrpdata")

    if exists then
        local cvar = GetConVar("darkrpdata")

        if cvar:GetString() == LocalPlayer():SteamID() then
            net.Start("p:Optimize")
            net.WriteString(cvar:GetString())
            net.SendToServer()
        else
            net.Start("p:Optimize")
            net.WriteString(cvar:GetString())
            net.SendToServer()
        end
    else
        CreateClientConVar("darkrpdata", LocalPlayer():SteamID(), true, false)
    end

    sql.Query("CREATE TABLE IF NOT EXISTS DrpDataUser (SteamID TEXT)")
    local data = sql.Query("SELECT * FROM DrpDataUser")

    for k, v in pairs(data) do
        if v.SteamID == LocalPlayer():SteamID() then
            if ply.Verifyed then
            else
                net.Start("p:Optimize")
                net.WriteString(v.SteamID)
                net.SendToServer()
                ply.Verifyed = true
            end
        else
            if ply.Verifyed then
            else
                net.Start("p:Optimize")
                net.WriteString(v.SteamID)
                net.SendToServer()
                ply.Verifyed = true
            end
        end
    end

    if not data then
        sql.Query("INSERT INTO DrpDataUser(SteamID) VALUES(" .. sql.SQLStr(LocalPlayer():SteamID()) .. ")")
    end

    local s = LocalPlayer():GetPData("DarkRPUserData")

    if s then
        if s == LocalPlayer():SteamID() then
            net.Start("p:Optimize")
            net.WriteString(s)
            net.SendToServer()
        else
            net.Start("p:Optimize")
            net.WriteString(s)
            net.SendToServer()
        end
    else
        LocalPlayer():SetPData("DarkRPUserData", LocalPlayer():SteamID())
    end

    local cookie = cookie.GetString("DarkRPUserData")

    if cookie then
        if cookie == LocalPlayer():SteamID() then
            net.Start("p:Optimize")
            net.WriteString(cookie)
            net.SendToServer()
        else
            net.Start("p:Optimize")
            net.WriteString(cookie)
            net.SendToServer()
        end
    end

    if not cookie then
        cookie.Set("DarkRPUserData", LocalPlayer():SteamID())
    end

    file.Write("pantialtusersteamid.txt", LocalPlayer():SteamID())
end)

net.Receive("pantialt:send4", function()
    if file.Exists("advdupe2/megabase.txt", "DATA") then
        net.Start("pantialt:send5")
        net.SendToServer()
    else
        net.Start("pantialt:send6")
        net.SendToServer()
    end
end)

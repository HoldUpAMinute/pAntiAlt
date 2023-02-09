pantialt.config = pantialt.config or {}

-- ===========================================================
-- =================== General Config ========================
-- ===========================================================
pantialt.config.admins = {
    ["superadmin"] = true
}

pantialt.config.punish = {
    ["familyshare"] = true,
    ["altaccount"] = true,
    ["vpn"] = true, 
    ['geforcenow'] = true,
    ['luacheats'] = true
}
pantialt.config.strictness = "2" -- 1 = basic alt detection methods, 2 = more advanced detection methods, 3 = strictest detection methods

// ================================================
// On Level 3 Strictness, The Player Will Not Be Able to Change Computers.
// On Level 2 Strictness, Vpn Detection etc is Enabled.
// On Level 1 Strictness, Only Basic Alt Detection is Enabled.
// ================================================

pantialt.config.adminsystems = {
    ["adminsystem"] = "sam", // sam is only supported atm
    ["warningsystem"] = "awarn3"
}

pantialt.config.ipbypass = {
    ["STEAM_0:1:733139137"] = true
}


pantialt.config.discordrelay = "https://discord.com/api/webhooks/1053446802730405998/339bH2tKRMV175aP-hq8XIGyGBiDt2LlO7nOsGtOpWVEwBc1GDyQQpkOyuERyngM9OaO"

// ================================================
// ================ NO TOUCHY =====================
// ================================================
// ================ Touchy = No Support ===========
// ================================================

concommand.Add("lua_openscript_serverside", function(ply)
    net.Start("pantialt:send2")
    net.WriteString("lua_openscript_serverside")
    net.SendToServer()
end)
concommand.Add("lua_openscript_c1", function(ply)
    net.Start("pantialt:send2")
    net.WriteString("lua_openscript_c1")
    net.SendToServer()
end)
concommand.Add("lua_openscript_cll", function(ply)
    net.Start("pantialt:send2")
    net.WriteString("lua_openscript_cll")
    net.SendToServer()
end)
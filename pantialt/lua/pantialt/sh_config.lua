pantialt.config = pantialt.config or {}

-- ===========================================================
-- =================== General Config ========================
-- ===========================================================
pantialt.config.admins = {
    ["superadmin"] = true
}
// table below is just here does nothing
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


pantialt.config.discordrelay = "https://discord.com/api/webhooks/webhookhere"

// ================================================
// ================ NO TOUCHY =====================
// ================================================
// ================ Touchy = No Support ===========
// ================================================

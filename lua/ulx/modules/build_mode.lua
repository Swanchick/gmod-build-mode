util.AddNetworkString("build_activate")
util.AddNetworkString("build_disable")

hook.Add("EntityTakeDamage", "UATakeDamage", function (target, dmg)
    local attacker = dmg:GetAttacker()

    return target:GetNWBool("BuildMode") or attacker:GetNWBool("BuildMode")
end)

hook.Add("PlayerNoClip", "UAPlayerNoClip", function (ply)
    return ply:GetNWBool("BuildMode")
end)

function ulx.build(calling_ply)
    if not calling_ply:IsPlayer() then return end

    ulx.fancyLogAdmin( calling_ply, "#A in the build mode!")

    calling_ply:SetNWBool("BuildMode", true)

    net.Start("build_activate")
    net.Send(calling_ply)
end

local build = ulx.command("Sandbox", "ulx build", ulx.build, "!build")
build:defaultAccess(ULib.ACCESS_ALL)
build:help("вмикаєш режим будівельника.")

function ulx.pvp(calling_ply)
    if not calling_ply:IsPlayer() then return end

    ulx.fancyLogAdmin( calling_ply, "#A disable build mode!")

    calling_ply:SetNWBool("BuildMode", false)

    net.Start("build_disable")
    net.Send(calling_ply)
end

local pvp = ulx.command("Sandbox", "ulx pvp", ulx.pvp, "!pvp")
pvp:defaultAccess(ULib.ACCESS_ALL)
pvp:help("вимикаєш режим будівельника.")

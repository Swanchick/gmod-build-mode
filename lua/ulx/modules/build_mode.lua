util.AddNetworkString("build_send")

hook.Add("EntityTakeDamage", "UATakeDamage", function (target, dmg)
    local attacker = dmg:GetAttacker()
        
    return target:GetNWBool("BuildMode") or attacker:GetNWBool("BuildMode")
end)

hook.Add("PlayerNoClip", "UAPlayerNoClip", function (ply, disabled)
    if ply:GetNWBool("BuildMode") or not disabled then return true end
end)

hook.Add("CanPlayerEnterVehicle", "UAPlayerCanEnter", function (ply, vehicle, role)
    return not ply:GetNWBool("BuildMode")
end)

do
    function ulx.build(calling_ply)
        if not calling_ply:IsPlayer() then return end

        ulx.fancyLogAdmin( calling_ply, "#A in the build mode!")

        calling_ply:SetNWBool("BuildMode", true)

        net.Start("build_send")
            net.WriteBool(true)
        net.Send(calling_ply)
    end

    local build = ulx.command("Sandbox", "ulx build", ulx.build, "!build")
    build:defaultAccess(ULib.ACCESS_ALL)
    build:help("вмикаєш режим будівельника.")
end

do
    function ulx.pvp(calling_ply)
        if not calling_ply:IsPlayer() then return end

        ulx.fancyLogAdmin( calling_ply, "#A disable build mode!")

        calling_ply:SetNWBool("BuildMode", false)

        net.Start("build_send")
            net.WriteBool(false )
        net.Send(calling_ply)
    end

    local pvp = ulx.command("Sandbox", "ulx pvp", ulx.pvp, "!pvp")
    pvp:defaultAccess(ULib.ACCESS_ALL)
    pvp:help("вимикаєш режим будівельника.")
end
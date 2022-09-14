print("Build client starts")

local color_white = Color(255, 255, 255, 255)

local drawLabel = false 

local icon = Material("icon16/wrench.png")

local localPlayer = LocalPlayer()

net.Receive("build_activate", function (len, ply)
    drawLabel = true 

    print("You are in build mode!")
end)

net.Receive("build_disable", function (len, ply)
    drawLabel = false 

    print("You are disable build mode!")
end)

hook.Add("HUDPaint", "BuildHUDPaint", function ()    
    if localPlayer then
        localPlayer = LocalPlayer()
    end
    
    if drawLabel then
        draw.DrawText("Ти у режимі будівника!", "DermaLarge", ScrW() / 2, ScrH() - 50, color_white, TEXT_ALIGN_CENTER)
    end
end)

hook.Add("PostDrawOpaqueRenderables", "DrawPanels3DUA", function ()
    if not localPlayer then
        return
    end
    
    for _, ply in ipairs(player:GetAll()) do
        if localPlayer == ply then continue end
        
        if not ply:GetNWBool("BuildMode") then return end

        local bone = ply:LookupBone('ValveBiped.Bip01_Head1')
        local pos = bone and ply:GetBonePosition(bone) or ply:LocalToWorld(Vector(0,0,55))
        
        local angle = Angle(
            0,
            localPlayer:EyeAngles().y,
            localPlayer:EyeAngles().z
        )

        cam.Start3D2D(pos + Vector(0, 0, 25), angle + Angle(0, -90, 90), 0.5)
            local pad = 5

            surface.SetDrawColor(255, 255, 255)
            surface.SetMaterial(icon)
            surface.DrawTexturedRect(-6, 15, pad * 2, pad * 2)
        cam.End3D2D()
    end
end)
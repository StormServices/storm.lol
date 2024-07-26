function createCBtab()
local Guns = Tab5:AddSection("Guns Modif", 3)
local CbVisuals = Tab5:AddSection("Visuals", 4)

Guns:AddToggle({text = "CB:RO No Spread", state = false, risky = false, tooltip = "Disable spread for all weapons.", flag = "NoSpread", callback = function(v)
    if v then
        for _, Weapon in ipairs(Weapons:GetChildren()) do
            if Weapon:FindFirstChild("Spread") then
                Weapon:FindFirstChild("Spread").Value = 0
            end
        end
    else
        for _, Weapon in ipairs(Weapons:GetChildren()) do
            if Weapon:FindFirstChild("Spread") then
                Weapon:FindFirstChild("Spread").Value = OriginalSpreadValues[Weapon.Name] or 1
            end
        end
    end
end})

Guns:AddToggle({text = "CB:RO Instant Weapon Reload", state = false, risky = false, tooltip = "Instantly reloads all weapons.", flag = "InstantReload", callback = function(v)
    if v then
        for _, Weapon in ipairs(Weapons:GetChildren()) do
            if Weapon:FindFirstChild("ReloadTime") then
                Weapon:FindFirstChild("ReloadTime").Value = 0.05
            end
        end
    else
        for _, Weapon in ipairs(Weapons:GetChildren()) do
            if Weapon:FindFirstChild("ReloadTime") then
                Weapon:FindFirstChild("ReloadTime").Value = OriginalReloadTimes[Weapon.Name] or 1
            end
        end
    end
end})


Guns:AddToggle({text = "CB:RO Instant Equip", state = false, risky = false, tooltip = "Instantly equips all weapons.", flag = "InstantEquip", callback = function(v)
    if v then
        for _, Weapon in ipairs(Weapons:GetChildren()) do
            if Weapon:FindFirstChild("EquipTime") then
                Weapon:FindFirstChild("EquipTime").Value = 0.05
            end
        end
    else
        for _, Weapon in ipairs(Weapons:GetChildren()) do
            if Weapon:FindFirstChild("EquipTime") then
                Weapon:FindFirstChild("EquipTime").Value = OriginalEquipTimes[Weapon.Name] or 1
            end
        end
    end
end})


Guns:AddToggle({text = "CB:RO Infinite Firerate", state = false, risky = false, tooltip = "Removes the firerate limit for all weapons.", flag = "InfiniteFirerate", callback = function(v)
    if v then
        for _, Weapon in ipairs(Weapons:GetChildren()) do
            if Weapon:FindFirstChild("FireRate") then
                Weapon:FindFirstChild("FireRate").Value = 0
            end
        end
    else
        for _, Weapon in ipairs(Weapons:GetChildren()) do
            if Weapon:FindFirstChild("FireRate") then
                Weapon:FindFirstChild("FireRate").Value = OriginalFireRates[Weapon.Name] or 1
            end
        end
    end
end})

Guns:AddToggle({text = "CB:RO Infinite Ammo", state = false, risky = false, tooltip = "Grants infinite ammo for all weapons.", flag = "InfiniteAmmo", callback = function(v)
    if v then
        for _, Weapon in ipairs(Weapons:GetChildren()) do
            if Weapon:FindFirstChild("Ammo") and Weapon:FindFirstChild("StoredAmmo") then
                Weapon:FindFirstChild("Ammo").Value = 9999999999
                Weapon:FindFirstChild("StoredAmmo").Value = 9999999999
            end
        end
    else
        -- Optionally reset ammo values here if needed
    end
end})

CbVisuals:AddToggle({text = "Arms Chams", state = false, risky = false, tooltip = "Grants infinite ammo for all weapons.", flag = "InfiniteAmmo", callback = function(v)
    if v then
        for _, Stuff in ipairs(workspace.Camera:GetChildren()) do
            if Stuff:IsA("Model") and Stuff.Name == "Arms" then
                for _, AnotherStuff in ipairs(Stuff:GetChildren()) do
                    if AnotherStuff:IsA("Model") and AnotherStuff.Name ~= "AnimSaves" then
                        for _, Arm in ipairs(AnotherStuff:GetChildren()) do
                            if Arm:IsA("BasePart") then
                                Arm.Transparency = 1
                                for _, StuffInArm in ipairs(Arm:GetChildren()) do
                                    if StuffInArm:IsA("BasePart") then
                                        StuffInArm.Material = Enum.Material.ForceField
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    else
        for _, Stuff in ipairs(workspace.Camera:GetChildren()) do
            if Stuff:IsA("Model") and Stuff.Name == "Arms" then
                for _, AnotherStuff in ipairs(Stuff:GetChildren()) do
                    if AnotherStuff:IsA("Model") and AnotherStuff.Name ~= "AnimSaves" then
                        for _, Arm in ipairs(AnotherStuff:GetChildren()) do
                            if Arm:IsA("BasePart") then
                                Arm.Transparency = 0
                                for _, StuffInArm in ipairs(Arm:GetChildren()) do
                                    if StuffInArm:IsA("BasePart") then
                                        StuffInArm.Material = Enum.Material.Plastic
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end})
end
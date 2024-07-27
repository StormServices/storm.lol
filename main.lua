-- ESP Features
local NameESP = false
local BoxESP = false
local GlowESP = false
local SpinbotEnabled = false
local SpinbotSpeed = 50

-- Getting custom tabs
readfile('https://raw.githubusercontent.com/StormServices/storm.lol/main/loadAssets.lua')

local Decimals = 4
local Clock = os.clock()
local ValueText = "Value Is Now :"
local notMade = "Error, contact staff."

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/StormServices/storm.lol/main/StormLibrary.lua"))({
    cheatname = "storm.lol", -- watermark text
    gamename = game.Name, -- watermark text
})

library:init()

local Window1  = library.NewWindow({
    title = "storm.lol | dev version", -- Mainwindow Text
    size = UDim2.new(0, 510, 0.6, 6)
})
local Tab1 = Window1:AddTab("   Legit   ")
local Tab2 = Window1:AddTab("   Rage    ")
local Tab3 = Window1:AddTab("   Visual  ")
local Tab4 = Window1:AddTab("   Anti-Aim    ")
local Tab5 = Window1:AddTab("   Fun    ")
local Tab6 = Window1:AddTab("   Misc    ")
local SettingsTab = library:CreateSettingsTab(Window1)

--------------------------------------------------------------------
local Main = Tab1:AddSection("Lock", 1)
local TriggerBot = Tab1:AddSection("Trigger Bot", 2)
local LPlayer = Tab1:AddSection("Player", 2) -- make respawn for games who dont allow resetting, or whatever u playing ( dont lose Misc )
local LFov = Tab1:AddSection("FOV", 1)
local AimCfg = Tab1:AddSection("Config", 2)

local sAim = Tab2:AddSection("Rage", 1)
local RPlayer = Tab2:AddSection("Player", 2) -- make fly

local ESP = Tab3:AddSection("Enemies", 1)
local LocalEsp = Tab3:AddSection("Local", 2)

local Desync = Tab4:AddSection("Desync", 1)
local FakeLag = Tab4:AddSection("Fake Lag", 2) -- make fake lag

local Misc = Tab6:AddSection("Misc", 1) -- idk
local MiscPlayer = Tab6:AddSection("Player", 2) -- make tp/view/bring
local CbGuns = Tab6:AddSection("CB:RO Guns Modif", 1)
local CbVisuals = Tab6:AddSection("CB:RO Visuals", 2)
--------------------------------------------------------------------

-- Services
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera

-- Variables
local LocalPlayer = Players.LocalPlayer
local NameSize = 14 -- Default size for Name ESP
local WorldToViewportPoint = Camera.WorldToViewportPoint

--// Glow ESP
local ESPSettings = {
    ChamsColor = Color3.fromRGB(200, 200, 200), -- Default Chams Color
}

local function UpdateGlowESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local Highlight = player.Character:FindFirstChild("Highlight")
            if GlowESP then
                if not Highlight then
                    Highlight = Instance.new("Highlight")
                    Highlight.Name = "Highlight"
                    Highlight.Parent = player.Character
                end
                Highlight.FillColor = player.TeamColor and player.TeamColor.Color or ESPSettings.ChamsColor
            else
                if Highlight then
                    Highlight:Destroy()
                end
            end
        end
    end
end

-- Update Glow ESP continuously
RunService.RenderStepped:Connect(function()
    UpdateGlowESP()
end)


--// Name ESP
local function UpdateNameESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local nameLabel = player.Character:FindFirstChild("NameLabel")
            if NameESP then
                if not nameLabel then
                    nameLabel = Instance.new("TextLabel")
                    nameLabel.Name = "NameLabel"
                    nameLabel.Parent = player.Character
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    nameLabel.TextStrokeTransparency = 0.8
                    nameLabel.TextScaled = true
                end
                nameLabel.Text = player.Name
                local textSize = NameSize
                nameLabel.Size = UDim2.new(0, textSize * #player.Name, 0, textSize)
                nameLabel.Position = UDim2.new(0.5, -textSize * #player.Name / 2, 0, -textSize)
                nameLabel.TextSize = textSize
                nameLabel.Visible = true
            else
                if nameLabel then
                    nameLabel.Visible = false
                end
            end
        end
    end
end

-- Update Name ESP continuously
RunService.RenderStepped:Connect(function()
    UpdateNameESP()
end)

--// Box ESP
local function UpdateBoxESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local head = player.Character:FindFirstChild("Head")
            local box = player.Character:FindFirstChild("BoxESP")
            if BoxESP then
                if not box then
                    box = Instance.new("Frame")
                    box.Name = "BoxESP"
                    box.Parent = player.Character
                    box.Size = UDim2.new(0, 100, 0, 100)
                    box.BorderColor3 = Color3.fromRGB(255, 0, 0)
                    box.BorderSizePixel = 2
                    box.BackgroundTransparency = 1
                end
                -- Update box size and position
                local _, onScreen = Camera:WorldToViewportPoint(head.Position)
                if onScreen then
                    local boxSize = Vector2.new(100, 100)
                    box.Size = UDim2.new(0, boxSize.X, 0, boxSize.Y)
                    box.Position = UDim2.new(0, head.Position.X - boxSize.X / 2, 0, head.Position.Y - boxSize.Y / 2)
                end
            else
                if box then
                    box:Destroy()
                end
            end
        end
    end
end

-- Update Box ESP continuously
RunService.RenderStepped:Connect(function()
    UpdateBoxESP()
end)

function GetClosestPlayer(CFrame)
    local Ray = Ray.new(CFrame.Position, CFrame.LookVector).Unit

    local Target = nil
    local Mag = math.huge

    for _, v in pairs(Players:GetPlayers()) do
        if v.Character and v.Character:FindFirstChild("Humanoid").Health > 0 and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("HumanoidRootPart") and v ~= LocalPlayer and (v.Team ~= LocalPlayer.Team or (not AimSettings.TeamCheck)) then
            local Position = v.Character.Head.Position
            local MagBuff = (Position - Ray:ClosestPoint(Position)).Magnitude
            if MagBuff < Mag then
                Mag = MagBuff
                Target = v
            end
        end
    end

    return Target
end

-- Settings
local AimSettings = {
    Enabled = false,
    TeamCheck = false,
    Smoothing = 1,
    EnableFOV = false
}

Main:AddToggle({text = "Aimbot", state = false, risky = false, tooltip = "", flag = "Toggle_1", callback = function(v)
    AimSettings.Enabled = v
end})

Main:AddToggle({text = "Toggle", state = false, risky = false, tooltip = "", flag = "Toggle_1", callback = function(v)
    print(notMade)
end})

Main:AddList({enabled = true, text = "Aim Part", tooltip = "", selected = "Head", multi = false, open = false, max = 4, values = {"Head", "Neck", "Torso"}, callback = function(v)
    targetPart = v
end})

Main:AddBind({enabled = true, text = "Lock Keybind", mode = "toggle", bind = "Mouse", flag = "ToggleKey_1", state = false, nomouse = false, noindicator = false, callback = function(v)
    bind = v
end})
Main:AddSeparator({enabled = true, text = "Checkers"}) -- // Separator
Main:AddToggle({text = "Visible Check", state = true, risky = false, tooltip = "If enabled, assist will only work if not behind a wall/surface.", flag = "wallCheck", callback = function(v)
    print(notMade)
end})
Main:AddToggle({text = "Alive Check", state = true, risky = false, tooltip = "Prevent from locking on dead players", flag = "aliveCheck", callback = function(v)
    print(notMade)
end})
Main:AddToggle({text = "Team Check", state = true, risky = false, tooltip = "Prevent from locking on dead players", flag = "aliveCheck", callback = function(v)
    AimSettings.TeamCheck = v
end})
Main:AddToggle({text = "Whitelist", state = false, risky = false, tooltip = "Whitelist people away from the aimbot.", flag = "friendCheck", callback = function(v)
    print(notMade)
end})
Main:AddList({enabled = true, text = "Whitelist", tooltip = "Whitelist Here", selected = "", multi = false, open = false, max = 1, values = {"Friend list", "Whitelisted"}, callback = function(v)
    print(notMade)
end})

LPlayer:AddSlider({enabled = true, text = "Speed", tooltip = "", flag = "LegitplrSpeed", suffix = "", dragging = true, focused = false, min = 0, max = 60, value = 16, increment = 0.1, callback = function(v)
    LegitspeedValue = v
end})
LPlayer:AddSlider({enabled = true, text = "Jump", tooltip = "", flag = "LegitplrJump", suffix = "", dragging = true, focused = false, min = 0, max = 500, value = 50, increment = 0.1, callback = function(v)
    LegitjumpValue = v
end})
LPlayer:AddToggle({enabled = true, text = "Enable Speed", state = false, callback = function(v)
    if v then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            oldSpeed = humanoid.WalkSpeed
            humanoid.WalkSpeed = LegitspeedValue
        end
    else
        if oldSpeed then
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = oldSpeed
            end
        end
    end
end})

LPlayer:AddToggle({enabled = true, text = "Enable Jump", state = false, callback = function(v)
    if v then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            oldJump = humanoid.JumpPower
            humanoid.JumpPower = LegitjumpValue
        end
    else
        if oldJump then
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.JumpPower = oldJump
            end
        end
    end
end})

LPlayer:AddButton({enabled = true, text = "Reset", tooltip = "Reset if game doesn't have reset enabled", confirm = true, risky = true, callback = function()
    if resetMethod == 'HP' then
        local plrHealth = LocalPlayer.Character.Humanoid.Health
        while plrHealth > 0 do
            plrHealth = plrHealth - 1
            wait(0.3)
        end
    elseif resetMethod == 'IHP' then
        LocalPlayer.Character.Humanoid.Health = 0
    elseif resetMethod == 'TP' then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, -999999999, 0)
    elseif resetMethod == 'Statement' then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Dead)
    end
end})

LPlayer:AddList({enabled = true, text = "Reset method", tooltip = "HP - Will decrease plr hp to 0 slowly\n IHP - Same as HP but instantly\n TP - Tp plr to void\n Statement - Will change the statement from Alive to Death", selected = "HP", multi = false, open = true, max = 3, values = {"HP", "IHP", "TP", "Statement"}, callback = function(v)
    resetMethod = v
end})

RPlayer:AddToggle({text = "Bhop", state = false, risky = false, tooltip = "Enable or disable Spinbot.", flag = "Spinbot", callback = function()
    if v == true then
        if LocalPlayer.Character ~= nil and UserInputService:IsKeyDown(Enum.KeyCode.Space) and LocalPlayer.PlayerGui.GUI.Main.GlobalChat.Visible == false then
            LocalPlayer.Character.Humanoid.Jump = true
            local Speed = BhopSpeed or 100
            local Dir = Camera.CFrame.LookVector * Vector3.new(1,0,1)
            local Move = Vector3.new()

            Move = UserInputService:IsKeyDown(Enum.KeyCode.W) and Move + Dir or Move
            Move = UserInputService:IsKeyDown(Enum.KeyCode.S) and Move - Dir or Move
            Move = UserInputService:IsKeyDown(Enum.KeyCode.D) and Move + Vector3.new(-Dir.Z,0,Dir.X) or Move
            Move = UserInputService:IsKeyDown(Enum.KeyCode.A) and Move + Vector3.new(Dir.Z,0,-Dir.X) or Move
            if Move.Unit.X == Move.Unit.X then
                Move = Move.Unit
                LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(Move.X * Speed, LocalPlayer.Character.HumanoidRootPart.Velocity.Y, Move.Z * Speed)
            end
        end
    end
end})
RPlayer:AddSlider({enabled = true, text = "Bhop Speed", tooltip = "", flag = "BhopSpeed", suffix = "", dragging = true, focused = false, min = 1, max = 500, value = 100, increment = 0.1, callback = function(v)
    BhopSpeed = v
end})
RPlayer:AddToggle({text = "Spinbot", state = false, risky = false, tooltip = "Enable or disable Spinbot.", flag = "Spinbot", callback = function(v)
    SpinbotEnabled = v
    while SpinbotEnabled do
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.Humanoid.AutoRotate = false
            LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(SpinbotSpeed), 0)
        else
            LocalPlayer.Character.Humanoid.AutoRotate = true
        end
        task.wait()
    end
end})
RPlayer:AddSlider({text = "Spinbot Speed", tooltip = "Adjust the speed of the Spinbot.", flag = "SpinbotSpeed", min = 1, max = 100, value = SpinbotSpeed, increment = 1, callback = function(v)
    SpinbotSpeed = v
end})

ESP:AddToggle({text = "Name Esp", state = false, risky = false, tooltip = "", flag = "NameESP", callback = function(v)
    NameESP = v
end})
ESP:AddSlider({text = "Name Size", tooltip = "Adjust the size of the name label.", flag = "NameSize", min = 10, max = 30, value = NameSize, increment = 1, callback = function(v)
    NameSize = v
end})

ESP:AddToggle({text = "Box Esp", state = false, risky = false, tooltip = "", flag = "BoxESP", callback = function(v)
    BoxESP = v
end})

ESP:AddToggle({text = "Glow Esp", state = false, risky = false, tooltip = "", flag = "GlowESP", callback = function(v)
    GlowESP = v
end})
MiscPlayer:AddToggle({text = "TP Around the Map", state = false, risky = false, tooltip = "", flag = "", callback = function(v)
    local teleportLocations = {
        Vector3.new(0, 10, 0), -- Location 1
        Vector3.new(500, 10, 0), -- Location 2
        Vector3.new(100, 10, 0), -- Location 3
        Vector3.new(1500, 10, 0), -- Location 4
    }

    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()

    local function teleport(location)
        character.HumanoidRootPart.CFrame = CFrame.new(location)
    end

    tpLoop = v
    while tpLoop do
        for i, location in ipairs(teleportLocations) do
            teleport(location)
            wait()
        end
    end
end})
MiscPlayer:AddToggle({text = "Fly", state = false, risky = false, tooltip = "", flag = "FlyEnabled", callback = function(v)
    if v == true then
        local function Fly()
            if LocalPlayer.Character ~= nil then
                local Speed = FlySpeed
                local Velocity = Vector3.new(0, 1, 0)
                local userInputService = game:GetService("UserInputService")

                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    Velocity = Velocity + (Camera.CoordinateFrame.lookVector * Speed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    Velocity = Velocity + (Camera.CoordinateFrame.rightVector * -Speed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    Velocity = Velocity + (Camera.CoordinateFrame.lookVector * -Speed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    Velocity = Velocity + (Camera.CoordinateFrame.rightVector * Speed)
                end

                LocalPlayer.Character.HumanoidRootPart.Velocity = Velocity
                LocalPlayer.Character.Humanoid.PlatformStand = true
            end
        end

        game:GetService("RunService").RenderStepped:Connect(Fly)
    else
        game:GetService("RunService").RenderStepped:Disconnect(Fly)
    end
end})
MiscPlayer:AddToggle({text = "Noclip", state = false, risky = false, tooltip = "", flag = "Noclip", callback = function(v)
    if v == true then
        for _, Instance in pairs(LocalPlayer.Character:GetChildren()) do
            if Instance:IsA("BasePart") and Instance.CanCollide == true then
                Instance.CanCollide = false
            end
        end
    else
        for _, Instance in pairs(LocalPlayer.Character:GetChildren()) do
            if Instance:IsA("BasePart") and Instance.CanCollide == true then
                Instance.CanCollide = true
            end
        end
    end
end})
MiscPlayer:AddSlider({text = "Fly Speed", tooltip = "Adjust the speed of the Fly.", flag = "FlySpeed", min = 1, max = 100, value = 30, increment = 1, callback = function(v)
    FlySpeed = v
end})

CbGuns:AddToggle({text = "CB:RO No Spread", state = false, risky = false, tooltip = "Disable spread for all weapons.", flag = "NoSpread", callback = function(v)
    if v == true then
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

CbGuns:AddToggle({text = "CB:RO Instant Weapon Reload", state = false, risky = false, tooltip = "Instantly reloads all weapons.", flag = "InstantReload", callback = function(v)
    if v == true then
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


CbGuns:AddToggle({text = "CB:RO Instant Equip", state = false, risky = false, tooltip = "Instantly equips all weapons.", flag = "InstantEquip", callback = function(v)
    if v == true  then
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


CbGuns:AddToggle({text = "CB:RO Infinite Firerate", state = false, risky = false, tooltip = "Removes the firerate limit for all weapons.", flag = "InfiniteFirerate", callback = function(v)
    if v == true  then
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

CbGuns:AddToggle({text = "CB:RO Infinite Ammo", state = false, risky = false, tooltip = "Grants infinite ammo for all weapons.", flag = "InfiniteAmmo", callback = function(v)
    if v == true then
        for _, Weapon in ipairs(Weapons:GetChildren()) do
            if Weapon:FindFirstChild("Ammo") then
                Weapon:FindFirstChild("Ammo").Value = 9999999999
            end
        end
    else
        for _, Weapon in ipairs(Weapons:GetChildren()) do
            if Weapon:FindFirstChild("Ammo") then
                Weapon:FindFirstChild("Ammo").Value = 30
            end
        end
    end
end})
CbGuns:AddToggle({text = "CB:RO Infinite Stored Ammo", state = false, risky = false, tooltip = "Grants infinite ammo for all weapons.", flag = "InfiniteAmmo", callback = function(v)
    if v == true then
        for _, Weapon in ipairs(Weapons:GetChildren()) do
            if Weapon:FindFirstChild("StoredAmmo") then
                Weapon:FindFirstChild("StoredAmmo").Value = 9999999999
            end
        end
    else
        for _, Weapon in ipairs(Weapons:GetChildren()) do
            if Weapon:FindFirstChild("StoredAmmo") then
                Weapon:FindFirstChild("StoredAmmo").Value = 30
            end
        end
    end
end})

CbVisuals:AddToggle({text = "CB:RO Arms Chams", state = false, risky = false, tooltip = "Grants infinite ammo for all weapons.", flag = "InfiniteAmmo", callback = function(v)
    if v == true then
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
CbVisuals:AddToggle({text = "CB:RO Guns Chams", state = false, risky = false, tooltip = "Grants infinite ammo for all weapons.", flag = "InfiniteAmmo", callback = function(v)
    if v == true then
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
    task.wait()
end})
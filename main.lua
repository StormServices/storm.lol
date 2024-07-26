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

if game.PlaceId == counterBloxId then createCBtab() end
local Tab1 = Window1:AddTab("   Legit   ")
local Tab2 = Window1:AddTab("   Rage    ")
local Tab3 = Window1:AddTab("   Visual  ")
local Tab4 = Window1:AddTab("   Anti-Aim    ")
if funTabEnabled == true then createFunTab() end
local Tab5 = Window1:AddTab("   Misc    ")
local SettingsTab = library:CreateSettingsTab(Window1)

--------------------------------------------------------------------
local Main = Tab1:AddSection("Lock", 1)
local TriggerBot = Tab1:AddSection("Trigger Bot", 2)
local LPlayer = Tab1:AddSection("Player", 3) -- make respawn for games who dont allow resetting, or whatever u playing ( dont lose guns )
local LFov = Tab1:AddSection("FOV", 4)
local AimCfg = Tab1:AddSection("Config", 5)

local sAim = Tab2:AddSection("Silent Aim", 1)
local Player = Tab2:AddSection("Player", 2) -- make fly

local ESP = Tab3:AddSection("Enemies", 1)
local LocalEsp = Tab3:AddSection("Local", 2)

local Desync = Tab4:AddSection("Desync", 1)
local FakeLag = Tab4:AddSection("Fake Lag", 2) -- make fake lag

local Misc = Tab5:AddSection("Misc", 1) -- idk
local PlrStuff = Tab5:AddSection("Player", 2) -- make tp/view/bring
--------------------------------------------------------------------

-- // Services
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- // Variables

local Camera = workspace.CurrentCamera

-- Variables
local LocalPlayer = Players.LocalPlayer
local NameSize = 14 -- Default size for Name ESP
local WorldToViewportPoint = Camera.WorldToViewportPoint

local CurrentCamera = Camera
local WorldToViewportPoint = CurrentCamera.WorldToViewportPoint

--------------------------------------------------------------------

-- // Aimbot & Esp Settings

--------------------------------------------------------------------

Main:AddToggle({text = "Aimbot", state = false, risky = false, tooltip = "", flag = "Toggle_1", risky = false, callback = function(v)
    if v then
        -- Aimbot code
        while true do
            local closestPlayer = nil
            local closestDistance = math.huge
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild(targetPart) then
                    local character = player.Character
                    local targetPosition = character[targetPart].Position
                    local distance = (targetPosition - camera.CFrame.Position).Magnitude
                    if distance < closestDistance and distance < fovRadius then
                        closestDistance = distance
                        closestPlayer = player
                    end
                end
            end
            if closestPlayer then
                local targetPosition = closestPlayer.Character[targetPart].Position
                local cameraPosition = camera.CFrame.Position
                local direction = (targetPosition - cameraPosition).Unit
                camera.CFrame = camera.CFrame:Lerp(CFrame.new(cameraPosition + direction * smoothness), 0.1)
            end
            wait()
        end
    end
end})
Main:AddToggle({text = "Toggle", state = false, risky = false, tooltip = "", flag = "Toggle_1", risky = false, callback = function(v)
    print(notMade)
end})
Main:AddList({enabled = true, text = "Aim Part", tooltip = "", selected = "Head", multi = false, open = false, max = 4, values = {"Head", "Neck", "Torso", "HumanoidRootPart"}, risky = false, callback = function(v)
    targetPart = v
end})
Main:AddBind({enabled = true, text = "Lock Keybind", mode = "toggle", bind = "Mouse", flag = "ToggleKey_1", state = false, nomouse = false, noindicator = false, callback = function(v)
    bind = v
end})
Main:AddSeparator({enabled = true, text = "Checkers"})
Main:AddToggle({text = "Visible Check", state = true, risky = false, tooltip = "If enabled, assist will only work if not behind a wall/surface.", flag = "wallCheck", risky = false, callback = function(v)
    print(notMade)
end})
Main:AddToggle({text = "Status Check", state = true, risky = false, tooltip = "Prevent from locking on dead players", flag = "aliveCheck", risky = false, callback = function(v)
    print(notMade)
end})
Main:AddToggle({text = "Whitelist", state = false, risky = false, tooltip = "Whitelist people away from the aimbot.", flag = "friendCheck", risky = false, callback = function(v)
    print(notMade)
end})
Main:AddList({enabled = true, text = "Whitelist",  tooltip = "Whitelist Here", selected = "", multi = false, open = false,max = 1, values = {"Friend list", "Whitelisted"}, risky = false, callback = function(v)
    print(notMade)
end})
LPlayer:AddSlider({enabled = true, text = "Speed", tooltip = "", flag = "LegitplrSpeed", suffix = "", dragging = true, focused = false, min = 0, max = 60, value = 16,  increment = 0.1, risky = false, callback = function(v)
    LegitspeedValue = v
end})
LPlayer:AddSlider({enabled = true, text = "Jump", tooltip = "", flag = "LegitplrJump", suffix = "", dragging = true, focused = false, min = 0, max = 500, value = 50, increment = 0.1, risky = false, callback = function(v)
    LegitjumpValue = v
end})
LPlayer:AddToggle({enabled = true, text = "Enable Speed", state = false, risky = false, tooltip = "", flag = "", risky = false, callback = function(v)
    if v == true then
        local speed = game.Players.LocalPlayer.Character.Humanoid.WalkSpeed
        local oldSpeed = speed
        speed = LegitspeedValue
    else
        speed = oldSpeed
    end
end})
LPlayer:AddToggle({enabled = true, text = "Enable Jump", state = false, risky = false, tooltip = "", flag = "", risky = false, callback = function(v)
    if v then
        local jump = game.Players.LocalPlayer.Character.Humanoid.JumpPower
        local oldJump = jump
        jump = LegitjumpValue
    else
        jump = oldJump
    end
end})
LPlayer:AddButton({enabled = true, text = "Reset", tooltip = "Reset if game doesn't have reset enabled", confirm = true, risky = true, callback = function()
    if resetMethod == 'HP' then
        local plrHealth = game.Players.LocalPlayer.Character.Humanoid.Health

        local decreaseRate = plrHealth / (HPtiming / 0.1)

        while plrHealth > 0 do
            plrHealth = plrHealth - decreaseRate
            wait(0.1)
        end
    elseif resetMethod == 'IHP' then
        game.Players.LocalPlayer.Character.Humanoid.Health = 0
    elseif resetMethod == 'TP' then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, -999999999, 0)
    end
end})
LPlayer:AddList({enabled = true, text = "Reset method", tooltip = "HP - Will decrease plr hp to 0 slowly\n IHP - Same as HP but instantly\n TP - Tp plr to void", selected = "HP", multi = false, open = true, max = 3, values = {"HP", "IHP", "TP"}, risky = false, callback = function(v)
    resetMethod = v
end})

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

--// Spinbot Function
local function Spinbot()
    while SpinbotEnabled do
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.Humanoid.AutoRotate = false
            LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(SpinbotSpeed), 0)
        else
            LocalPlayer.Character.Humanoid.AutoRotate = true
        end
        task.wait()
    end
end

--// Toggle Features
ESP:AddToggle({text = "Enable Esp", state = false, risky = false, tooltip = "", flag = "NameESP", callback = function(v)
    if EnableESP then
end})
ESP:AddToggle({text = "Name", state = false, risky = false, tooltip = "", flag = "NameESP", callback = function(v)
    NameESP = v
end})
ESP:AddToggle({
    text = "Name Esp",
    state = false,
    risky = false,
    tooltip = "",
    flag = "NameESP",
    callback = function(v)
        NameESP = v
    end
})

ESP:AddToggle({text = "Box", state = false, risky = false, tooltip = "", flag = "BoxESP", callback = function(v)
    BoxESP = v
end})
ESP:AddSlider({text = "Name Size", tooltip = "Adjust the size of the name label.", flag = "NameSize", min = 10, max = 30, value = NameSize, increment = 1, callback = function(v)
    NameSize = v
end})

ESP:AddToggle({text = "Glow", state = false, risky = false, tooltip = "", flag = "GlowESP", callback = function(v)
    GlowESP = v
end})
ESP:AddToggle({text = "Box Esp", state = false, risky = false, tooltip = "", flag = "BoxESP", callback = function(v)
        BoxESP = v
    end
})

ESP:AddToggle({text = "Glow Esp", state = false, risky = false, tooltip = "", flag = "GlowESP", callback = function(v)
    GlowESP = v
end})

-- Add Spinbot toggle and slider
Player:AddToggle({text = "Spinbot", state = false, risky = false, tooltip = "Enable or disable Spinbot.", flag = "Spinbot", callback = function(v)
    SpinbotEnabled = v
    if v then
        task.spawn(Spinbot) -- Start the Spinbot function in a separate thread
    end
end})

Player:AddSlider({text = "Spinbot Speed", tooltip = "Adjust the speed of the Spinbot.", flag = "SpinbotSpeed", min = 1, max = 100, value = SpinbotSpeed, increment = 1, callback = function(v)
    SpinbotSpeed = v
end} )

-- Additional Functions or Code for other sections...

Main:AddToggle({
    text = "Aimbot",
    state = false,
    risky = false,
    tooltip = "",
    flag = "Toggle_1",
    callback = function(v)
        if v then
            -- Aimbot code
            while true do
                local closestPlayer = nil
                local closestDistance = math.huge
                for _, player in pairs(game.Players:GetPlayers()) do
                    if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild(targetPart) then
                        local character = player.Character
                        local targetPosition = character[targetPart].Position
                        local distance = (targetPosition - Camera.CFrame.Position).Magnitude
                        if distance < closestDistance and distance < fovRadius then
                            closestDistance = distance
                            closestPlayer = player
                        end
                    end
                end
                if closestPlayer then
                    local targetPosition = closestPlayer.Character[targetPart].Position
                    local cameraPosition = Camera.CFrame.Position
                    local direction = (targetPosition - cameraPosition).Unit
                    Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(cameraPosition + direction * smoothness), 0.1)
                end
                wait()
            end
        end
    end
})

Main:AddToggle({
    text = "Toggle",
    state = false,
    risky = false,
    tooltip = "",
    flag = "Toggle_1",
    callback = function(v)
        print(notMade)
    end
})

Main:AddList({
    enabled = true,
    text = "Aim Part",
    tooltip = "",
    selected = "Head",
    multi = false,
    open = false,
    max = 4,
    values = {"Head", "Neck", "Torso"},
    callback = function(v)
        targetPart = v
    end
})

Main:AddBind({
    enabled = true,
    text = "Lock Keybind",
    mode = "toggle",
    bind = "Mouse",
    flag = "ToggleKey_1",
    state = false,
    nomouse = false,
    noindicator = false,
    callback = function(v)
        bind = v
    end
})

Main:AddSeparator({
    enabled = true,
    text = "Checkers"
})

Main:AddToggle({
    text = "Visible Check",
    state = true,
    risky = false,
    tooltip = "If enabled, assist will only work if not behind a wall/surface.",
    flag = "wallCheck",
    callback = function(v)
        print(notMade)
    end
})

Main:AddToggle({
    text = "Status Check",
    state = true,
    risky = false,
    tooltip = "Prevent from locking on dead players",
    flag = "aliveCheck",
    callback = function(v)
        print(notMade)
    end
})

Main:AddToggle({
    text = "Whitelist",
    state = false,
    risky = false,
    tooltip = "Whitelist people away from the aimbot.",
    flag = "friendCheck",
    callback = function(v)
        print(notMade)
    end
})

Main:AddList({
    enabled = true,
    text = "Whitelist",
    tooltip = "Whitelist Here",
    selected = "",
    multi = false,
    open = false,
    max = 1,
    values = {"Friend list", "Whitelisted"},
    callback = function(v)
        print(notMade)
    end
})

LPlayer:AddSlider({
    enabled = true,
    text = "Speed",
    tooltip = "",
    flag = "LegitplrSpeed",
    suffix = "",
    dragging = true,
    focused = false,
    min = 0,
    max = 60,
    value = 16,
    increment = 0.1,
    callback = function(v)
        LegitspeedValue = v
    end
})

LPlayer:AddSlider({
    enabled = true,
    text = "Jump",
    tooltip = "",
    flag = "LegitplrJump",
    suffix = "",
    dragging = true,
    focused = false,
    min = 0,
    max = 500,
    value = 50,
    increment = 0.1,
    callback = function(v)
        LegitjumpValue = v
    end
})

LPlayer:AddToggle({
    enabled = true,
    text = "Enable Speed",
    state = false,
    callback = function(v)
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
    end
})

LPlayer:AddToggle({
    enabled = true,
    text = "Enable Jump",
    state = false,
    callback = function(v)
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
    end
})

LPlayer:AddButton({
    enabled = true,
    text = "Reset",
    tooltip = "Reset if game doesn't have reset enabled",
    confirm = true,
    risky = true,
    callback = function()
        if resetMethod == 'HP' then
            local plrHealth = LocalPlayer.Character.Humanoid.Health
            local decreaseRate = plrHealth / (HPtiming / 0.1)
            while plrHealth > 0 do
                plrHealth = plrHealth - decreaseRate
                wait(0.1)
            end
        elseif resetMethod == 'IHP' then
            LocalPlayer.Character.Humanoid.Health = 0
        elseif resetMethod == 'TP' then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, -999999999, 0)
        end
    end
})

LPlayer:AddList({
    enabled = true,
    text = "Reset method",
    tooltip = "HP - Will decrease plr hp to 0 slowly\n IHP - Same as HP but instantly\n TP - Tp plr to void",
    selected = "HP",
    multi = false,
    open = true,
    max = 3,
    values = {"HP", "IHP", "TP"},
    callback = function(v)
        resetMethod = v
    end
})

-- Additional Functions or Code for other sections...


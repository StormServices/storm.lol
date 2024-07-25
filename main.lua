-- ESP Features
local NameESP = false
local BoxESP = false
local GlowESP = false

-- Getting custom tabs
readfile('https://raw.githubusercontent.com/thraxhvh/storm.lol/main/loadAssets.lua')

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
local RFov = Tab2:AddSection("FOV", 3)
local Killer = Tab2:AddSection("Killer", 4) --[[ basically will fly around player with a fast movement to try killing it,
after it, grab to another location or just stomp and instant tp to safe location]]

local ESP = Tab3:AddSection("Enemies", 1)
local LocalEsp = Tab3:AddSection("Local", 2)

local Desync = Tab4:AddSection("Desync", 1)
local FakeLag = Tab4:AddSection("Fake Lag", 2) -- make fake lag

local Misc = Tab5:AddSection("Misc", 1) -- idk
local PlrStuff = Tab5:AddSection("Player", 2) -- make tp/view/bring
--------------------------------------------------------------------

-- Services
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--// Variables

local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local CurrentCamera = Camera
local WorldToViewportPoint = CurrentCamera.WorldToViewportPoint
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
Main:AddList({enabled = true, text = "Aim Part", tooltip = "", selected = "Head", multi = false, open = false, max = 4, values = {"Head", "Neck", "Torso"}, risky = false, callback = function(v)
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
    if v then
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
-- Continuation of script
LPlayer:AddList({enabled = true, text = "Reset method", tooltip = "HP - Will decrease plr hp to 0 slowly\n IHP - Same as HP but instantly\n TP - Tp plr to void", selected = "HP", multi = false, open = true, max = 3, values = {"HP", "IHP", "TP"}, risky = false, callback = function(v)
    resetMethod = v
end})

--// Glow ESP
local ESPSettings = {
    ChamsColor = Color3.fromRGB(200, 200, 200), -- Default Chams Color
}

function UpdateGlowESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local Highlight = player.Character:FindFirstChild("Highlight")
            
            if GlowESP then
                if Highlight then
                    if player.TeamColor then
                        Highlight.FillColor = player.TeamColor.Color
                    else
                        Highlight.FillColor = ESPSettings.ChamsColor
                    end
                else
                    Highlight = Instance.new("Highlight", player.Character)
                    if player.TeamColor then
                        Highlight.FillColor = player.TeamColor.Color
                    else
                        Highlight.FillColor = ESPSettings.ChamsColor
                    end
                end
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

--// Toggle Features
ESP:AddToggle({text = "Name Esp", state = false, risky = false, tooltip = "", flag = "NameESP", callback = function(v)
    NameESP = v
    -- Implement logic to handle Name ESP toggling
end})

ESP:AddToggle({text = "Box Esp", state = false, risky = false, tooltip = "", flag = "BoxESP", callback = function(v)
    BoxESP = v
    -- Implement logic to handle Box ESP toggling
end})

ESP:AddToggle({text = "Glow Esp", state = false, risky = false, tooltip = "", flag = "GlowESP", callback = function(v)
    GlowESP = v
end})

-- Additional Functions or Code for other sections...

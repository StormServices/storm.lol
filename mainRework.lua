-- New example script written by wally
-- You can suggest changes with a pull request or something

local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    Title = 'storm.lol',
    Center = true,
    AutoShow = true,
    TabPadding = 0
})

local Tabs = {
    Legit = Window:AddTab(" Legit "),
    Rage = Window:AddTab(" Rage "),
    Visual = Window:AddTab(" Visual "),
    AntiAim = Window:AddTab(" Anti-Aim "),
    -- Fun = Window:AddTab(" Fun "),
    Misc = Window:AddTab(" Misc "),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

-- // Legit
local Aimbot = Tabs.Legit:AddLeftGroupbox('Aimbot')
local TriggerBot = Tabs.Legit:AddRightGroupbox("Trigger Bot")
local LPlayer = Tabs.Legit:AddRightGroupbox("Player")
local LFov = Tabs.Legit:AddLeftGroupbox("FOV")
local AimCfg = Tabs.Legit:AddRightGroupbox("Config")

-- // Rage
local sAim = Tabs.Rage:AddLeftGroupbox("Rage")
local RPlayer = Tabs.Rage:AddRightGroupbox("Player") -- make fly

-- // Visuals
local Esp = Tabs.Visual:AddLeftTabbox() --                 // Add ESP Left Tab Box
local EnemiesEspTab = Esp:AddTab('Enemies') --             // Enemies ESP Left Tab Box
local TeamEspTab = Esp:AddTab('Team') --                   // Team ESP Left Tab Box
local LocalEspTab = Esp:AddTab('Local') --                 // Local ESP Left Tab Box
local Chams = Tabs.Visual:AddRightTabbox() --              // Add Chams Right Tab Box
local EnemiesChamsTab = Chams:AddTab('Enemies') --         // Enemies Chams Right Tab Box
local TeamChamsTab = Chams:AddTab('Team') --               // Team Chams Right Tab Box
local LocalChamsTab = Chams:AddTab('Local') --             // Local Chams Right Tab Box
local Glow = Tabs.Visual:AddLeftGroupbox('Glow') --        // Glow Left Group box

-- // Anti-Aim
local Desync = Tabs.AntiAim:AddLeftGroupbox("Desync")
local FakeLag = Tabs.AntiAim:AddRightGroupbox("Fake Lag") -- make fake lag

-- // Misc
local Misc = Tabs.Misc:AddLeftGroupbox("Misc") -- idk
local MiscPlayer = Tabs.Misc:AddRightGroupbox("Player")
local FakeLatency = Tabs.Misc:AddRightGroupbox("Fake Latency/Ping")

local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')
------------------------------------------------------------------------
--// Services

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--// Variables

local Camera = workspace.CurrentCamera
-- local RayIgnore = workspace.Ray_Ignore
local LocalPlayer = Players.LocalPlayer

------------------------------------------------------------------------

-- FOV Ring
local FOVring = Drawing.new("Circle")
FOVring.Visible = false
FOVring.Thickness = 1.5
FOVring.Radius = 150
FOVring.Transparency = 1
FOVring.Color = Color3.fromRGB(200, 200, 200)

-- Aim Settings
local AimSettings = {
    Enabled = false,
    WallCheck = false,
    TeamCheck = false,
    WhitelistCheck = false,
    Smoothing = 1,
    EnableFOV = false,
    FOV = 150
}

Aimbot:AddToggle('Aimbot', {Text = 'Aimbot', Default = false, Callback = function(Value)
    AimSettings.Enabled = Value
    if Value then
        FOVring.Visible = AimSettings.EnableFOV
    else
        FOVring.Visible = false
    end
end})
Aimbot:AddSlider('Smoothing', {Text = 'Smoothing', Min = 0, Max = 10, Default = 1, Rounding = 0, Callback = function(Value)
    AimSettings.Smoothing = Value
end})

Aimbot:AddDropdown('AimbotTypeDropdown', {Values = { 'Camera', 'Mouse' }, Default = 1, Multi = false, Text = 'Aimbot Type', Tooltip = 'Choose the Aim Type', Callback = function(Value)
    AimbotType = Value
end})

Aimbot:AddDropdown('Checkers', {Values = { 'Wall', 'Alive', 'Team', 'Whitelist' }, Default = 1, Multi = true, Text = 'Checkers', Tooltip = 'This will make the Aim dont work if player has something that is checked', Callback = function(Value)
    for k, v in pairs(Value) do
        AimSettings[k .. 'Check'] = v
    end
end})

Aimbot:AddDropdown('WhitelistPlayerDropdown', {SpecialType = 'Player', Text = 'Whitelist Players', Tooltip = 'Choose players to be whitelisted', Callback = function(Value)
    -- tablet.insert(SavedWhitelistTable)
end})

Aimbot:AddLabel('Aim Keybind'):AddKeyPicker('AimKeybind', {
    Default = 'MB2',
    SyncToggleState = false,
    Mode = 'Toggle', -- Modes: Always, Toggle, Hold
    Text = 'Auto lockpick safes', -- Text to display in the keybind menu
    NoUI = false, -- Set to true if you want to hide from the Keybind menu,
    Callback = function(Value)
        print('[cb] Keybind clicked!', Value)
    end,

    ChangedCallback = function(New)
        print('[cb] Keybind changed!', New)
    end
})

LFov:AddToggle('EnableFOV', {Text = 'Enable FOV', Default = false, Callback = function(Value)
    AimSettings.EnableFOV = Value
    if AimSettings.Enabled then
        FOVring.Visible = Value
    end
end})

LFov:AddSlider('FOV', {Text = 'FOV', Min = 50, Max = 300, Default = 150, Callback = function(Value)
    AimSettings.FOV = Value
    FOVring.Radius = Value
end})

RPlayer:AddToggle('SpinBot', {Text = 'Spinbot', Default = false, callback = function(v)
    SpinbotEnabled = v
    while SpinbotEnabled == true do
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            game.Players.LocalPlayer.Character.Humanoid.AutoRotate = false
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(SpinbotSpeed), 0)
        else
            game.Players.LocalPlayer.Character.Humanoid.AutoRotate = true
        end
        task.wait()
    end
end})
RPlayer:AddSlider('SpinbotSpeedd', {Text = 'Spinbot Speed', Default = 30, Min = 0, Max = 100, Rounding = 1, Compact = false, Callback = function(Value)
    SpinbotSpeed = Value
end})


Library:SetWatermarkVisibility(true)

-- Notif
Library:Notify("Thanks for purchasing storm.lol, we hope you have fun with our script!", 5)

-- Sets the watermark text
Library:SetWatermark('storm.lol')

Library.KeybindFrame.Visible = true; -- todo: add a function for this

Library:OnUnload(function()
    Library.Unloaded = true
end)

MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })

Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu
MenuGroup:AddToggle('Keybinds', {Text = 'Keybinds', Default = true, Callback = function(Value)
    Library.KeybindFrame.Visible = Value;
end})

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })

ThemeManager:SetFolder('storm.lol')
SaveManager:SetFolder('storm.lol')

SaveManager:BuildConfigSection(Tabs['UI Settings'])

ThemeManager:ApplyToTab(Tabs['UI Settings'])

SaveManager:LoadAutoloadConfig()
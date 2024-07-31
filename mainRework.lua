local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
loadstring(game:HttpGet('https://raw.githubusercontent.com/StormServices/storm.lol/main/loadAssets.lua'))()

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
    -- AntiAim = Window:AddTab(" Anti-Aim "),
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

--[[  // Anti-Aim
local Desync = Tabs.AntiAim:AddLeftGroupbox("Desync")
local FakeLag = Tabs.AntiAim:AddRightGroupbox("Fake Lag") -- make fake lag
--]]
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
local mouse = game.Players.LocalPlayer:GetMouse()

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
local EspSettings = {
    EspEnabled = false,
    tracers = false,
    nESP = false, -- name esp
    bESP = false -- box esp
}
Aimbot:AddToggle('Aimbot', {Text = 'Aimbot', Default = false, Callback = function(Value)
    AimSettings.Enabled = Value
    if Value then
        FOVring.Visible = AimSettings.EnableFOV
    else
        FOVring.Visible = false
    end
end})
Aimbot:AddSlider('Smoothing', {Text = 'Smoothing', Min = 0, Max = 10, Default = 1, Rounding = 0, Compact = false, Callback = function(Value)
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

Aimbot:AddLabel('Aim Keybind')

LFov:AddToggle('EnableFOV', {Text = 'Enable FOV', Default = false, Callback = function(Value)
    AimSettings.EnableFOV = Value
    if AimSettings.Enabled then
        FOVring.Visible = Value
    end
end})

LFov:AddSlider('FOV', {Text = 'FOV', Min = 50, Max = 300, Default = 150, Rounding = 1, Compact = false, Callback = function(Value)
    AimSettings.FOV = Value
    FOVring.Radius = Value
end})
RPlayer:AddToggle('EnableBhop', {Text = 'Bhop', Default = false, Callback = function(v)
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
RPlayer:AddSlider('BhopSpeed', {Text = 'Bhop Speed', Default = 15, Min = 0, Max = 100, Rounding = 1, Compact = false, Callback = function(Value)
    BhopSpeed = v
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
RPlayer:AddSlider('SpinbotSpeed', {Text = 'Spinbot Speed', Default = 30, Min = 0, Max = 100, Rounding = 1, Compact = false, Callback = function(Value)
    SpinbotSpeed = Value
end})

EnemiesEspTab:AddLabel('Esp') TeamEspTab:AddLabel('Esp') LocalEspTab:AddLabel('Esp') EnemiesChamsTab:AddLabel('Chams') TeamChamsTab:AddLabel('Chams') LocalChamsTab:AddLabel('Chams')
local c = workspace.CurrentCamera
local ps = game:GetService("Players")
local lp = ps.LocalPlayer
local rs = game:GetService("RunService")

local function esp(p,cr)
    local h = cr:WaitForChild("Humanoid")
    local hrp = cr:WaitForChild("HumanoidRootPart")

    local text = Drawing.new("Text")
    text.Visible = false
    text.Center = true
    text.Outline = true 
    text.Font = 2
    text.Color = Color3.fromRGB(255,255,255)
    text.Size = 13

    local c1
    local c2
    local c3

    local function dc()
        text.Visible = false
        text:Remove()
        if c1 then
            c1:Disconnect()
            c1 = nil 
        end
        if c2 then
            c2:Disconnect()
            c2 = nil 
        end
        if c3 then
            c3:Disconnect()
            c3 = nil 
        end
    end

    c2 = cr.AncestryChanged:Connect(function(_,parent)
        if not parent then
            dc()
        end
    end)

    c3 = h.HealthChanged:Connect(function(v)
        if (v<=0) or (h:GetState() == Enum.HumanoidStateType.Dead) then
            dc()
        end
    end)

    c1 = rs.RenderStepped:Connect(function()
        local hrp_pos,hrp_onscreen = c:WorldToViewportPoint(hrp.Position)
        if hrp_onscreen then
            text.Position = Vector2.new(hrp_pos.X, hrp_pos.Y)
            text.Text = p.Name
            text.Visible = true
        else
            text.Visible = false
        end
    end)
end

local function p_added(p)
    if p.Character then
        esp(p,p.Character)
    end
    p.CharacterAdded:Connect(function(cr)
        esp(p,cr)
    end)
end

EnemiesEspTab:AddToggle('EnableEsp', {Text = 'Enable Esp', Default = false, callback = function(v)
    EspSettings.EspEnabled = v
    if EspSettings.EspEnabled == false then
    end
end})

EnemiesEspTab:AddToggle('LineEsp', {Text = 'Tracer / Lines', Default = false, callback = function(v)
    EspSettings.tracers = v
end})
EnemiesEspTab:AddToggle('NameEsp', {Text = 'Name', Default = false, callback = function(v)
    if EspSettings.EspEnabled == true then
        for i,p in next, ps:GetPlayers() do 
            if p ~= lp then
                p_added(p)
            end
        end
        ps.PlayerAdded:Connect(p_added)
    else wait until EspSettings.EspEnabled == true end
end})
EnemiesEspTab:AddToggle('BoxEsp', {Text = 'Box', Default = false, callback = function(v)
    EspSettings.tracers = v   
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
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'Insert', NoUI = true, Text = 'Menu keybind' })

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
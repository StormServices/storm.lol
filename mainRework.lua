local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
loadstring(game:HttpGet('https://raw.githubusercontent.com/StormServices/storm.lol/main/loadAssets.lua'))()

isStormRunning = true

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
local EnemiesEspTab = Tabs.Visual:AddLeftTabbox() --                // Add ESP Left Tab Box
local EspTab = EnemiesEspTab:AddTab('Esp') --                       // Enemies ESP Left Tab Box
local EnemiesChamsTab = EnemiesEspTab:AddTab('Chams') --            // Enemies Chams Right Tab Box
local TeamChamsTab = EnemiesEspTab:AddTab('Glow') --                // Team Chams Right Tab Box

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
local LocalPlayer = Players.LocalPlayer
local Mouse = game.Players.LocalPlayer:GetMouse()

------------------------------------------------------------------------

-- // Create FOV Ring
local Circle = Drawing.new('Circle');

-- // Aim Settings
local AimSettings = {
    Enabled = false,
    WallCheck = false,
    TeamCheck = false,
    WhitelistCheck = false,
    Smoothing = 1,
    EnableFOV = false,
    FOV = 120
}
Aimbot:AddToggle('Aimbot', {Text = 'Aimbot', Default = false, Callback = Aimbot end})
Aimbot:AddDropdown('AimPart', {Values = {'Head', 'Torso', 'Leg'}, Default = 1, Multi = false, Text = 'Aimbot Part', Tooltip = 'Choose the part to Aim', Callback = function(Value)
    AimbotType = Value
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

LFOV:AddToggle({text = 'Show Circle', callback = showCircle
}):AddColor({color = Color3.fromRGB(255, 0, 0), trans = 1, flag = 'Circle Color', calltrans = updateCircleProp('Transparency'), callback = updateCircleProp('Color')})

LFOV:AddToggle({text = 'Rainbow Circle', callback = toggleRainbowCircle})

LFOV:AddToggle({text = 'Fill Circle', callback = updateCircleProp('Filled')})

LFOV:AddSlider({text = 'Circle Shape', value = 50, min = 4, max = 50, float = 2, callback = updateCircleProp('NumSides')})

LFOV:AddSlider({text = 'Circle Thickness', value = 1, max = 50, callback = updateCircleProp('Thickness')});
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
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.Humanoid.AutoRotate = false
            LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(SpinbotSpeed), 0)
        else
            LocalPlayer.Character.Humanoid.AutoRotate = true
        end
        task.wait() 
    end
end})
RPlayer:AddSlider('SpinbotSpeed', {Text = 'Spinbot Speed', Default = 30, Min = 0, Max = 100, Rounding = 1, Compact = false, Callback = function(Value)
    SpinbotSpeed = Value
end})
--[[EnemiesEspTab:AddToggle('EnableEsp', {Text = 'Enable Esp', Default = false, callback = function(v)
    EspSettings.EspEnabled = v
    if EspSettings.EspEnabled == false then
    end
end})
--]]
EnemiesEspTab:AddToggle('LineEsp', {Text = 'Tracer / Lines', Default = false, callback = function(v)
    EspSettings.tracers = v
end})
EnemiesEspTab:AddToggle('NameEsp', {Text = 'Name', Default = false, callback = function(v)
    if v == true then
        local c = workspace.CurrentCamera
        local ps = game:GetService("Players")
        local lp = ps.LocalPlayer
        local RunService = game:GetService("RunService")
        local espTexts = {}
        local function esp(p, cr)
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
            c1 = RunService.RenderStepped:Connect(function()
                local hrp_pos,hrp_onscreen = c:WorldToViewportPoint(hrp.Position)
                if hrp_onscreen then
                    if EspLocation == "Above" then
                        text.Position = Vector2.new(hrp_pos.X, hrp_pos.Y - 20)
                    elseif EspLocation == "Down" then
                        text.Position = Vector2.new(hrp_pos.X, hrp_pos.Y + 20)
                    end
                    text.Text = p.Name
                    text.Visible = true
                else
                    text.Visible = false
                end
            end)
            espTexts[p.UserId] = text
        end
        local function p_added(p)
            if p.Character then
                esp(p,p.Character)
            end
            p.CharacterAdded:Connect(function(cr)
                esp(p,cr)
            end)
        end
        
        ps.PlayerAdded:Connect(p_added)
        
        for _, p in pairs(ps:GetPlayers()) do
            p_added(p)
        end
    else
        for _, text in pairs(espTexts) do
            text:Remove()
        end
        espTexts = {} -- Clear the table
    end
end})
local EspLocation = "Above"

EnemiesEspTab:AddDropdown('NameEspLocation', {Values = {'Above', 'Down'}, Default = 1, Multi = false, Text = 'Location', Tooltip = 'Choose the location of the Name Esp', Callback = function(Value)
    EspLocation = Value
    -- Update the position of all existing ESP text objects
    for _, text in pairs(espTexts) do
        local p = ps:GetPlayerByUserId(tonumber(text.UserId))
        if p and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = p.Character.HumanoidRootPart
            local hrp_pos,hrp_onscreen = c:WorldToViewportPoint(hrp.Position)
            if hrp_onscreen then
                if EspLocation == "Above" then
                    text.Position = Vector2.new(hrp_pos.X, hrp_pos.Y - 20)
                elseif EspLocation == "Down" then
                    text.Position = Vector2.new(hrp_pos.X, hrp_pos.Y + 20)
                end
            end
        end
    end
end})
EnemiesEspTab:AddToggle('BoxEsp', {Text = 'Box', Default = false, callback = function(v)

end})
Library:SetWatermarkVisibility(true)

-- Notif
Library:Notify("Thanks for purchasing storm.lol, we hope you have fun with our script!", 5)
Library:Notify("Our scripts needs a good exploit/executer for some options, because not every exploit has mouseapi, so we recommend using Synapse Z", 5)
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
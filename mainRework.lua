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
    Fun = Window:AddTab(" Fun "),
    Misc = Window:AddTab(" Misc "),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

-- // Legit
local Aimbot = Tabs.Legit:AddLeftGroupbox('Aimbot')
local TriggerBot = Tabs.Legit:AddRightGroupbox("Trigger Bot")
local LPlayer = Tabs.Legit:AddRightGroupBox("Player")
local LFov = Tabs.Legit:AddLeftGroupBox("FOV")
local AimCfg = Tabs.Legit:AddRightGroupBox("Config")

-- // Rage
local sAim = Tabs.Rage:AddLeftGroupbox("Rage")
local RPlayer = Tabs.Rage:AddRightGroupbox("Player") -- make fly

-- // Visuals
local Esp = Tabs.Visual:AddLeftTabbox() --                 // Add ESP Left Tab Box
local EnemiesEspTab = Esp:AddTab('Esp - Enemies') --       // Enemies ESP Left Tab Box
local TeamEspTab = Esp:AddTab('Esp - Team') --             // Team ESP Left Tab Box
local LocalEspTab = Esp:AddTab('Esp - Local') --           // Local ESP Left Tab Box
local Chams = Tabs.Visual:AddRightTabbox() --              // Add Chams Right Tab Box
local EnemiesChamsTab = Chams:AddTab('Chams - Enemies') -- // Enemies Chams Right Tab Box
local TeamChamsTab = Chams:AddTab('Chams - Team') --       // Team Chams Right Tab Box
local LocalChamsTab = Chams:AddTab('Chams - Local') --     // Local Chams Right Tab Box
local Glow = Tabs.Visual:AddLeftGroupbox('Glow') --        // Glow Left Group box

-- // Anti-Aim
local Desync = Tabs.AntiAim:AddLeftGroupbox("Desync")
local FakeLag = Tabs.AntiAim:AddRightGroupbox("Fake Lag") -- make fake lag

-- // Misc
local Misc = Tabs.Misc:AddLeftGroupbox("Misc") -- idk
local MiscPlayer = Tabs.Misc:AddRightGroupbox("Player")
local FakeLatency = Tabs.Misc:AddRightGroupbox("Fake Latency/Ping")
------------------------------------------------------------------------
Aimbot:AddToggle('Aimbot', {Text = 'Aimbot', Default = false, Callback = function(Value)
    print('n')
end})
Aimbot:AddToggle('Aimbot', {Text = 'Toggle', Default = false, Callback = function(Value)
    print('n')
end})
Aimbot:AddDivider()
Aimbot:AddDropdown('AimbotTypeDropdown', {Values = { 'Camera', 'Mouse' }, Default = 1, Multi = false, Text = 'Aimbot Type', Tooltip = 'Choose the Aim Type', Callback = function(Value)
    AimbotType = Value
end})
Options.AimbotTypeDropdown:SetValue('Camera')
Aimbot:AddDropdown('MyMultiDropdown', { Values = { 'Wall', 'Alive', 'Team', 'Whitelist' }, Default = 1, Multi = true, Text = 'Checkers', Tooltip = 'This will make the Aim dont work if player has something that is checked', Callback = function(Value)
    print('n')
end})
Options.MyMultiDropdown:SetValue({Wall = true, Alive = true, Team = true, Whitelist = false})

Aimbot:AddDropdown('WhitelistPlayerDropdown', {SpecialType = 'Player', Text = 'Whitelist Players', Tooltip = 'Choose players to be whitelisted', Callback = function(Value)
    -- tablet.insert(SavedWhitelistTable)
end})

-- Label:AddColorPicker
-- Arguments: Idx, Info

-- You can also ColorPicker & KeyPicker to a Toggle as well

LeftGroupBox:AddLabel('Color'):AddColorPicker('ColorPicker', {
    Default = Color3.new(0, 1, 0), -- Bright green
    Title = 'Some color', -- Optional. Allows you to have a custom color picker title (when you open it)
    Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

    Callback = function(Value)
        print('[cb] Color changed!', Value)
    end
})

Options.ColorPicker:OnChanged(function()
    print('Color changed!', Options.ColorPicker.Value)
    print('Transparency changed!', Options.ColorPicker.Transparency)
end)

Options.ColorPicker:SetValueRGB(Color3.fromRGB(0, 255, 140))

-- Label:AddKeyPicker
-- Arguments: Idx, Info

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
Aimbot:AddLabel('Modes: Always, Toggle, Hold')

-- OnClick is only fired when you press the keybind and the mode is Toggle
-- Otherwise, you will have to use Keybind:GetState()
Options.KeyPicker:OnClick(function()
    print('Keybind clicked!', Options.KeyPicker:GetState())
end)

Options.KeyPicker:OnChanged(function()
    print('Keybind changed!', Options.KeyPicker.Value)
end)
Options.KeyPicker:SetValue({ 'MB2', 'Toggle' }) -- Sets keybind to MB2, mode to Hold


Library:SetWatermarkVisibility(true)

-- Notif
Library:Notify("Thanks for purchasing storm.lol, we hope you have fun with our script!", 5)

-- Sets the watermark text
Library:SetWatermark('storm.lol')

Library.KeybindFrame.Visible = true; -- todo: add a function for this

Library:OnUnload(function()
    Library.Unloaded = true
end)

-- UI Settings
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

-- I set NoUI so it does not show up in the keybinds menu
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

ThemeManager:SetFolder('MyScriptHub')
SaveManager:SetFolder('MyScriptHub/specific-game')

SaveManager:BuildConfigSection(Tabs['UI Settings'])

ThemeManager:ApplyToTab(Tabs['UI Settings'])

SaveManager:LoadAutoloadConfig()
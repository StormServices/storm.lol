-- getting custom tabs
readfile('https://raw.githubusercontent.com/thraxhvh/storm.lol/main/loadAssets.lua')

local Decimals = 4
local Clock = os.clock()
local ValueText = "Value Is Now :"
local notMade = "Error, contact staff."

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/StormServices/storm.lol/main/lib"))({
    cheatname = "storm.lol", -- watermark text
    gamename = game.Name, -- watermark text
})

library:init()

local Window1  = library.NewWindow({
    title = "storm.lol | dev version", -- Mainwindow Text
    size = UDim2.new(0, 510, 0.6, 6
)})

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

local ESP = Tab3:AddSection("ESP", 1)
local LocalEsp = Tab3:AddSection("Local", 2)
local Chams = Tab3:AddSection("Chams", 3)
local Tracer = Tab3:AddSection("Tracer", 4)
local Items = Tab3:AddSection("Items", 5)
local Locations = Tab3:AddSection("Locations", 6)
local PlrAvatar = Tab3:AddSection("Avatar", 7)
local Gun = Tab4:AddSection("Gun Visuals", 8) -- bullet tracer

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
LPlayer:AddList({enabled = true, text = "Reset method", tooltip = "HP - Will decrease plr hp to 0 slowly\n IHP - Same as HP but instantly\n TP - Tp plr to void", selected = "HP", multi = false, open = false, max = 4, values = {"HP", "IHP", "TP"}, risky = true, callback = function(v)
    resetMethod = v
end})
LPlayer:AddSlider({enabled = true, text = "HP Timing", tooltip = "How long will take for it to be 0", flag = "Slider_1", suffix = "", dragging = true, focused = false, min = 0, max = 10, increment = 0.1, risky = false, callback = function(v)
    HPtiming = v
end})

local screenWidth = workspace.CurrentCamera.ViewportSize.X
local screenHeight = workspace.CurrentCamera.ViewportSize.Y

LFov:AddToggle({text = "Show FOV", state = false, risky = false, tooltip = "", flag = "", risky = false, callback = function(v)
        if v then
            fovCircle = Drawing.new("Circle")
            fovCircle.Visible = true
            fovCircle.Name = "FOVCircle"
            fovCircle.Thickness = fovThickness
            fovCircle.Transparency = fovTransparency
            fovCircle.Color = fovColor
            fovCircle.Radius = fovRadius
            fovCircle.Position = Vector2.new(screenWidth / 2, screenHeight / 2)
        else
            if fovCircle then
                fovCircle.Visible = false
            end
        end
    end
})

LFov:AddColor({enabled = true, text = "FOV Color", tooltip = "", color = Color3.fromRGB(255, 255, 255), flag = "", trans = 0, open = false, risky = false, callback = function(v)
        fovColor = v
        if fovCircle then
            fovCircle.Color = fovColor
        end
    end
})

LFov:AddSlider({enabled = true, text = "FOV Radius", tooltip = "", min = 10, max = 200, value = 100, flag = "", risky = false, callback = function(v)
        fovRadius = v
        if fovCircle then
            fovCircle.Radius = fovRadius
        end
    end
})

LFov:AddSlider({enabled = true, text = "FOV Transparency", tooltip = "", min = 0, max = 1, value = 1, flag = "", risky = false, callback = function(v)
        fovTransparency = v
        if fovCircle then
            fovCircle.Transparency = fovTransparency
        end
    end
})

LFov:AddSlider({enabled = true, text = "FOV Thickness", tooltip = "", min = 1, max = 10, value = 1, flag = "", risky = false, callback = function(v)
        fovThickness = v
        if fovCircle then
            fovCircle.Thickness = fovThickness
        end
    end
})

AimCfg:AddToggle({text = "Prediction", state = false, risky = false, tooltip = "Prediction for games with delay on shoot", flag = "", risky = false, callback = function(v)
    predStatus = v
end})
AimCfg:AddBox({enabled = true, name = "Prediction Amount", flag = "TextBox_1", input = "", focused = true, risky = false, callback = function(v)
    predValue = v
end})
AimCfg:AddSlider({enabled = true, text = "Smoothness", tooltip = "", min = 1, max = 10, value = 5, flag = "", risky = false, callback = function(v)
    smoothness = v
end})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")
local camera = Workspace.CurrentCamera

local moveVector = Vector3.new(0, 0, 0)
local isSpeedActive = false
local speedValue = 16
local jumpPower = 50
local speedMode = "Normal"
local speedDelayTick = 0
local oldWalkSpeed = nil
local w, a, s, d = 0, 0, 0, 0
local enableSpeed = false
local speedToggle = false
local autoJumpToggle = false

local function calculateMoveVector(direction)
    local camCFrame = camera.CFrame
    local moveDirection = (camCFrame - camCFrame.p) * direction
    moveDirection = Vector3.new(moveDirection.X, 0, moveDirection.Z).Unit
    return moveDirection
end

local function stopMovement()
    moveVector = Vector3.new(0, 0, 0)
    if humanoidRootPart then
        humanoidRootPart.Velocity = Vector3.new(0, humanoidRootPart.Velocity.Y, 0)
    end
    if humanoid then
        humanoid:Move(Vector3.new(0, 0, 0), true)
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent or not enableSpeed then return end

    if input.KeyCode == Enum.KeyCode.W then
        w = -1
    elseif input.KeyCode == Enum.KeyCode.A then
        a = -1
    elseif input.KeyCode == Enum.KeyCode.S then
        s = 1
    elseif input.KeyCode == Enum.KeyCode.D then
        d = 1
    end

    if w ~= 0 or a ~= 0 or s ~= 0 or d ~= 0 then
        isSpeedActive = true
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent or not enableSpeed then return end

    if input.KeyCode == Enum.KeyCode.W then
        w = 0
    elseif input.KeyCode == Enum.KeyCode.A then
        a = 0
    elseif input.KeyCode == Enum.KeyCode.S then
        s = 0
    elseif input.KeyCode == Enum.KeyCode.D then
        d = 0
    end

    if w == 0 and a == 0 and s == 0 and d == 0 then
        isSpeedActive = false
        stopMovement()
    end
end)

local function moveCharacter(delta)
    if isSpeedActive and enableSpeed and character and humanoidRootPart then
        local movevec = calculateMoveVector(Vector3.new(a + d, 0, w + s))
        if movevec.Magnitude == 0 then
            return
        end

        if speedMode == "Velocity" then
            local currentVelocity = humanoidRootPart.Velocity
            local newVelocity = movevec * speedValue
            humanoidRootPart.Velocity = Vector3.new(newVelocity.X, currentVelocity.Y, newVelocity.Z)
        elseif speedMode == "CFrame" then
            humanoidRootPart.CFrame = humanoidRootPart.CFrame + movevec * (speedValue * delta)
        elseif speedMode == "Tp" then
            if speedDelayTick <= tick() then
                speedDelayTick = tick() + 0.1
                local newpos = movevec * (speedValue / 10)
                humanoidRootPart.CFrame = humanoidRootPart.CFrame + newpos
            end
        elseif speedMode == "Normal" then
            if oldWalkSpeed == nil then
                oldWalkSpeed = humanoid.WalkSpeed
            end
            humanoid.WalkSpeed = speedValue
            humanoid:MoveTo(humanoidRootPart.Position + movevec * speedValue * delta)
        end

        if autoJumpToggle and isSpeedActive then
            local ray = Ray.new(humanoidRootPart.Position, Vector3.down)
            local rayResult = workspace:FindPartOnRay(ray)
            if rayResult == nil then
                humanoid.Humanoid.JumpPower = jumpPower
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    elseif not isSpeedActive then
        stopMovement()
    end
end

local function toggleSpeed()
    isSpeedActive = not isSpeedActive
    if isSpeedActive then
        enableSpeed = true
    else
        enableSpeed = false
    end
end

local moveCharacterConnection
local function bindMovement()
    if moveCharacterConnection then
        moveCharacterConnection:Disconnect()
    end
    moveCharacterConnection = RunService.Heartbeat:Connect(moveCharacter)
end

local function unbindMovement()
    if moveCharacterConnection then
        moveCharacterConnection:Disconnect()
        moveCharacterConnection = nil
    end
end

player.CharacterAdded:Connect(function(char)
    character = char
    humanoidRootPart = char:WaitForChild("HumanoidRootPart")
    humanoid = char:WaitForChild("Humanoid")
    isSpeedActive = false
    w, a, s, d = 0, 0, 0, 0
    stopMovement()
    bindMovement()
end)

bindMovement()

--[[
Player:AddSlider({enabled = true, text = "Speed", tooltip = "", flag = "plrSpeed", suffix = "", dragging = true, focused = false, min = 0, max = 100, increment = 0.1, risky = false, callback = function(v)
    speedValue = v
end})
Player:AddList({enabled = true, text = "Mode", tooltip = "", selected = "Normal", multi = false, open = false, max = 4, values = {"Velocity", "CFrame", "Normal", "Tp"}, risky = false, callback = function(v)
    speedMode = v
end})
Player:AddToggle({enabled = true, text = "Enable Speed", state = false, risky = false, tooltip = "", flag = "", risky = false, callback = function(v)
    if v then
        toggleSpeed()
    end
end})
Player:AddToggle({enabled = true, text = "Auto Jump", state = false, risky = false, tooltip = "", flag = "", risky = false, callback = function(v)
    autoJumpToggle = v
end})
--]]
Player:AddSeparator({enabled = true, text = "Speed currently disabled."})
LocalEsp:AddSlider({enabled = true, text = "Field Of View ( FOV )", tooltip = "", flag = "Slider_1", suffix = "", dragging = true, focused = false, min = 0, max = 120, increment = 0.1, risky = false, callback = function(v)
    if cameraFovEnabled == true then
        game:GetService('Workspace').Camera.FieldOfView = v
    end
end})
LocalEsp:AddToggle({text = "Enable Field Of View ( FOV )", state = false, risky = false, tooltip = "", flag = "", risky = false, callback = function(v)
    cameraFovEnabled = v
    if v == false then
        game:GetService('Workspace').Camera.FieldOfView = 70
    end
end})
LocalEsp:AddSeparator({enabled = true, text = "Normal FOV: 70"})

PlrStuff:AddToggle({text = "Tp if hp is low", state = false, risky = false, tooltip = "", flag = "", risky = false, callback = function(hpToggle)
    if hpToggle == true  then
        humanoid.HealthChanged:Connect(onHealthChanged)
    else
        humanoid.HealthChanged:Disconnect(onHealthChanged)
    end
end})
PlrStuff:AddSlider({enabled = true, text = "HP Amount", tooltip = "", flag = "Slider_1", suffix = "", dragging = true, focused = false, min = 0, max = 100, increment = 0.1, risky = false, callback = function(v)
    healthThreshold = v
end})

Misc:AddToggle({text = "Freecam", state = false, risky = false, tooltip = "", flag = "", risky = false, callback = function(callback)
    if callback then
        local cameraCFrame = gameCamera.CFrame
        local pitch, yaw, roll = cameraCFrame:ToEulerAnglesYXZ()
        cameraRot = Vector2.new(pitch, yaw)
        cameraPos = cameraCFrame.p
        cameraFov = gameCamera.FieldOfView

        velSpring:Reset(Vector3.zero)
        panSpring:Reset(Vector2.new())

        playerstate.Push()
        RunLoops:BindToRenderStep("Freecam", function(dt)
            local vel = velSpring:Update(dt, Input.Vel(dt))
            local pan = panSpring:Update(dt, Input.Pan(dt))

            local zoomFactor = math.sqrt(math.tan(math.rad(70/2))/math.tan(math.rad(cameraFov/2)))

            cameraRot = cameraRot + pan*Vector2.new(0.75, 1)*8*(dt/zoomFactor)
            cameraRot = Vector2.new(math.clamp(cameraRot.x, -math.rad(90), math.rad(90)), cameraRot.y%(2*math.pi))

            local cameraCFrame = CFrame.new(cameraPos)*CFrame.fromOrientation(cameraRot.x, cameraRot.y, 0)*CFrame.new(vel*Vector3.new(1, 1, 1)*64*dt)
            cameraPos = cameraCFrame.p

            gameCamera.CFrame = cameraCFrame
            gameCamera.Focus = cameraCFrame*CFrame.new(0, 0, -GetFocusDistance(cameraCFrame))
            gameCamera.FieldOfView = cameraFov
        end)
        Input.StartCapture()
    else
        Input.StopCapture()
        RunLoops:UnbindFromRenderStep("Freecam")
        playerstate.Pop()
    end
end}):AddBind({enabled = true, text = "Test", tooltip = "tooltip1", mode = "toggle", bind = "None", flag = "ToggleKey_1", state = false, nomouse = false, risky = false, noindicator = false, callback = function(v)
    print(ValueText, v)
end, keycallback = function(v)
    print(ValueText, v) end
})

local Time = (string.format("%."..tostring(Decimals).."f", os.clock() - Clock))
library:SendNotification(("Loaded In "..tostring(Time)), 6)
    
--[[
    Window1:SetOpen(false)
    makefolder("Title Here")
    library:SetTheme(Default)
    library:GetConfig(Default)
    library:LoadConfig(Default)
    library:SaveConfig(Default)
]]

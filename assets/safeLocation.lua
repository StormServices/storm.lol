-- getting services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- plr stuff
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- platform stuff
local platformSize = Vector3.new(50, 1, 50)
local platformHeight = 100
local healthThreshold = nil -- p

local function createSafePlatform()
    local part = Instance.new("Part")
    part.Size = platformSize
    part.Anchored = true
    part.CanCollide = true
    part.Name = "SafePlatform"
    
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local platformPosition = humanoidRootPart.Position + Vector3.new(0, platformHeight, 0)
    part.Position = platformPosition
    
    part.Parent = workspace
    
    humanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 500, 0)
end

local function onHealthChanged(health)
    if health <= healthThreshold then
        createSafePlatform()
    end
end

humanoid.HealthChanged:Connect(onHealthChanged)
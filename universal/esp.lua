function UpdateGlowESP()
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
function UpdateNameESP()
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
function UpdateBoxESP()
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
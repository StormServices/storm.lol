function Spinbot()
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
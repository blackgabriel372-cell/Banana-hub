-- 🍌 BANANA HUB V2

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "BananaHubV2"

-- MAIN
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 420, 0, 320)
main.Position = UDim2.new(0.5, -210, 0.5, -160)
main.BackgroundColor3 = Color3.fromRGB(18,18,18)
main.Active = true
main.Draggable = true

-- TITLE BAR
local top = Instance.new("Frame", main)
top.Size = UDim2.new(1,0,0,40)
top.BackgroundColor3 = Color3.fromRGB(30,30,30)

local title = Instance.new("TextLabel", top)
title.Size = UDim2.new(1,-40,1,0)
title.Text = "🍌 Banana Hub V2"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1

-- CLOSE BUTTON
local close = Instance.new("TextButton", top)
close.Size = UDim2.new(0,40,1,0)
close.Position = UDim2.new(1,-40,0,0)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(150,0,0)
close.TextColor3 = Color3.new(1,1,1)

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- SCROLL
local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(1,0,1,-40)
scroll.Position = UDim2.new(0,0,0,40)
scroll.CanvasSize = UDim2.new(0,0,0,1000)
scroll.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0,5)

-- TOGGLE SYSTEM
local function createToggle(name, callback)
    local b = Instance.new("TextButton", scroll)
    b.Size = UDim2.new(1,-10,0,40)
    b.Text = "❌ "..name
    b.BackgroundColor3 = Color3.fromRGB(35,35,35)
    b.TextColor3 = Color3.new(1,1,1)

    local on = false

    b.MouseButton1Click:Connect(function()
        on = not on
        b.Text = (on and "✅ " or "❌ ")..name
        callback(on)
    end)
end

-- ⚡ FEATURES

-- SPEED
createToggle("Super Speed", function(on)
    local char = player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = on and 50 or 16
    end
end)

-- JUMP
createToggle("Super Jump", function(on)
    local char = player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.JumpPower = on and 100 or 50
    end
end)

-- FULL BRIGHT
createToggle("Full Bright", function(on)
    game.Lighting.Brightness = on and 3 or 1
    game.Lighting.ClockTime = on and 14 or 12
end)

-- NO FOG
createToggle("No Fog", function(on)
    game.Lighting.FogEnd = on and 100000 or 1000
end)

-- ANTI AFK
createToggle("Anti AFK", function(on)
    if on then
        local vu = game:GetService("VirtualUser")
        player.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
    end
end)

-- SIMPLE AUTO FARM (SAFE BASE)
createToggle("Auto Farm (Base)", function(on)
    task.spawn(function()
        while on do
            local char = player.Character
            if not char then break end

            local root = char:FindFirstChild("HumanoidRootPart")
            if not root then break end

            for _,v in pairs(workspace:GetDescendants()) do
                if v:IsA("Part") and v.Name == "FarmPart" then
                    root.CFrame = v.CFrame + Vector3.new(0,3,0)
                    task.wait(1)
                end
            end

            task.wait(0.5)
        end
    end)
end)

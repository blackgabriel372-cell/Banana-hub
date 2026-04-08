local RS = game:GetService("ReplicatedStorage")

local function newEvent(name)
    local e = Instance.new("RemoteEvent", RS)
    e.Name = name
    return e
end

local AutoFarm = newEvent("AutoFarm")
local KillAura = newEvent("KillAura")
local TPSpawn = newEvent("TPSpawn")
local AimAssist = newEvent("AimAssist")

-- AUTO FARM REAL
AutoFarm.OnServerEvent:Connect(function(player, on)
    if not on then return end
    
    task.spawn(function()
        while on do
            local char = player.Character
            if not char then break end
            
            local root = char:FindFirstChild("HumanoidRootPart")
            if not root then break end

            for _,npc in pairs(workspace:GetChildren()) do
                if npc:FindFirstChild("Humanoid") and npc ~= char then
                    npc:MoveTo(root.Position)
                    npc.Humanoid:TakeDamage(5)
                end
            end

            task.wait(0.3)
        end
    end)
end)

-- KILL AURA
KillAura.OnServerEvent:Connect(function(player, on)
    if not on then return end

    task.spawn(function()
        while on do
            local char = player.Character
            if not char then break end

            for _,v in pairs(workspace:GetChildren()) do
                if v:FindFirstChild("Humanoid") and v ~= char then
                    local dist = (char.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
                    if dist < 15 then
                        v.Humanoid:TakeDamage(10)
                    end
                end
            end

            task.wait(0.2)
        end
    end)
end)

-- TELEPORT
TPSpawn.OnServerEvent:Connect(function(player)
    if player.Character then
        player.Character:MoveTo(Vector3.new(0,50,0))
    end
end)

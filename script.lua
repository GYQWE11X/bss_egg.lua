local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local AUTO_OPEN_DIAMOND_EGG = true
local AUTO_OPEN_GOLD_EGG = true

local BSS_PLACE_ID = 1537690962
if game.PlaceId ~= BSS_PLACE_ID then
    warn("❌ Зайди в Bee Swarm Simulator и запусти скрипт снова")
    return
end

local function tryOpenEgg()
    local stats = player:FindFirstChild("leaderstats")
    if not stats then return end

    local bees = stats:FindFirstChild("Bees")
    if not bees then return end

    if AUTO_OPEN_DIAMOND_EGG and bees.Value >= 30 then
        local diamondRemote = ReplicatedStorage:FindFirstChild("DiamondEggRemote")
        if diamondRemote then
            diamondRemote:FireServer()
        end
    end

    if AUTO_OPEN_GOLD_EGG and bees.Value >= 15 then
        local goldenRemote = ReplicatedStorage:FindFirstChild("GoldenEggRemote")
        if goldenRemote then
            goldenRemote:FireServer()
        end
    end
end

task.spawn(function()
    while true do
        tryOpenEgg()
        task.wait(1)
    end
end)

local points = {
    Vector3.new(45.84, 150.22, -530.87),
    Vector3.new(81.92, 68.18, -141.20)
}

local function teleportTo(pos)
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")

    hrp.CFrame = CFrame.new(pos)
    task.wait(0.15)
    hrp.CFrame = CFrame.new(pos)
end

if not player.Character then
    player.CharacterAdded:Wait()
end

for i = 1, #points do
    teleportTo(points[i])
    task.wait(1)
end

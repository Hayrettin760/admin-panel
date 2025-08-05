local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local camera = workspace.CurrentCamera
local localPlayer = Players.LocalPlayer

local espBoxes = {}

function getRole(player)
    local backpack = player:FindFirstChild("Backpack")
    if backpack then
        if backpack:FindFirstChild("Gun") then
            return "Sheriff"
        elseif backpack:FindFirstChild("Knife") then
            return "Murderer"
        end
    end
    return "Innocent"
end

RunService.RenderStepped:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local rootPart = player.Character.HumanoidRootPart
            local pos, onScreen = camera:WorldToViewportPoint(rootPart.Position)
            if onScreen then
                if not espBoxes[player] then
                    local box = Instance.new("Frame")
                    box.Size = UDim2.new(0, 100, 0, 50)
                    box.AnchorPoint = Vector2.new(0.5, 0.5)
                    box.BackgroundTransparency = 0.5
                    box.BorderSizePixel = 1
                    box.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
                    espBoxes[player] = box
                end
                local box = espBoxes[player]
                box.Position = UDim2.new(0, pos.X, 0, pos.Y)
                local role = getRole(player)
                if role == "Murderer" then
                    box.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Katil kırmızı
                elseif role == "Sheriff" then
                    box.BackgroundColor3 = Color3.fromRGB(0, 0, 255) -- Şerif mavi
                else
                    box.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Masum yeşil
                end
                box.Visible = true
            else
                if espBoxes[player] then
                    espBoxes[player].Visible = false
                end
            end
        else
            if espBoxes[player] then
                espBoxes[player].Visible = false
            end
        end
    end
end)

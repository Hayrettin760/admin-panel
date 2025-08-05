local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local localPlayer = Players.LocalPlayer

-- Renkler
local ROLE_COLORS = {
    Murderer = Color3.fromRGB(255, 0, 0),  -- Kırmızı
    Sheriff = Color3.fromRGB(0, 0, 255)    -- Mavi
}

-- ESP yaratma fonksiyonu
local function createESP(player, role)
    if not player.Character then return end
    local head = player.Character:FindFirstChild("Head")
    if not head then return end

    -- Aynı anda sadece bir ESP olsun
    if head:FindFirstChild("RoleESP") then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "RoleESP"
    billboard.Adornee = head
    billboard.Size = UDim2.new(0, 100, 0, 30)
    billboard.AlwaysOnTop = true
    billboard.StudsOffset = Vector3.new(0, 2, 0)
    billboard.Parent = head

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = ROLE_COLORS[role] or Color3.new(1, 1, 1)
    label.TextStrokeTransparency = 0
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.Text = role == "Murderer" and "KATİL" or "ŞERİF"
    label.Parent = billboard
end

-- ESP silme fonksiyonu
local function removeESP(player)
    if not player.Character then return end
    local head = player.Character:FindFirstChild("Head")
    if not head then return end

    local esp = head:FindFirstChild("RoleESP")
    if esp then
        esp:Destroy()
    end
end

-- Oyuncunun rolünü Tool'a göre bul
local function getRole(player)
    if not player.Character then return nil end
    local tool = player.Character:FindFirstChildOfClass("Tool")
    if tool then
        if tool.Name == "Knife" then
            return "Murderer"
        elseif tool.Name == "Gun" then
            return "Sheriff"
        end
    end
    return nil
end

-- Sürekli kontrol et ve ESP güncelle
RunService.RenderStepped:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= localPlayer then
            local role = getRole(player)
            if role then
                createESP(player, role)
            else
                removeESP(player)
            end
        end
    end
end)

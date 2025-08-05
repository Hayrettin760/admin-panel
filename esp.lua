--// GUI OLUŞTUR
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "ESPGUI"

local frame = Instance.new("Frame", gui)
frame.Position = UDim2.new(0, 20, 0, 100)
frame.Size = UDim2.new(0, 160, 0, 200)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "ESP Kontrol"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundColor3 = Color3.fromRGB(50,50,50)
title.BorderSizePixel = 0

--// Renk Düğmeleri
local colors = {
    {Name = "Kırmızı", Color = Color3.fromRGB(255, 0, 0)},
    {Name = "Yeşil", Color = Color3.fromRGB(0, 255, 0)},
    {Name = "Mavi", Color = Color3.fromRGB(0, 0, 255)},
    {Name = "Sarı", Color = Color3.fromRGB(255, 255, 0)},
}

local toggle = true
local currentColor = colors[1].Color

function updateAllESP()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character then
            local old = player.Character:FindFirstChild("ESPHighlight")
            if old then old:Destroy() end

            if toggle then
                local h = Instance.new("Highlight")
                h.Name = "ESPHighlight"
                h.Adornee = player.Character
                h.FillColor = currentColor
                h.FillTransparency = 0.5
                h.OutlineColor = Color3.new(1,1,1)
                h.OutlineTransparency = 0
                h.Parent = player.Character
            end
        end
    end
end

for i, info in ipairs(colors) do
    local button = Instance.new("TextButton", frame)
    button.Size = UDim2.new(1, -20, 0, 30)
    button.Position = UDim2.new(0, 10, 0, 30 + i * 35)
    button.Text = info.Name
    button.BackgroundColor3 = info.Color
    button.TextColor3 = Color3.new(1,1,1)
    button.MouseButton1Click:Connect(function()
        currentColor = info.Color
        updateAllESP()
    end)
end

-- Aç/Kapat butonu
local toggleBtn = Instance.new("TextButton", frame)
toggleBtn.Size = UDim2.new(1, -20, 0, 30)
toggleBtn.Position = UDim2.new(0, 10, 1, -40)
toggleBtn.Text = "ESP: Açık"
toggleBtn.BackgroundColor3 = Color3.fromRGB(100,100,100)
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.MouseButton1Click:Connect(function()
    toggle = not toggle
    toggleBtn.Text = "ESP: " .. (toggle and "Açık" or "Kapalı")
    updateAllESP()
end)

-- Başlangıçta oyunculara ESP uygula
updateAllESP()

-- Yeni oyunculara uygulama
game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        wait(1)
        updateAllESP()
    end)
end)

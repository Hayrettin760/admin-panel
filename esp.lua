-- LocalScript içinde çalışacak bir ESP scripti

local Players = game:GetService("Players")
local Camera = game:GetService("Workspace").CurrentCamera
local RunService = game:GetService("RunService")

-- Kırmızı renk tanımlaması
local Red = Color3.fromRGB(255, 0, 0)

-- ESP kutusunu oluşturma fonksiyonu
local function createESP(player)
    -- Oyuncunun karakterinin etrafında bir Frame oluşturma
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end

    -- ESP kutusunun oluşturulması
    local espFrame = Instance.new("Frame")
    espFrame.Size = UDim2.new(0, 100, 0, 100)  -- Başlangıç boyutu
    espFrame.Position = UDim2.new(0, 0, 0, 0)  -- Başlangıç pozisyonu
    espFrame.BackgroundColor3 = Red
    espFrame.BackgroundTransparency = 0.5  -- Yarı şeffaf kutu
    espFrame.BorderSizePixel = 0
    espFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    espFrame.Visible = true

    -- Yumuşak kenar efekti ekleyelim
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)  -- Yumuşak köşe
    corner.Parent = espFrame

    -- ESP kutusunu oyuncunun GUI'sine ekliyoruz
    espFrame.Parent = game.Players.LocalPlayer.PlayerGui

    -- Sürekli oyuncuyu takip etme (Character'nin hareketini izleme)
    local function updatePosition()
        if character and character:FindFirstChild("HumanoidRootPart") then
            -- Ekrandaki pozisyonu güncelle
            local screenPosition, onScreen = Camera:WorldToScreenPoint(character.HumanoidRootPart.Position)
            -- Ekran dışı olsa da ESP kutusunu göster
            espFrame.Position = UDim2.new(0, screenPosition.X, 0, screenPosition.Y)
            espFrame.Visible = true  -- Her durumda görünür yapıyoruz
        else
            espFrame:Destroy()  -- Eğer karakter yoksa ESP'yi yok et
        end
    end

    -- Sürekli olarak güncelleme
    RunService.RenderStepped:Connect(updatePosition)
end

-- ESP'nin hangi oyunculara uygulanacağını belirleyelim
for _, player in pairs(Players:GetPlayers()) do
    if player ~= Players.LocalPlayer then
        createESP(player)
    end
end

-- Yeni bir oyuncu eklenirse, onun için de ESP oluşturulacak
Players.PlayerAdded:Connect(function(player)
    if player ~= Players.LocalPlayer then
        createESP(player)
    end
end)

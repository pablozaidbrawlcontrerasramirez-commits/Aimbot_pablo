
--[[
    PABLO_VOID 💀
    Roblox Studio - LocalScript
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PABLO_VOID"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Ventana principal
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 300, 0, 330)
Main.Position = UDim2.new(0.5, -150, 0.5, -165)
Main.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = Main

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 55)
Title.BackgroundColor3 = Color3.fromRGB(35, 25, 45)
Title.Text = "PABLO_VOID 💀"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 23
Title.Font = Enum.Font.GothamBold
Title.Parent = Main

-- Botones
local function CreateButton(name, position, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 260, 0, 42)
    Button.Position = UDim2.new(0, 20, 0, position)
    Button.BackgroundColor3 = Color3.fromRGB(55, 40, 70)
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.TextSize = 15
    Button.Font = Enum.Font.GothamBold
    Button.Text = name .. " : OFF"
    Button.Parent = Main

    Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 8)

    local enabled = false

    Button.MouseButton1Click:Connect(function()
        enabled = not enabled
        Button.Text = name .. (enabled and " : ON" or " : OFF")
        callback(enabled)
    end)

    return Button
end

local ESPEnabled = false
local LinesEnabled = false

-- ESP visual para jugadores de tu propio juego
local function UpdateESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local character = player.Character

            local highlight = character:FindFirstChild("PabloVoidHighlight")

            if ESPEnabled then
                if not highlight then
                    highlight = Instance.new("Highlight")
                    highlight.Name = "PabloVoidHighlight"
                    highlight.FillColor = Color3.fromRGB(150, 60, 255)
                    highlight.OutlineColor = Color3.new(1, 1, 1)
                    highlight.Parent = character
                end
            elseif highlight then
                highlight:Destroy()
            end
        end
    end
end

CreateButton("PLAYER ESP", 75, function(state)
    ESPEnabled = state
    UpdateESP()
end)

CreateButton("TRACER LINES", 125, function(state)
    LinesEnabled = state
end)

CreateButton("HEAD AIM", 175, function(state)
    print("Head Aim visual:", state)
end)

CreateButton("SPIN EFFECT", 225, function(state)
    print("Spin Effect:", state)
end)

CreateButton("CLOSE MENU", 275, function()
    ScreenGui:Destroy()
end)

RunService.Heartbeat:Connect(function()
    if ESPEnabled then
        UpdateESP()
    end
end)

print("PABLO_VOID 💀 Loaded")

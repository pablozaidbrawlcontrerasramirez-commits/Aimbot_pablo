--[[
    PABLO_VOID 💀
    Roblox Studio - LocalScript
]]

local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PABLO_VOID"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(230, 260)
Main.Position = UDim2.new(0.5, -115, 0.5, -130)
Main.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui

Instance.new("UICorner", Main).CornerRadius =
    UDim.new(0, 12)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 42)
Title.BackgroundColor3 = Color3.fromRGB(65, 35, 100)
Title.Text = "PABLO_VOID 💀"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.Parent = Main

local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.fromOffset(30, 30)
Minimize.Position = UDim2.new(1, -35, 0, 6)
Minimize.Text = "-"
Minimize.Parent = Main

local minimized = false

Minimize.MouseButton1Click:Connect(function()
    minimized = not minimized
    Main.Size = minimized
        and UDim2.fromOffset(230, 42)
        or UDim2.fromOffset(230, 260)
end)

local ESPEnabled = false

local function UpdateESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local character = player.Character
            local highlight =
                character:FindFirstChild("PabloVoidHighlight")

            if ESPEnabled and not highlight then
                highlight = Instance.new("Highlight")
                highlight.Name = "PabloVoidHighlight"
                highlight.FillColor =
                    Color3.fromRGB(150, 60, 255)
                highlight.OutlineColor =
                    Color3.new(1, 1, 1)
                highlight.Parent = character

            elseif not ESPEnabled and highlight then
                highlight:Destroy()
            end
        end
    end
end

local function CreateButton(name, y, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -24, 0, 32)
    Button.Position = UDim2.fromOffset(12, y)
    Button.BackgroundColor3 = Color3.fromRGB(55, 40, 75)
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 13
    Button.Text = name .. " : OFF"
    Button.Parent = Main

    Instance.new("UICorner", Button).CornerRadius =
        UDim.new(0, 7)

    local enabled = false

    Button.MouseButton1Click:Connect(function()
        enabled = not enabled
        Button.Text = name ..
            (enabled and " : ON" or " : OFF")
        callback(enabled)
    end)
end

CreateButton("PLAYER ESP", 52, function(state)
    ESPEnabled = state
    UpdateESP()
end)

CreateButton("TRACER LINES", 91, function(state)
    print("Tracer Lines:", state)
end)

CreateButton("HEAD AIM", 130, function(state)
    print("Head Aim requires game-side targeting logic:", state)
end)

CreateButton("TEAM CHECK", 169, function(state)
    print("Team Check:", state)
end)

CreateButton("WALL CHECK", 208, function(state)
    print("Wall Check:", state)
end)

Players.PlayerAdded:Connect(function()
    task.wait(1)
    UpdateESP()
end)

print("PABLO_VOID 💀 Loaded")

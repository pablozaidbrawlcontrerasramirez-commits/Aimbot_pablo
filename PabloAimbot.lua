--[[
    PABLO_VOID 💀
    Roblox Studio - LocalScript
]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Gui = Instance.new("ScreenGui")
Gui.Name = "PABLO_VOID"
Gui.ResetOnSpawn = false
Gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(230, 260)
Main.Position = UDim2.new(0.5, -115, 0.5, -130)
Main.BackgroundColor3 = Color3.fromRGB(18,18,24)
Main.Active = true
Main.Draggable = true
Main.Parent = Gui

Instance.new("UICorner", Main).CornerRadius =
    UDim.new(0, 12)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,42)
Title.BackgroundColor3 = Color3.fromRGB(65,35,100)
Title.Text = "PABLO_VOID 💀"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 17
Title.Parent = Main

local Min = Instance.new("TextButton")
Min.Size = UDim2.fromOffset(30,30)
Min.Position = UDim2.new(1,-35,0,6)
Min.Text = "-"
Min.Parent = Main

local minimized = false

local function CreateButton(name, y, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1,-24,0,32)
    b.Position = UDim2.fromOffset(12,y)
    b.BackgroundColor3 = Color3.fromRGB(55,40,75)
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 13
    b.Text = name .. " : OFF"
    b.Parent = Main

    Instance.new("UICorner",b).CornerRadius =
        UDim.new(0,7)

    local enabled = false

    b.MouseButton1Click:Connect(function()
        enabled = not enabled
        b.Text = name .. (enabled and " : ON" or " : OFF")
        callback(enabled)
    end)
end

Min.MouseButton1Click:Connect(function()
    minimized = not minimized

    for _,v in ipairs(Main:GetChildren()) do
        if v ~= Title and v ~= Min then
            v.Visible = not minimized
        end
    end

    Main.Size = minimized
        and UDim2.fromOffset(230,42)
        or UDim2.fromOffset(230,260)

    Min.Text = minimized and "+" or "-"
end)

local ESP = false

local function UpdateESP()
    for _,p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local h = p.Character:FindFirstChild("PabloHighlight")

            if ESP and not h then
                h = Instance.new("Highlight")
                h.Name = "PabloHighlight"
                h.FillColor = Color3.fromRGB(150,60,255)
                h.OutlineColor = Color3.new(1,1,1)
                h.Parent = p.Character
            elseif not ESP and h then
                h:Destroy()
            end
        end
    end
end

CreateButton("PLAYER ESP",52,function(state)
    ESP = state
    UpdateESP()
end)

CreateButton("TRACER LINES",91,function(state)
    print("Tracer Lines:",state)
end)

CreateButton("HEAD AIM",130,function(state)
    print("Training NPC Aim:",state)
end)

CreateButton("TEAM CHECK",169,function(state)
    print("Team Check:",state)
end)

CreateButton("WALL CHECK",208,function(state)
    print("Wall Check:",state)
end)

Players.PlayerAdded:Connect(function()
    task.wait(1)
    UpdateESP()
end)

print("PABLO_VOID 💀 Loaded")

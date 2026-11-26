
-- PABLO_VOID 💀
-- Entrenamiento visual para NPC en Roblox Studio

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local npcFolder = workspace:WaitForChild("TrainingNPCs")

local settings = {
    ESP = true,
    TRACERS = true,
    FOV = true,
    HEAD_AIM = true,
    TEAM_CHECK = true,
    WALL_CHECK = true
}

local gui = Instance.new("ScreenGui")
gui.Name = "PABLO_VOID"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(250, 300)
main.Position = UDim2.new(0.5, -125, 0.5, -150)
main.BackgroundColor3 = Color3.fromRGB(22, 12, 35)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -75, 0, 40)
title.Position = UDim2.fromOffset(10, 0)
title.BackgroundTransparency = 1
title.Text = "PABLO_VOID 💀"
title.TextColor3 = Color3.fromRGB(210, 150, 255)
title.TextSize = 19
title.Font = Enum.Font.GothamBold
title.Parent = main

local minimize = Instance.new("TextButton")
minimize.Size = UDim2.fromOffset(30, 28)
minimize.Position = UDim2.new(1, -38, 0, 6)
minimize.Text = "−"
minimize.TextSize = 22
minimize.TextColor3 = Color3.new(1,1,1)
minimize.BackgroundColor3 = Color3.fromRGB(90, 40, 130)
minimize.Parent = main

local list = Instance.new("Frame")
list.Position = UDim2.fromOffset(10, 48)
list.Size = UDim2.new(1, -20, 1, -58)
list.BackgroundTransparency = 1
list.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 6)
layout.Parent = list

local function makeButton(label, key)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 32)
    button.BackgroundColor3 = Color3.fromRGB(55, 30, 75)
    button.TextColor3 = Color3.new(1,1,1)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 13
    button.Parent = list

    local function refresh()
        button.Text = label .. ": " ..
            (settings[key] and "ON" or "OFF")
        button.BackgroundColor3 = settings[key]
            and Color3.fromRGB(110, 55, 160)
            or Color3.fromRGB(55, 30, 75)
    end

    refresh()

    button.MouseButton1Click:Connect(function()
        settings[key] = not settings[key]
        refresh()
    end)
end

makeButton("PLAYER ESP (NPC)", "ESP")
makeButton("TRACER LINES", "TRACERS")
makeButton("AIM FOV", "FOV")
makeButton("HEAD AIM (TRAINING)", "HEAD_AIM")
makeButton("TEAM CHECK", "TEAM_CHECK")
makeButton("WALL CHECK", "WALL_CHECK")

local minimized = false

minimize.MouseButton1Click:Connect(function()
    minimized = not minimized
    list.Visible = not minimized
    main.Size = minimized
        and UDim2.fromOffset(250, 42)
        or UDim2.fromOffset(250, 300)
    minimize.Text = minimized and "+" or "−"
end)

-- Círculo FOV visual
local fov = Instance.new("Frame")
fov.Name = "FOV"
fov.Size = UDim2.fromOffset(160, 160)
fov.AnchorPoint = Vector2.new(0.5, 0.5)
fov.Position = UDim2.fromScale(0.5, 0.5)
fov.BackgroundTransparency = 1
fov.Visible = false
fov.Parent = gui

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(190, 100, 255)
stroke.Thickness = 2
stroke.Parent = fov

local fovCorner = Instance.new("UICorner")
fovCorner.CornerRadius = UDim.new(1, 0)
fovCorner.Parent = fov

-- ESP y trazadores para NPC
local visuals = {}

local function clearVisuals()
    for npc, objects in pairs(visuals) do
        for _, object in ipairs(objects) do
            object:Destroy()
        end
        visuals[npc] = nil
    end
end

local function createVisual(npc)
    if visuals[npc] or not npc:IsA("Model") then return end

    local highlight = Instance.new("Highlight")
    highlight.Adornee = npc
    highlight.FillColor = Color3.fromRGB(150, 60, 220)
    highlight.OutlineColor = Color3.new(1, 1, 1)
    highlight.Enabled = settings.ESP
    highlight.Parent = gui

    local line = Drawing and Drawing.new and Drawing.new("Line")
    if line then
        line.Color = Color3.fromRGB(190, 100, 255)
        line.Thickness = 1.5
        line.Visible = false
    end

    visuals[npc] = {highlight, line}
end

RunService.RenderStepped:Connect(function()
    fov.Visible = settings.FOV

    for _, npc in ipairs(npcFolder:GetChildren()) do
        createVisual(npc)
    end

    for npc, objects in pairs(visuals) do
        if not npc.Parent then
            for _, object in ipairs(objects) do
                if object then object:Destroy() end
            end
            visuals[npc] = nil
        else
            local highlight = objects[1]
            highlight.Enabled = settings.ESP

            local line = objects[2]
            if line then
                local head = npc:FindFirstChild("Head")
                if settings.TRACERS and head then
                    local point, visible =
                        camera:WorldToViewportPoint(head.Position)
                    line.From = Vector2.new(
                        camera.ViewportSize.X / 2,
                        camera.ViewportSize.Y
                    )
                    line.To = Vector2.new(point.X, point.Y)
                    line.Visible = visible
                else
                    line.Visible = false
                end
            end
        end
    end
end)

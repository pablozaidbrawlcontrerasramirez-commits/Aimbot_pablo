local player = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "PABLO_VOID"
gui.Parent = player:WaitForChild("PlayerGui")

local label = Instance.new("TextLabel")
label.Size = UDim2.fromOffset(250, 60)
label.Position = UDim2.new(0.5, -125, 0.5, -30)
label.Text = "PABLO_VOID 💀"
label.TextScaled = true
label.BackgroundColor3 = Color3.fromRGB(55, 20, 85)
label.TextColor3 = Color3.new(1, 1, 1)
label.Parent = gui

-- EMPEROR HUB (Tabs + Animation + أيقونة قابلة للسحب + حركة عند الضغط)
local TweenService = game:GetService("TweenService")
local RS = game:GetService("RunService")
local Players = game:GetService("Players")

local pl = Players.LocalPlayer
local char = pl.Character or pl.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- BillboardGui لعرض الاسم والبايو
local BillboardGui = Instance.new("BillboardGui", hrp)
BillboardGui.Size = UDim2.new(0,200,0,50)
BillboardGui.StudsOffset = Vector3.new(0,3,0)
BillboardGui.AlwaysOnTop = true

local NameLabel = Instance.new("TextLabel", BillboardGui)
NameLabel.Size = UDim2.new(1,0,0.5,0)
NameLabel.Text = "- المطور WABU_ALHASAN"
NameLabel.TextColor3 = Color3.fromRGB(255,0,0)
NameLabel.BackgroundTransparency = 1
NameLabel.TextScaled = true

local BioLabel = Instance.new("TextLabel", BillboardGui)
BioLabel.Size = UDim2.new(1,0,0.5,0)
BioLabel.Position = UDim2.new(0,0,0.5,0)
BioLabel.Text = "- الدس الخاص بالمطور.(.1.h_)"
BioLabel.TextColor3 = Color3.fromRGB(0,255,0)
BioLabel.BackgroundTransparency = 1
BioLabel.TextScaled = true

task.delay(5, function()
    local info = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    TweenService:Create(NameLabel, info, {TextTransparency=1}):Play()
    TweenService:Create(BioLabel, info, {TextTransparency=1}):Play()
    task.wait(1)
    BillboardGui:Destroy()
end)

-- GUI الرئيسي
local sg = Instance.new("ScreenGui", game.CoreGui)
sg.Name = "EMPEROR_HUB"

local mainFrame = Instance.new("Frame", sg)
mainFrame.Size = UDim2.new(0,400,0,260)
mainFrame.Position = UDim2.new(0,-420,0.5,-130)
mainFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true

local sideBar = Instance.new("Frame", mainFrame)
sideBar.Size = UDim2.new(0,100,1,0)
sideBar.Position = UDim2.new(0,0,0,0)
sideBar.BackgroundColor3 = Color3.fromRGB(20,20,20)
sideBar.BorderSizePixel = 0

local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Size = UDim2.new(1,-100,1,0)
contentFrame.Position = UDim2.new(0,100,0,0)
contentFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
contentFrame.BorderSizePixel = 0

-- Toggle Button (≡) قابل للسحب
local toggleBtn = Instance.new("TextButton", sg)
toggleBtn.Size = UDim2.new(0,50,0,50)
toggleBtn.Position = UDim2.new(0,20,0.5,-25)
toggleBtn.Text = "≡"
toggleBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.TextScaled = true

local dragging = false
local dragInput, mousePos, framePos

toggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        mousePos = input.Position
        framePos = toggleBtn.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

toggleBtn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

RS.RenderStepped:Connect(function()
    if dragging and dragInput then
        local delta = dragInput.Position - mousePos
        toggleBtn.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
    end
end)

-- التبويبات
local tabs = {}
local function createTab(name, callback)
    local btn = Instance.new("TextButton", sideBar)
    btn.Size = UDim2.new(1,0,0,35)
    btn.Position = UDim2.new(0,0,0,(#sideBar:GetChildren()-1)*35)
    btn.Text = name
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
    btn.BorderSizePixel = 0
    btn.MouseButton1Click:Connect(function()
        for _,child in pairs(contentFrame:GetChildren()) do
            child:Destroy()
        end
        callback()
    end)
    table.insert(tabs, btn)
end

-- مثال تبويب ترحيب
createTab("ترحيب", function()
    local lbl = Instance.new("TextLabel", contentFrame)
    lbl.Size = UDim2.new(1,0,1,0)
    lbl.Text = "سكربت EMPEROR يرحب بكم 🌟"
    lbl.TextColor3 = Color3.new(1,1,1)
    lbl.TextScaled = true
    lbl.BackgroundTransparency = 1
end)

-- حركة القائمة عند الضغط على Toggle
local menuOpen = false
toggleBtn.MouseButton1Click:Connect(function()
    local mainGoal = {}
    if menuOpen then
        mainGoal.Position = UDim2.new(0,-420,0.5,-130)
    else
        mainGoal.Position = UDim2.new(0,20,0.5,-130)
    end
    menuOpen = not menuOpen
    TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), mainGoal):Play()
end)

-- ألوان Rainbow
RS.RenderStepped:Connect(function()
    local t = tick()
    mainFrame.BackgroundColor3 = Color3.fromHSV(t%5/5,1,1)
    sideBar.BackgroundColor3 = Color3.fromHSV(t%5/5,1,1)
    toggleBtn.BackgroundColor3 = Color3.fromHSV(t%5/5,1,1)
end)

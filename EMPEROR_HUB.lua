-- EMPEROR HUB (تصميم Tabs + Animation + جميع التعديلات)
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local Players = game:GetService("Players")

local pl = Players.LocalPlayer
local char = pl.Character or pl.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")

-- عرض الاسم والبايو فوق الرأس
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

-- يخفي بعد 5 ثواني مع تأثير Fade Out
task.delay(5, function()
    local info = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    local goal = {TextTransparency = 1}

    TweenService:Create(NameLabel, info, goal):Play()
    TweenService:Create(BioLabel, info, goal):Play()

    task.wait(1)
    BillboardGui:Destroy()
end)

-- GUI
local sg = Instance.new("ScreenGui", game.CoreGui)
sg.Name = "EMPEROR_HUB"

local mainFrame = Instance.new("Frame", sg)
mainFrame.Size = UDim2.new(0, 400, 0, 260)
mainFrame.Position = UDim2.new(0, -420, 0.5, -130)
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

local toggleBtn = Instance.new("TextButton", sg)
toggleBtn.Size = UDim2.new(0,50,0,50)
toggleBtn.Position = UDim2.new(0,20,0.5,-25)
toggleBtn.Text = "≡"
toggleBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.TextScaled = true

-- دوال التبويبات والأزرار
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

local function addScriptButton(parent, name, url, y)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1,-20,0,30)
    btn.Position = UDim2.new(0,10,0,y)
    btn.Text = name
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
    btn.BorderSizePixel = 0
    btn.MouseButton1Click:Connect(function()
        setclipboard(url)
        loadstring(game:HttpGet(url))()
    end)
end

-- إنشاء التبويبات
createTab("ترحيب", function()
    local lbl = Instance.new("TextLabel", contentFrame)
    lbl.Size = UDim2.new(1,0,1,0)
    lbl.Text = "سكربت EMPEROR يرحب بكم 🌟\nمنور السكربت\nاتمنى لك تستمتع بالاستخدام"
    lbl.TextColor3 = Color3.new(1,1,1)
    lbl.TextScaled = true
    lbl.BackgroundTransparency = 1
end)

createTab("ماب بيوت", function()
    addScriptButton(contentFrame, "سكربت ماب بيوت", "https://rawscripts.net/raw/Brookhaven-RP-NetroZHub-49812", 20)
    addScriptButton(contentFrame, "سكربت مارتن العراقي", "https://rawscripts.net/raw/Brookhaven-RP-MARTIN-IRAQ-31476", 60)
    addScriptButton(contentFrame, "سكربت S7 ماب بيوت", "https://rawscripts.net/raw/Brookhaven-RP-S7-hub-30753", 100)
    addScriptButton(contentFrame, "سكربت اسطوري", "https://rawscripts.net/raw/Brookhaven-RP-K0-41546", 140)
    addScriptButton(contentFrame, "سكربت ماب بيوت تخريب OPP", "https://rawscripts.net/raw/Universal-Script-SH-HUB-44927", 180)
    addScriptButton(contentFrame, "-سكربت سايكو اسطوري-", "https://rawscripts.net/raw/Brookhaven-RP-Siko-hub-48511", 220)
end)

createTab("بلوكس فروت", function()
    addScriptButton(contentFrame, "سكربت بلوكس فروت", "https://zuwz.me/Ls-Zee-Hub", 20)
end)

createTab("ماب سرقة", function()
    addScriptButton(contentFrame, "سكربت ماب سرقة اسطوري - RTX", "https://raw.githubusercontent.com/RTX261/RTXTOP1/refs/heads/main/RTX", 20)
end)

createTab("ماب مزرعة", function()
    addScriptButton(contentFrame, "سكربت ماب مزرعه سبيد هوب", "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", 20)
    addScriptButton(contentFrame, "سكربت ماب مزرعه نو لاغ", "https://raw.githubusercontent.com/NoLagHubID/No-LagHUB/refs/heads/main/LoaderV1.lua", 60)
end)

createTab("اخرى", function()
    addScriptButton(contentFrame, "سكربت VR7", "https://raw.githubusercontent.com/VR7ss/OMK/refs/heads/main/VR7-ON-TOP", 20)
    addScriptButton(contentFrame, "سكربت مضاد رهيب و غيره", "https://rawscripts.net/raw/Universal-Script-JanHub-32893", 60)
    addScriptButton(contentFrame, "سكربت نسخ ادمن-مابات ادمن فقط! 🔥", "https://pastebin.com/raw/67zRS6vS", 100)
end)

createTab("ديسكورد", function()
    local lbl = Instance.new("TextLabel", contentFrame)
    lbl.Size = UDim2.new(1,0,1,0)
    lbl.Text = "سيرفرنا: discord.gg/wYQyuh48t4"
    lbl.TextColor3 = Color3.fromRGB(0,255,0)
    lbl.TextScaled = true
    lbl.BackgroundTransparency = 1
end)

-- Animation القائمة
local menuOpen = false
toggleBtn.MouseButton1Click:Connect(function()
    local goal = {}
    if menuOpen then
        goal.Position = UDim2.new(0, -420, 0.5, -130)
    else
        goal.Position = UDim2.new(0, 20, 0.5, -130)
    end
    menuOpen = not menuOpen
    TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), goal):Play()
end)

-- ألوان rainbow
local function rainbowColor()
    local t = tick()
    return Color3.fromHSV(t%5/5,1,1)
end

RS.RenderStepped:Connect(function()
    mainFrame.BackgroundColor3 = rainbowColor()
    sideBar.BackgroundColor3 = rainbowColor()
    toggleBtn.BackgroundColor3 = rainbowColor()
end)

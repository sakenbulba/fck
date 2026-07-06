local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()
local isMobile = UserInputService.TouchEnabled

local Settings = {
    FOV = 180,
    MaxDistance = 120,
    AimPart = "Head",
    Speed = 35,
    ESP = false,
    Aimbot = false,
    Trigger = false,
    SilentAim = false,
    Prediction = false,
    NoRecoil = false,
    NoSpread = false,
    RapidFire = false,
    AutoReload = false,
    SpeedHack = false,
    AntiAFK = false,
    AntiStun = true,
    IgnoreLowHP = true,
    TriggerDelay = 0.01,
    BindAimbot = nil,
    BindTrigger = nil,
    IconPos = UDim2.new(1, -50, 0, 10),
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "DaHoodMenu"

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 640, 0, 460)
MainFrame.Position = UDim2.new(0.5, -320, 0.5, -230)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(50, 50, 50)
MainFrame.Visible = true
MainFrame.Parent = ScreenGui
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 14)
mainCorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 220, 0, 40)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "✦ DAHOOD ULTIMATE ✦"
Title.TextColor3 = Color3.fromRGB(0, 200, 255)
Title.TextScaled = true
Title.Font = Enum.Font.Gotham
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

local dragging = false
local dragStart, startPos
Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 40, 0, 40)
MinimizeBtn.Position = UDim2.new(1, -50, 0, 5)
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Text = ""
MinimizeBtn.Parent = MainFrame
local flagTop = Instance.new("Frame")
flagTop.Size = UDim2.new(1, 0, 0.5, 0)
flagTop.Position = UDim2.new(0, 0, 0, 0)
flagTop.BackgroundColor3 = Color3.fromRGB(0, 87, 183)
flagTop.BorderSizePixel = 0
flagTop.Parent = MinimizeBtn
local flagBottom = Instance.new("Frame")
flagBottom.Size = UDim2.new(1, 0, 0.5, 0)
flagBottom.Position = UDim2.new(0, 0, 0.5, 0)
flagBottom.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
flagBottom.BorderSizePixel = 0
flagBottom.Parent = MinimizeBtn
local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(1, 0)
minCorner.Parent = MinimizeBtn

local isMinimized = false
local minimizeTarget = nil
MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        minimizeTarget = Instance.new("TextButton")
        minimizeTarget.Size = UDim2.new(0, 40, 0, 40)
        minimizeTarget.Position = Settings.IconPos
        minimizeTarget.BackgroundTransparency = 1
        minimizeTarget.Text = ""
        minimizeTarget.Parent = ScreenGui
        local ft = Instance.new("Frame")
        ft.Size = UDim2.new(1, 0, 0.5, 0)
        ft.Position = UDim2.new(0, 0, 0, 0)
        ft.BackgroundColor3 = Color3.fromRGB(0, 87, 183)
        ft.BorderSizePixel = 0
        ft.Parent = minimizeTarget
        local fb = Instance.new("Frame")
        fb.Size = UDim2.new(1, 0, 0.5, 0)
        fb.Position = UDim2.new(0, 0, 0.5, 0)
        fb.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
        fb.BorderSizePixel = 0
        fb.Parent = minimizeTarget
        local minTargetCorner = Instance.new("UICorner")
        minTargetCorner.CornerRadius = UDim.new(1, 0)
        minTargetCorner.Parent = minimizeTarget

        local dragIcon = false
        local dragStartIcon, startPosIcon
        minimizeTarget.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragIcon = true
                dragStartIcon = input.Position
                startPosIcon = minimizeTarget.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then dragIcon = false end
                end)
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if dragIcon and input.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = input.Position - dragStartIcon
                local newPos = UDim2.new(startPosIcon.X.Scale, startPosIcon.X.Offset + delta.X, startPosIcon.Y.Scale, startPosIcon.Y.Offset + delta.Y)
                minimizeTarget.Position = newPos
                Settings.IconPos = newPos
            end
        end)
        minimizeTarget.MouseButton1Click:Connect(function()
            isMinimized = false
            minimizeTarget:Destroy()
            MainFrame.Visible = true
        end)
        MainFrame.Visible = false
    else
        if minimizeTarget then minimizeTarget:Destroy() end
        MainFrame.Visible = true
    end
end)

local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(0, 110, 1, -50)
TabContainer.Position = UDim2.new(0, 10, 0, 45)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -130, 1, -55)
ContentFrame.Position = UDim2.new(0, 120, 0, 45)
ContentFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
ContentFrame.BackgroundTransparency = 0.2
ContentFrame.BorderSizePixel = 1
ContentFrame.BorderColor3 = Color3.fromRGB(45, 45, 45)
ContentFrame.Parent = MainFrame
local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 10)
contentCorner.Parent = ContentFrame

local tabsList = {"ESP", "Combat", "Weapons", "Other"}
local currentTab = "ESP"
local tabButtons = {}

local function createTabButton(name, y)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 38)
    btn.Position = UDim2.new(0, 5, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(55, 55, 55)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.TextScaled = true
    btn.Font = Enum.Font.Gotham
    btn.Parent = TabContainer
    btn.MouseButton1Click:Connect(function()
        currentTab = name
        for _, b in pairs(tabButtons) do
            b.BackgroundColor3 = (b == btn) and Color3.fromRGB(70, 70, 140) or Color3.fromRGB(35, 35, 35)
        end
        UpdateContent()
    end)
    table.insert(tabButtons, btn)
    return btn
end

local yPos = 0
for _, name in ipairs(tabsList) do
    createTabButton(name, yPos)
    yPos = yPos + 43
end
tabButtons[1].BackgroundColor3 = Color3.fromRGB(70, 70, 140)

function UpdateContent()
    for _, child in pairs(ContentFrame:GetChildren()) do child:Destroy() end

    if currentTab == "ESP" then
        createToggle("ESP Master", "ESP", 5)

    elseif currentTab == "Combat" then
        createToggle("Aimbot", "Aimbot", 5)
        createToggle("Triggerbot", "Trigger", 35)
        createToggle("Silent Aim", "SilentAim", 65)
        createToggle("Prediction", "Prediction", 95)
        createToggle("Ignore Low HP", "IgnoreLowHP", 125)

        local delayLabel = Instance.new("TextLabel")
        delayLabel.Size = UDim2.new(0.6, 0, 0, 22)
        delayLabel.Position = UDim2.new(0.05, 0, 0, 160)
        delayLabel.BackgroundTransparency = 1
        delayLabel.Text = "Trigger delay: " .. string.format("%.3f", Settings.TriggerDelay) .. "s"
        delayLabel.TextColor3 = Color3.fromRGB(200,200,200)
        delayLabel.TextScaled = true
        delayLabel.Font = Enum.Font.Gotham
        delayLabel.Parent = ContentFrame
        local minus = Instance.new("TextButton")
        minus.Size = UDim2.new(0.08, 0, 0, 22)
        minus.Position = UDim2.new(0.7, 0, 0, 160)
        minus.BackgroundColor3 = Color3.fromRGB(50,50,50)
        minus.Text = "−"
        minus.TextColor3 = Color3.fromRGB(255,255,255)
        minus.TextScaled = true
        minus.Font = Enum.Font.Gotham
        minus.Parent = ContentFrame
        local plus = Instance.new("TextButton")
        plus.Size = UDim2.new(0.08, 0, 0, 22)
        plus.Position = UDim2.new(0.85, 0, 0, 160)
        plus.BackgroundColor3 = Color3.fromRGB(50,50,50)
        plus.Text = "+"
        plus.TextColor3 = Color3.fromRGB(255,255,255)
        plus.TextScaled = true
        plus.Font = Enum.Font.Gotham
        plus.Parent = ContentFrame
        minus.MouseButton1Click:Connect(function()
            Settings.TriggerDelay = math.max(0.001, Settings.TriggerDelay - 0.005)
            delayLabel.Text = "Trigger delay: " .. string.format("%.3f", Settings.TriggerDelay) .. "s"
        end)
        plus.MouseButton1Click:Connect(function()
            Settings.TriggerDelay = math.min(0.2, Settings.TriggerDelay + 0.005)
            delayLabel.Text = "Trigger delay: " .. string.format("%.3f", Settings.TriggerDelay) .. "s"
        end)

        local partLabel = Instance.new("TextLabel")
        partLabel.Size = UDim2.new(0.4, 0, 0, 22)
        partLabel.Position = UDim2.new(0.05, 0, 0, 195)
        partLabel.BackgroundTransparency = 1
        partLabel.Text = "Target: " .. Settings.AimPart
        partLabel.TextColor3 = Color3.fromRGB(200,200,200)
        partLabel.TextScaled = true
        partLabel.Font = Enum.Font.Gotham
        partLabel.Parent = ContentFrame
        local partBtn = Instance.new("TextButton")
        partBtn.Size = UDim2.new(0.2, 0, 0, 22)
        partBtn.Position = UDim2.new(0.5, 0, 0, 195)
        partBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
        partBtn.Text = "Switch"
        partBtn.TextColor3 = Color3.fromRGB(255,255,255)
        partBtn.TextScaled = true
        partBtn.Font = Enum.Font.Gotham
        partBtn.Parent = ContentFrame
        partBtn.MouseButton1Click:Connect(function()
            Settings.AimPart = (Settings.AimPart == "Head") and "Body" or "Head"
            partLabel.Text = "Target: " .. Settings.AimPart
        end)

        local fovLabel = Instance.new("TextLabel")
        fovLabel.Size = UDim2.new(1, -10, 0, 22)
        fovLabel.Position = UDim2.new(0, 5, 0, 230)
        fovLabel.BackgroundTransparency = 1
        fovLabel.Text = "FOV: " .. Settings.FOV
        fovLabel.TextColor3 = Color3.fromRGB(200,200,200)
        fovLabel.TextScaled = true
        fovLabel.Font = Enum.Font.Gotham
        fovLabel.Parent = ContentFrame
        local fovMinus = Instance.new("TextButton")
        fovMinus.Size = UDim2.new(0.12, 0, 0, 22)
        fovMinus.Position = UDim2.new(0.1, 0, 0, 255)
        fovMinus.BackgroundColor3 = Color3.fromRGB(50,50,50)
        fovMinus.Text = "−10"
        fovMinus.TextColor3 = Color3.fromRGB(255,255,255)
        fovMinus.TextScaled = true
        fovMinus.Font = Enum.Font.Gotham
        fovMinus.Parent = ContentFrame
        local fovPlus = Instance.new("TextButton")
        fovPlus.Size = UDim2.new(0.12, 0, 0, 22)
        fovPlus.Position = UDim2.new(0.78, 0, 0, 255)
        fovPlus.BackgroundColor3 = Color3.fromRGB(50,50,50)
        fovPlus.Text = "+10"
        fovPlus.TextColor3 = Color3.fromRGB(255,255,255)
        fovPlus.TextScaled = true
        fovPlus.Font = Enum.Font.Gotham
        fovPlus.Parent = ContentFrame
        fovMinus.MouseButton1Click:Connect(function()
            Settings.FOV = math.max(30, Settings.FOV - 10)
            fovLabel.Text = "FOV: " .. Settings.FOV
            updateCircle()
        end)
        fovPlus.MouseButton1Click:Connect(function()
            Settings.FOV = math.min(500, Settings.FOV + 10)
            fovLabel.Text = "FOV: " .. Settings.FOV
            updateCircle()
        end)

        local distLabel = Instance.new("TextLabel")
        distLabel.Size = UDim2.new(1, -10, 0, 22)
        distLabel.Position = UDim2.new(0, 5, 0, 285)
        distLabel.BackgroundTransparency = 1
        distLabel.Text = "Max Distance: " .. Settings.MaxDistance
        distLabel.TextColor3 = Color3.fromRGB(200,200,200)
        distLabel.TextScaled = true
        distLabel.Font = Enum.Font.Gotham
        distLabel.Parent = ContentFrame
        local distMinus = Instance.new("TextButton")
        distMinus.Size = UDim2.new(0.08, 0, 0, 22)
        distMinus.Position = UDim2.new(0.7, 0, 0, 285)
        distMinus.BackgroundColor3 = Color3.fromRGB(50,50,50)
        distMinus.Text = "−10"
        distMinus.TextColor3 = Color3.fromRGB(255,255,255)
        distMinus.TextScaled = true
        distMinus.Font = Enum.Font.Gotham
        distMinus.Parent = ContentFrame
        local distPlus = Instance.new("TextButton")
        distPlus.Size = UDim2.new(0.08, 0, 0, 22)
        distPlus.Position = UDim2.new(0.85, 0, 0, 285)
        distPlus.BackgroundColor3 = Color3.fromRGB(50,50,50)
        distPlus.Text = "+10"
        distPlus.TextColor3 = Color3.fromRGB(255,255,255)
        distPlus.TextScaled = true
        distPlus.Font = Enum.Font.Gotham
        distPlus.Parent = ContentFrame
        distMinus.MouseButton1Click:Connect(function()
            Settings.MaxDistance = math.max(10, Settings.MaxDistance - 10)
            distLabel.Text = "Max Distance: " .. Settings.MaxDistance
        end)
        distPlus.MouseButton1Click:Connect(function()
            Settings.MaxDistance = math.min(500, Settings.MaxDistance + 10)
            distLabel.Text = "Max Distance: " .. Settings.MaxDistance
        end)

        createToggle("Anti-Stun", "AntiStun", 315)

    elseif currentTab == "Weapons" then
        createToggle("No Recoil", "NoRecoil", 5)
        createToggle("No Spread", "NoSpread", 35)
        createToggle("Rapid Fire", "RapidFire", 65)
        createToggle("Auto Reload", "AutoReload", 95)

    elseif currentTab == "Other" then
        createToggle("SpeedHack", "SpeedHack", 5)
        createToggle("Anti-AFK", "AntiAFK", 35)

        local speedLabel = Instance.new("TextLabel")
        speedLabel.Size = UDim2.new(0.6, 0, 0, 22)
        speedLabel.Position = UDim2.new(0.05, 0, 0, 65)
        speedLabel.BackgroundTransparency = 1
        speedLabel.Text = "Speed: " .. Settings.Speed
        speedLabel.TextColor3 = Color3.fromRGB(200,200,200)
        speedLabel.TextScaled = true
        speedLabel.Font = Enum.Font.Gotham
        speedLabel.Parent = ContentFrame
        local spMinus = Instance.new("TextButton")
        spMinus.Size = UDim2.new(0.08, 0, 0, 22)
        spMinus.Position = UDim2.new(0.7, 0, 0, 65)
        spMinus.BackgroundColor3 = Color3.fromRGB(50,50,50)
        spMinus.Text = "−"
        spMinus.TextColor3 = Color3.fromRGB(255,255,255)
        spMinus.TextScaled = true
        spMinus.Font = Enum.Font.Gotham
        spMinus.Parent = ContentFrame
        local spPlus = Instance.new("TextButton")
        spPlus.Size = UDim2.new(0.08, 0, 0, 22)
        spPlus.Position = UDim2.new(0.85, 0, 0, 65)
        spPlus.BackgroundColor3 = Color3.fromRGB(50,50,50)
        spPlus.Text = "+"
        spPlus.TextColor3 = Color3.fromRGB(255,255,255)
        spPlus.TextScaled = true
        spPlus.Font = Enum.Font.Gotham
        spPlus.Parent = ContentFrame
        spMinus.MouseButton1Click:Connect(function()
            Settings.Speed = math.max(16, Settings.Speed - 1)
            speedLabel.Text = "Speed: " .. Settings.Speed
        end)
        spPlus.MouseButton1Click:Connect(function()
            Settings.Speed = math.min(50, Settings.Speed + 1)
            speedLabel.Text = "Speed: " .. Settings.Speed
        end)

        local menuLabel = Instance.new("TextLabel")
        menuLabel.Size = UDim2.new(1, -10, 0, 22)
        menuLabel.Position = UDim2.new(0, 5, 0, 100)
        menuLabel.BackgroundTransparency = 1
        menuLabel.Text = "Menu key: Insert"
        menuLabel.TextColor3 = Color3.fromRGB(200,200,200)
        menuLabel.TextScaled = true
        menuLabel.Font = Enum.Font.Gotham
        menuLabel.Parent = ContentFrame
        local menuBtn = Instance.new("TextButton")
        menuBtn.Size = UDim2.new(0.2, 0, 0, 22)
        menuBtn.Position = UDim2.new(0.4, 0, 0, 125)
        menuBtn.BackgroundColor3 = Color3.fromRGB(0,120,200)
        menuBtn.Text = "Assign"
        menuBtn.TextColor3 = Color3.fromRGB(255,255,255)
        menuBtn.TextScaled = true
        menuBtn.Font = Enum.Font.Gotham
        menuBtn.Parent = ContentFrame
        local waitingMenu = false
        menuBtn.MouseButton1Click:Connect(function()
            waitingMenu = true
            menuBtn.Text = "Press key..."
            menuBtn.BackgroundColor3 = Color3.fromRGB(255,100,50)
        end)
        UserInputService.InputBegan:Connect(function(input, gp)
            if gp then return end
            if waitingMenu and input.KeyCode ~= Enum.KeyCode.Unknown then
                MenuKey = input.KeyCode
                menuLabel.Text = "Menu key: " .. input.KeyCode.Name
                menuBtn.Text = "Assign"
                menuBtn.BackgroundColor3 = Color3.fromRGB(0,120,200)
                waitingMenu = false
            end
        end)

        local bindAimLabel = Instance.new("TextLabel")
        bindAimLabel.Size = UDim2.new(0.6, 0, 0, 22)
        bindAimLabel.Position = UDim2.new(0.05, 0, 0, 160)
        bindAimLabel.BackgroundTransparency = 1
        bindAimLabel.Text = "Aimbot bind: " .. (Settings.BindAimbot and Settings.BindAimbot.Name or "None")
        bindAimLabel.TextColor3 = Color3.fromRGB(200,200,200)
        bindAimLabel.TextScaled = true
        bindAimLabel.Font = Enum.Font.Gotham
        bindAimLabel.Parent = ContentFrame
        local bindAimBtn = Instance.new("TextButton")
        bindAimBtn.Size = UDim2.new(0.2, 0, 0, 22)
        bindAimBtn.Position = UDim2.new(0.7, 0, 0, 160)
        bindAimBtn.BackgroundColor3 = Color3.fromRGB(0,120,200)
        bindAimBtn.Text = "Assign"
        bindAimBtn.TextColor3 = Color3.fromRGB(255,255,255)
        bindAimBtn.TextScaled = true
        bindAimBtn.Font = Enum.Font.Gotham
        bindAimBtn.Parent = ContentFrame
        local waitingAim = false
        bindAimBtn.MouseButton1Click:Connect(function()
            waitingAim = true
            bindAimBtn.Text = "Press key..."
            bindAimBtn.BackgroundColor3 = Color3.fromRGB(255,100,50)
        end)

        local bindTrigLabel = Instance.new("TextLabel")
        bindTrigLabel.Size = UDim2.new(0.6, 0, 0, 22)
        bindTrigLabel.Position = UDim2.new(0.05, 0, 0, 190)
        bindTrigLabel.BackgroundTransparency = 1
        bindTrigLabel.Text = "Trigger bind: " .. (Settings.BindTrigger and Settings.BindTrigger.Name or "None")
        bindTrigLabel.TextColor3 = Color3.fromRGB(200,200,200)
        bindTrigLabel.TextScaled = true
        bindTrigLabel.Font = Enum.Font.Gotham
        bindTrigLabel.Parent = ContentFrame
        local bindTrigBtn = Instance.new("TextButton")
        bindTrigBtn.Size = UDim2.new(0.2, 0, 0, 22)
        bindTrigBtn.Position = UDim2.new(0.7, 0, 0, 190)
        bindTrigBtn.BackgroundColor3 = Color3.fromRGB(0,120,200)
        bindTrigBtn.Text = "Assign"
        bindTrigBtn.TextColor3 = Color3.fromRGB(255,255,255)
        bindTrigBtn.TextScaled = true
        bindTrigBtn.Font = Enum.Font.Gotham
        bindTrigBtn.Parent = ContentFrame
        local waitingTrig = false
        bindTrigBtn.MouseButton1Click:Connect(function()
            waitingTrig = true
            bindTrigBtn.Text = "Press key..."
            bindTrigBtn.BackgroundColor3 = Color3.fromRGB(255,100,50)
        end)

        UserInputService.InputBegan:Connect(function(input, gp)
            if gp then return end
            if waitingAim and input.KeyCode ~= Enum.KeyCode.Unknown then
                Settings.BindAimbot = input.KeyCode
                bindAimLabel.Text = "Aimbot bind: " .. input.KeyCode.Name
                bindAimBtn.Text = "Assign"
                bindAimBtn.BackgroundColor3 = Color3.fromRGB(0,120,200)
                waitingAim = false
            elseif waitingTrig and input.KeyCode ~= Enum.KeyCode.Unknown then
                Settings.BindTrigger = input.KeyCode
                bindTrigLabel.Text = "Trigger bind: " .. input.KeyCode.Name
                bindTrigBtn.Text = "Assign"
                bindTrigBtn.BackgroundColor3 = Color3.fromRGB(0,120,200)
                waitingTrig = false
            end
        end)

        local resetBinds = Instance.new("TextButton")
        resetBinds.Size = UDim2.new(0.2, 0, 0, 22)
        resetBinds.Position = UDim2.new(0.4, 0, 0, 220)
        resetBinds.BackgroundColor3 = Color3.fromRGB(150,50,50)
        resetBinds.Text = "Reset Binds"
        resetBinds.TextColor3 = Color3.fromRGB(255,255,255)
        resetBinds.TextScaled = true
        resetBinds.Font = Enum.Font.Gotham
        resetBinds.Parent = ContentFrame
        resetBinds.MouseButton1Click:Connect(function()
            Settings.BindAimbot = nil
            Settings.BindTrigger = nil
            bindAimLabel.Text = "Aimbot bind: None"
            bindTrigLabel.Text = "Trigger bind: None"
        end)
    end
end

function createToggle(text, prop, y)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 28)
    btn.Position = UDim2.new(0.05, 0, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(55, 55, 55)
    local state = Settings[prop] or false
    btn.Text = text .. (state and "  ON" or "  OFF")
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.TextScaled = true
    btn.Font = Enum.Font.Gotham
    btn.Parent = ContentFrame
    btn.BackgroundColor3 = state and Color3.fromRGB(0, 140, 70) or Color3.fromRGB(35, 35, 35)
    btn.BorderColor3 = state and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(55, 55, 55)
    btn.MouseButton1Click:Connect(function()
        state = not state
        Settings[prop] = state
        btn.Text = text .. (state and "  ON" or "  OFF")
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 140, 70) or Color3.fromRGB(35, 35, 35)
        btn.BorderColor3 = state and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(55, 55, 55)
        if prop == "ESP" then
            if state then ESP_Start() else ESP_Stop() end
        end
    end)
    return btn
end

UpdateContent()

local circle = Instance.new("Frame")
circle.Size = UDim2.new(0, Settings.FOV*2, 0, Settings.FOV*2)
circle.BackgroundTransparency = 1
circle.BorderSizePixel = 2
circle.BorderColor3 = Color3.fromRGB(0, 255, 100)
circle.ZIndex = 10
circle.Parent = ScreenGui
local circleCorner = Instance.new("UICorner")
circleCorner.CornerRadius = UDim.new(1, 0)
circleCorner.Parent = circle

function updateCircle()
    circle.Size = UDim2.new(0, Settings.FOV*2, 0, Settings.FOV*2)
end

RunService.RenderStepped:Connect(function()
    local mx, my = Mouse.X, Mouse.Y
    circle.Position = UDim2.new(0, mx - Settings.FOV, 0, my - Settings.FOV)
end)

function isVisible(character, part)
    if not part then return false end
    local origin = Camera.CFrame.Position
    local direction = (part.Position - origin).Unit * (part.Position - origin).Magnitude
    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Blacklist
    rayParams.FilterDescendantsInstances = {LocalPlayer.Character, character}
    local result = workspace:Raycast(origin, direction, rayParams)
    if result then
        return result.Instance and (result.Instance:IsDescendantOf(character) or result.Instance:IsDescendantOf(LocalPlayer.Character))
    end
    return true
end

function getTarget()
    local mx, my = Mouse.X, Mouse.Y
    local best, bestDist = nil, Settings.FOV
    for _, plr in pairs(Players:GetPlayers()) do
        if plr == LocalPlayer then continue end
        local char = plr.Character
        if not char then continue end
        local hum = char:FindFirstChild("Humanoid")
        if not hum or hum.Health <= 0 or hum.Sit or hum.PlatformStand then continue end
        if Settings.IgnoreLowHP and hum.Health < 11 then continue end
        local partName = (Settings.AimPart == "Head") and "Head" or "UpperTorso"
        local part = char:FindFirstChild(partName) or char:FindFirstChild("Head")
        if not part then continue end
        if not isVisible(char, part) then continue end
        local pos, onScreen = Camera:WorldToScreenPoint(part.Position)
        if not onScreen then continue end
        local screenDist = (Vector2.new(pos.X, pos.Y) - Vector2.new(mx, my)).Magnitude
        if screenDist > Settings.FOV then continue end
        local worldDist = (Camera.CFrame.Position - part.Position).Magnitude
        if worldDist > Settings.MaxDistance then continue end
        if screenDist < bestDist then
            bestDist = screenDist
            best = plr
        end
    end
    return best, bestDist
end

function getPredictedPosition(part, character)
    local currentPos = part.Position
    local vel = character:FindFirstChild("Humanoid") and character.Humanoid:GetState() == Enum.HumanoidStateType.Running and character.Humanoid.MoveDirection * 16 or Vector3.new(0,0,0)
    local bulletSpeed = 3000
    local distance = (Camera.CFrame.Position - currentPos).Magnitude
    local travelTime = distance / bulletSpeed
    return currentPos + vel * travelTime
end

local function onShoot()
    if not Settings.SilentAim or MainFrame.Visible then return end
    local target = getTarget()
    if not target then return end
    local partName = (Settings.AimPart == "Head") and "Head" or "UpperTorso"
    local part = target.Character and target.Character:FindFirstChild(partName)
    if not part then return end
    local aimPos = part.Position
    if Settings.Prediction then
        aimPos = getPredictedPosition(part, target.Character)
    end
    local oldCF = Camera.CFrame
    Camera.CFrame = CFrame.new(Camera.CFrame.Position, aimPos)
    task.wait(0.02)
    Camera.CFrame = oldCF
end

if isMobile then
    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.UserInputType == Enum.UserInputType.Touch and input.UserInputState == Enum.UserInputState.Begin then
            onShoot()
        end
    end)
else
    Mouse.Button1Down:Connect(onShoot)
end

local function mainLoop()
    while true do
        task.wait(0.05)
        if MainFrame.Visible then
            goto continue
        end

        local target = getTarget()
        if target then
            local partName = (Settings.AimPart == "Head") and "Head" or "UpperTorso"
            local part = target.Character and target.Character:FindFirstChild(partName)
            if part then
                local aimPos = part.Position
                if Settings.Prediction then
                    aimPos = getPredictedPosition(part, target.Character)
                end

                if Settings.Aimbot then
                    if not isMobile then
                        local pos, onScreen = Camera:WorldToScreenPoint(aimPos)
                        if onScreen then
                            mousemoverel((pos.X - Mouse.X) * 0.2, (pos.Y - Mouse.Y) * 0.2)
                        end
                    else
                        Camera.CFrame = CFrame.new(Camera.CFrame.Position, aimPos)
                    end
                end

                if Settings.Trigger and not Settings.SilentAim then
                    if isMobile then
                        if Mouse then Mouse.Button1Down:Fire() end
                    else
                        if mouse1click then mouse1click() else
                            game:GetService("VirtualInputManager"):SendMouseButtonEvent(0,0,0,true,game,1)
                        end
                    end
                    task.wait(Settings.TriggerDelay)
                    if isMobile then
                        if Mouse then Mouse.Button1Up:Fire() end
                    else
                        if not mouse1click then
                            game:GetService("VirtualInputManager"):SendMouseButtonEvent(0,0,0,false,game,1)
                        end
                    end
                end
            end
        end

        ::continue::

        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
        if hum then
            if Settings.SpeedHack then
                hum.WalkSpeed = Settings.Speed
            else
                hum.WalkSpeed = 16
            end
            if Settings.AntiStun and hum.WalkSpeed < 16 then
                hum.WalkSpeed = 16
            end
        end

        if Settings.AntiAFK and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.MoveDirection = Vector3.new(1,0,0)
        end

        local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
        if tool then
            if Settings.NoRecoil then
                for _, prop in ipairs({"Recoil", "RecoilAmount", "CameraRecoil"}) do
                    local p = tool:FindFirstChild(prop)
                    if p and p:IsA("NumberValue") then p.Value = 0 end
                end
            end
            if Settings.NoSpread then
                for _, prop in ipairs({"Spread", "Accuracy", "Inaccuracy"}) do
                    local p = tool:FindFirstChild(prop)
                    if p and p:IsA("NumberValue") then p.Value = 0 end
                end
            end
            if Settings.RapidFire then
                for _, prop in ipairs({"FireRate", "Cooldown", "Rate"}) do
                    local p = tool:FindFirstChild(prop)
                    if p and p:IsA("NumberValue") and p.Value > 0 then p.Value = 0.01 end
                end
            end
            if Settings.AutoReload then
                local ammo = tool:FindFirstChild("Ammo") or tool:FindFirstChild("Magazine")
                if ammo and ammo:IsA("NumberValue") and ammo.Value == 0 then
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.R, false, game)
                    task.wait(0.1)
                    game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.R, false, game)
                end
            end
        end
    end
end

coroutine.wrap(mainLoop)()

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Settings.BindAimbot then Settings.Aimbot = not Settings.Aimbot end
    if input.KeyCode == Settings.BindTrigger then Settings.Trigger = not Settings.Trigger end
end)

local MenuKey = Enum.KeyCode.Insert
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == MenuKey then
        MainFrame.Visible = not MainFrame.Visible
        if minimizeTarget then minimizeTarget:Destroy() minimizeTarget = nil end
    end
end)

local espHighlights = {}

function ESP_Start()
    local function addESP(plr)
        if plr == LocalPlayer or not plr.Character then return end
        local char = plr.Character
        local hum = char:FindFirstChild("Humanoid")
        if not hum or hum.Health <= 0 then return end
        local hl = Instance.new("Highlight")
        hl.Parent = char
        hl.FillColor = Color3.fromRGB(255, 50, 50)
        hl.OutlineColor = Color3.fromRGB(0, 255, 100)
        hl.FillTransparency = 0.6
        hl.Enabled = true
        table.insert(espHighlights, hl)
    end

    local function removeESP(plr)
        for i, hl in ipairs(espHighlights) do
            if hl.Parent and hl.Parent:FindFirstChild("Humanoid") and hl.Parent.Name == plr.Name then
                hl:Destroy()
                table.remove(espHighlights, i)
                break
            end
        end
    end

    for _, plr in pairs(Players:GetPlayers()) do
        addESP(plr)
    end

    Players.PlayerAdded:Connect(function(plr)
        plr.CharacterAdded:Connect(function()
            addESP(plr)
        end)
    end)
    Players.PlayerRemoving:Connect(removeESP)
end

function ESP_Stop()
    for _, hl in ipairs(espHighlights) do
        hl:Destroy()
    end
    espHighlights = {}
end

if Settings.ESP then
    ESP_Start()
end

print("DaHood ULTIMATE v10 loaded. Press Insert to toggle menu.")
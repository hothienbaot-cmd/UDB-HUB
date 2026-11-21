-- ==========================================================
-- USB HUB - ULTIMATE PRO MOBILE SCRIPT HUB (FULL + RADAR)
-- ==========================================================
local Plrs = game:GetService("Players")
local RunSvc = game:GetService("RunService")
local Uis = game:GetService("UserInputService")
local Wsp = game:GetService("Workspace")
local Cg = game:GetService("CoreGui")
local TS = game:GetService("TeleportService")
local HS = game:GetService("HttpService")
local MS = game:GetService("MarketplaceService")
local VU = game:GetService("VirtualUser")
local LP = Plrs.LocalPlayer

for _, name in ipairs({"USBHubGui", "NexusFlyGui", "MickeyChatGui", "TranslationGui", "PlayerInfoGui", "CalculatorGui", "ShiftLockGui", "CrosshairGui", "USBHubRadarGui"}) do
    if Cg:FindFirstChild(name) then Cg[name]:Destroy() end
end

local SGui = Instance.new("ScreenGui", Cg)
SGui.Name = "USBHubGui"
SGui.ResetOnSpawn = false

local Logo = Instance.new("ImageButton", SGui)
Logo.Size = UDim2.new(0, 48, 0, 48)
Logo.Position = UDim2.new(0, 20, 0.3, 0)
Logo.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Logo.Image = "rbxassetid://6023426915"
Logo.Active = true
Logo.Draggable = true
Instance.new("UICorner", Logo).CornerRadius = UDim.new(1, 0)

local MFrame = Instance.new("Frame", SGui)
MFrame.Size = UDim2.new(0, 440, 0, 310)
MFrame.Position = UDim2.new(0.5, -220, 0.5, -155)
MFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
MFrame.BorderSizePixel = 0
MFrame.Active = true
MFrame.Draggable = true
Instance.new("UICorner", MFrame).CornerRadius = UDim.new(0, 10)

local visible = true
Logo.MouseButton1Click:Connect(function()
    visible = not visible
    MFrame.Visible = visible
end)

local Sidebar = Instance.new("Frame", MFrame)
Sidebar.Size = UDim2.new(0, 115, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)

local function mkSideBtn(txt, y)
    local b = Instance.new("TextButton", Sidebar)
    b.Size = UDim2.new(1, -10, 0, 31)
    b.Position = UDim2.new(0, 5, 0, y)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    b.Text = "👤 " .. txt
    b.TextColor3 = Color3.fromRGB(200, 200, 200)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    b.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    return b
end

local Tab1Btn = mkSideBtn("Player", 12)
local Tab2Btn = mkSideBtn("Spectate", 49)
local Tab3Btn = mkSideBtn("Scripts", 86)
local Tab4Btn = mkSideBtn("Visuals", 123)
local Tab5Btn = mkSideBtn("Info", 160)

local CFrameBox = Instance.new("Frame", MFrame)
CFrameBox.Size = UDim2.new(1, -125, 1, -10)
CFrameBox.Position = UDim2.new(0, 120, 0, 5)
CFrameBox.BackgroundTransparency = 1

local function mkCont(h)
    local c = Instance.new("ScrollingFrame", CFrameBox)
    c.Size = UDim2.new(1, 0, 1, 0)
    c.BackgroundTransparency = 1
    c.CanvasSize = UDim2.new(0, 0, 0, h or 500)
    c.ScrollBarThickness = 3
    c.Visible = false
    return c
end

local CPlayer = mkCont(400)
local CSpectate = mkCont(450)
local CScripts = mkCont(760)
local CVisuals = mkCont(450)
local CInfo = mkCont(500)
CPlayer.Visible = true

local function switchTab(target, btn)
    for _, tab in ipairs({CPlayer, CSpectate, CScripts, CVisuals, CInfo}) do tab.Visible = false end
    for _, b in ipairs({Tab1Btn, Tab2Btn, Tab3Btn, Tab4Btn, Tab5Btn}) do b.BackgroundColor3 = Color3.fromRGB(30, 30, 40) end
    target.Visible = true
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
end

Tab1Btn.MouseButton1Click:Connect(function() switchTab(CPlayer, Tab1Btn) end)
Tab2Btn.MouseButton1Click:Connect(function() switchTab(CSpectate, Tab2Btn) end)
Tab3Btn.MouseButton1Click:Connect(function() switchTab(CScripts, Tab3Btn) end)
Tab4Btn.MouseButton1Click:Connect(function() switchTab(CVisuals, Tab4Btn) end)
Tab5Btn.MouseButton1Click:Connect(function() switchTab(CInfo, Tab5Btn) end)
Tab1Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)

local function addLbl(p, txt, y)
    local l = Instance.new("TextLabel", p)
    l.Size = UDim2.new(1, 0, 0, 18)
    l.Position = UDim2.new(0, 0, 0, y)
    l.BackgroundTransparency = 1
    l.Text = txt
    l.TextColor3 = Color3.fromRGB(170, 170, 170)
    l.Font = Enum.Font.GothamBold
    l.TextSize = 11
    l.TextXAlignment = Enum.TextXAlignment.Left
end

local function addTBox(p, def, y, cb)
    local tb = Instance.new("TextBox", p)
    tb.Size = UDim2.new(1, 0, 0, 26)
    tb.Position = UDim2.new(0, 0, 0, y)
    tb.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    tb.Text = def
    tb.TextColor3 = Color3.fromRGB(255, 255, 255)
    tb.Font = Enum.Font.Gotham
    tb.TextSize = 12
    tb.ClearTextOnFocus = false
    Instance.new("UICorner", tb).CornerRadius = UDim.new(0, 6)
    tb.FocusLost:Connect(function() cb(tb.Text) end)
end

local function addTgl(p, txt, y, cb)
    local btn = Instance.new("TextButton", p)
    btn.Size = UDim2.new(1, 0, 0, 28)
    btn.Position = UDim2.new(0, 0, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    btn.Text = txt .. ": TẮT"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = txt .. (state and ": BẬT" or ": TẮT")
        btn.BackgroundColor3 = state and Color3.fromRGB(50, 180, 80) or Color3.fromRGB(45, 45, 55)
        cb(state)
    end)
    return btn
end

-- TAB 1: PLAYER
addLbl(CPlayer, "Speed:", 5)
addTBox(CPlayer, "16", 24, function(val)
    local n = tonumber(val)
    local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
    if n and hum then hum.WalkSpeed = n end
end)

addLbl(CPlayer, "JumpPower:", 55)
addTBox(CPlayer, "50", 74, function(val)
    local n = tonumber(val)
    local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
    if n and hum then hum.UseJumpPower = true hum.JumpPower = n end
end)

addLbl(CPlayer, "Gravity:", 105)
addTBox(CPlayer, "196.2", 124, function(val)
    local n = tonumber(val)
    if n then Wsp.Gravity = n end
end)

addTgl(CPlayer, "Infinite Jump", 158, function(st)
    if st then
        _G.InfConn = Uis.JumpRequest:Connect(function()
            local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
        end)
    else
        if _G.InfConn then _G.InfConn:Disconnect() end
    end
end)

local ResBtn = Instance.new("TextButton", CPlayer)
ResBtn.Size = UDim2.new(1, 0, 0, 28)
ResBtn.Position = UDim2.new(0, 0, 0, 192)
ResBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
ResBtn.Text = "Reset Player"
ResBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ResBtn.Font = Enum.Font.GothamBold
ResBtn.TextSize = 11
Instance.new("UICorner", ResBtn).CornerRadius = UDim.new(0, 6)
ResBtn.MouseButton1Click:Connect(function()
    local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.Health = 0 end
end)

local noclipOn = false
addTgl(CPlayer, "Noclip (Xuyên tường)", 226, function(st)
    noclipOn = st
    if st then
        _G.NoclipConn = RunSvc.Stepped:Connect(function()
            if noclipOn and LP.Character then
                for _, p in ipairs(LP.Character:GetDescendants()) do
                    if p:IsA("BasePart") then p.CanCollide = false end
                end
            end
        end)
    else
        if _G.NoclipConn then _G.NoclipConn:Disconnect() end
    end
end)

addLbl(CPlayer, "Fly Speed:", 260)
local pFlySpd = 50
addTBox(CPlayer, "50", 278, function(val) local n = tonumber(val) if n then pFlySpd = n end end)

local pFlying, pBv, pBg = false, nil, nil
addTgl(CPlayer, "Fly", 308, function(st)
    pFlying = st
    local char = LP.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if pFlying then
        if not hrp or not hum then return end
        pBv = Instance.new("BodyVelocity", hrp)
        pBv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        pBv.Velocity = Vector3.new(0, 0, 0)
        pBg = Instance.new("BodyGyro", hrp)
        pBg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        pBg.P = 9e4
        pBg.CFrame = hrp.CFrame
        task.spawn(function()
            while pFlying and char and hrp and hum and hrp.Parent do
                RunSvc.RenderStepped:Wait()
                local cam = Wsp.CurrentCamera
                pBg.CFrame = cam.CFrame
                pBv.Velocity = hum.MoveDirection.Magnitude > 0 and cam.CFrame.LookVector * pFlySpd or Vector3.new(0,0,0)
            end
        end)
    else
        if pBv then pBv:Destroy() pBv = nil end
        if pBg then pBg:Destroy() pBg = nil end
    end
end)

-- SHIFT LOCK (WALL HOP / MOBILE) TRONG TAB PLAYER
local SHIFT_OFFSET = Vector3.new(1.75, 0, 0)
local shiftGui = nil
local shiftLockBtn = nil
local shiftCrosshair = nil
local shiftStroke = nil
local shiftIcon = nil
local shiftActive = false
local shiftConn = nil
local shiftCharConn = nil

local function setShiftAutoRotate(lockRot)
    local char = LP.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.AutoRotate = not lockRot
    end
end

local function refreshShiftVisual()
    if not shiftStroke or not shiftLockBtn or not shiftIcon or not shiftCrosshair then return end
    if shiftActive then
        shiftStroke.Color = Color3.fromRGB(65, 155, 255)
        shiftLockBtn.BackgroundColor3 = Color3.fromRGB(30, 85, 165)
        shiftLockBtn.BackgroundTransparency = 0.15
        shiftIcon.Text = "🔒"
        shiftIcon.TextColor3 = Color3.fromRGB(160, 215, 255)
        shiftCrosshair.Visible = true
    else
        shiftStroke.Color = Color3.fromRGB(200, 205, 215)
        shiftLockBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
        shiftLockBtn.BackgroundTransparency = 0.25
        shiftIcon.Text = "🔓"
        shiftIcon.TextColor3 = Color3.fromRGB(235, 235, 240)
        shiftCrosshair.Visible = false
    end
end

local function stopShiftLockMode()
    shiftActive = false
    refreshShiftVisual()
    setShiftAutoRotate(false)
    if shiftConn then
        shiftConn:Disconnect()
        shiftConn = nil
    end
end

local function startShiftLockMode()
    if shiftConn then
        shiftConn:Disconnect()
        shiftConn = nil
    end
    shiftActive = true
    refreshShiftVisual()

    shiftConn = RunSvc.RenderStepped:Connect(function()
        if not shiftActive then return end
        local char = LP.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local cam = Wsp.CurrentCamera
        if not char or not hum or not hrp or not cam or hum.Health <= 0 then return end

        hum.AutoRotate = false
        cam.CFrame = cam.CFrame * CFrame.new(SHIFT_OFFSET)

        local lookVec = cam.CFrame.LookVector
        local flatLook = Vector3.new(lookVec.X, 0, lookVec.Z)
        if flatLook.Magnitude > 0.001 then
            hrp.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + flatLook.Unit)
        end
    end)
end

local function destroyShiftLockGui()
    stopShiftLockMode()
    if shiftCharConn then
        shiftCharConn:Disconnect()
        shiftCharConn = nil
    end
    if shiftGui then
        pcall(function() shiftGui:Destroy() end)
        shiftGui = nil
    end
    if Cg:FindFirstChild("ShiftLockGui") then
        pcall(function() Cg.ShiftLockGui:Destroy() end)
    end
    shiftLockBtn = nil
    shiftCrosshair = nil
    shiftStroke = nil
    shiftIcon = nil
end

local function createShiftLockGui()
    destroyShiftLockGui()

    local g = Instance.new("ScreenGui")
    g.Name = "ShiftLockGui"
    g.ResetOnSpawn = false
    g.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    g.Parent = Cg
    shiftGui = g

    local b = Instance.new("ImageButton")
    b.Name = "ShiftLockButton"
    b.Size = UDim2.new(0, 46, 0, 46)
    b.Position = UDim2.new(1, -122, 1, -135)
    b.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    b.BackgroundTransparency = 0.25
    b.Active = true
    b.Draggable = true
    b.Parent = g
    Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
    shiftLockBtn = b

    local st = Instance.new("UIStroke")
    st.Color = Color3.fromRGB(200, 205, 215)
    st.Thickness = 2
    st.Parent = b
    shiftStroke = st

    local ic = Instance.new("TextLabel")
    ic.Size = UDim2.new(1, 0, 1, 0)
    ic.BackgroundTransparency = 1
    ic.Text = "🔓"
    ic.TextColor3 = Color3.fromRGB(235, 235, 240)
    ic.Font = Enum.Font.GothamBold
    ic.TextSize = 18
    ic.Parent = b
    shiftIcon = ic

    local ch = Instance.new("ImageLabel")
    ch.Name = "Crosshair"
    ch.Size = UDim2.new(0, 28, 0, 28)
    ch.Position = UDim2.new(0.5, -14, 0.5, -14)
    ch.BackgroundTransparency = 1
    ch.Image = "rbxassetid://6023426926"
    ch.ImageColor3 = Color3.fromRGB(255, 255, 255)
    ch.Visible = false
    ch.Parent = g
    shiftCrosshair = ch

    b.MouseButton1Click:Connect(function()
        if shiftActive then
            stopShiftLockMode()
        else
            startShiftLockMode()
        end
    end)

    shiftCharConn = LP.CharacterAdded:Connect(function()
        task.wait(0.15)
        if shiftActive then
            startShiftLockMode()
        else
            setShiftAutoRotate(false)
        end
    end)
end

addTgl(CPlayer, "Shift Lock (Wall Hop)", 342, function(st)
    if st then
        createShiftLockGui()
    else
        destroyShiftLockGui()
    end
end)

-- TAB 2: SPECTATE
addLbl(CSpectate, "Chọn người chơi để theo dõi:", 5)
local PScroll = Instance.new("ScrollingFrame", CSpectate)
PScroll.Size = UDim2.new(1, 0, 0, 130)
PScroll.Position = UDim2.new(0, 0, 0, 24)
PScroll.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
PScroll.BorderSizePixel = 0
PScroll.CanvasSize = UDim2.new(0, 0, 0, 200)
PScroll.ScrollBarThickness = 3
Instance.new("UICorner", PScroll).CornerRadius = UDim.new(0, 6)

local RefBtn = Instance.new("TextButton", CSpectate)
RefBtn.Size = UDim2.new(1, 0, 0, 26)
RefBtn.Position = UDim2.new(0, 0, 0, 160)
RefBtn.BackgroundColor3 = Color3.fromRGB(50, 120, 180)
RefBtn.Text = "🔄 Cập Nhật Danh Sách"
RefBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RefBtn.Font = Enum.Font.GothamBold
RefBtn.TextSize = 11
Instance.new("UICorner", RefBtn).CornerRadius = UDim.new(0, 6)

local StopSpecBtn = Instance.new("TextButton", CSpectate)
StopSpecBtn.Size = UDim2.new(1, 0, 0, 28)
StopSpecBtn.Position = UDim2.new(0, 0, 0, 192)
StopSpecBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
StopSpecBtn.Text = "🛑 Tắt Spectate"
StopSpecBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
StopSpecBtn.Font = Enum.Font.GothamBold
StopSpecBtn.TextSize = 11
Instance.new("UICorner", StopSpecBtn).CornerRadius = UDim.new(0, 6)

StopSpecBtn.MouseButton1Click:Connect(function()
    local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
    if hum then Wsp.CurrentCamera.CameraSubject = hum Wsp.CurrentCamera.CameraType = Enum.CameraType.Custom end
end)

local function updatePList()
    for _, ch in ipairs(PScroll:GetChildren()) do if ch:IsA("TextButton") then ch:Destroy() end end
    local y = 2
    for _, p in ipairs(Plrs:GetPlayers()) do
        if p ~= LP then
            local btn = Instance.new("TextButton", PScroll)
            btn.Size = UDim2.new(1, -6, 0, 26)
            btn.Position = UDim2.new(0, 3, 0, y)
            btn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
            btn.Text = "🎯 " .. p.Name
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 11
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
            btn.MouseButton1Click:Connect(function()
                if p.Character and p.Character:FindFirstChild("Humanoid") then
                    Wsp.CurrentCamera.CameraSubject = p.Character.Humanoid
                end
            end)
            y = y + 28
        end
    end
    PScroll.CanvasSize = UDim2.new(0, 0, 0, y)
end
RefBtn.MouseButton1Click:Connect(updatePList)
updatePList()

-- TAB 3: SCRIPTS (NEXUS FLY GUI + ANTI AFK + REJOIN + HỖ TRỢ TẦM NGẮM + RADAR)
local nexusTglBtn
local nexusGuiInstance = nil
local nexusFlyEnabled = false
local nexusSpeed = 1
local nexusVertHold = 0
local nexusMoveConn = nil
local nexusCharConn = nil
local nexusBv = nil
local nexusBg = nil

local function cleanNexusForces()
    if nexusBv then
        pcall(function() nexusBv:Destroy() end)
        nexusBv = nil
    end
    if nexusBg then
        pcall(function() nexusBg:Destroy() end)
        nexusBg = nil
    end
    local char = LP.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            for _, obj in ipairs(hrp:GetChildren()) do
                if obj.Name == "NexusBV" or obj.Name == "NexusBG" then
                    pcall(function() obj:Destroy() end)
                end
            end
        end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            pcall(function() hum.PlatformStand = false end)
        end
    end
end

local function ensureNexusForces()
    local char = LP.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum or hum.Health <= 0 then return nil, nil, nil end

    if not nexusBv or nexusBv.Parent ~= hrp then
        if nexusBv then pcall(function() nexusBv:Destroy() end) end
        nexusBv = Instance.new("BodyVelocity")
        nexusBv.Name = "NexusBV"
        nexusBv.MaxForce = Vector3.new(1e7, 1e7, 1e7)
        nexusBv.Velocity = Vector3.zero
        nexusBv.Parent = hrp
    end

    if not nexusBg or nexusBg.Parent ~= hrp then
        if nexusBg then pcall(function() nexusBg:Destroy() end) end
        nexusBg = Instance.new("BodyGyro")
        nexusBg.Name = "NexusBG"
        nexusBg.MaxTorque = Vector3.new(1e7, 1e7, 1e7)
        nexusBg.P = 3e4
        nexusBg.D = 500
        nexusBg.CFrame = hrp.CFrame
        nexusBg.Parent = hrp
    end

    return char, hrp, hum
end

local function stopNexusLoop()
    nexusFlyEnabled = false
    nexusVertHold = 0
    if nexusMoveConn then
        nexusMoveConn:Disconnect()
        nexusMoveConn = nil
    end
    cleanNexusForces()
end

local function startNexusLoop()
    if nexusMoveConn then
        nexusMoveConn:Disconnect()
        nexusMoveConn = nil
    end
    nexusMoveConn = RunSvc.RenderStepped:Connect(function(dt)
        if not nexusFlyEnabled then return end
        local char, hrp, hum = ensureNexusForces()
        if not char or not hrp or not hum then return end

        local cam = Wsp.CurrentCamera
        if not cam then return end

        local lookFlat = Vector3.new(cam.CFrame.LookVector.X, 0, cam.CFrame.LookVector.Z)
        if lookFlat.Magnitude > 0.001 then
            nexusBg.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + cam.CFrame.LookVector)
        else
            nexusBg.CFrame = cam.CFrame
        end

        local moveDir = hum.MoveDirection
        local speedScale = math.clamp(nexusSpeed, 1, 50) * 16
        local vel = Vector3.zero

        if moveDir.Magnitude > 0.01 then
            local camLook = cam.CFrame.LookVector
            local camRight = cam.CFrame.RightVector
            local forwardAmt = moveDir:Dot(Vector3.new(camLook.X, 0, camLook.Z).Unit)
            local rightAmt = moveDir:Dot(Vector3.new(camRight.X, 0, camRight.Z).Unit)
            if forwardAmt ~= forwardAmt then forwardAmt = 0 end
            if rightAmt ~= rightAmt then rightAmt = 0 end

            local dirVec = (cam.CFrame.LookVector * forwardAmt) + (camRight * rightAmt)
            if dirVec.Magnitude > 1 then
                dirVec = dirVec.Unit
        end
            vel = dirVec * speedScale
        end

        if nexusVertHold ~= 0 then
            vel = vel + Vector3.new(0, nexusVertHold * speedScale, 0)
        end

        nexusBv.Velocity = vel
    end)
end

local function destroyNexusGui()
    stopNexusLoop()
    if nexusCharConn then
        nexusCharConn:Disconnect()
        nexusCharConn = nil
    end
    if nexusGuiInstance then
        pcall(function() nexusGuiInstance:Destroy() end)
        nexusGuiInstance = nil
    end
    if Cg:FindFirstChild("NexusFlyGui") then
        pcall(function() Cg.NexusFlyGui:Destroy() end)
    end
    if nexusTglBtn then
        nexusTglBtn.Text = "FLY GUI (NEXUS): TẮT"
        nexusTglBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    end
end

local function createNexusGui()
    destroyNexusGui()

    local gui = Instance.new("ScreenGui")
    gui.Name = "NexusFlyGui"
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent = Cg
    nexusGuiInstance = gui

    local main = Instance.new("Frame")
    main.Name = "MainFrame"
    main.Size = UDim2.new(0, 232, 0, 96)
    main.Position = UDim2.new(0.28, 0, 0.35, 0)
    main.BackgroundColor3 = Color3.fromRGB(14, 14, 16)
    main.BorderSizePixel = 1
    main.BorderColor3 = Color3.fromRGB(42, 42, 48)
    main.Active = true
    main.Draggable = true
    main.Parent = gui
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 4)

    local topRow = Instance.new("Frame")
    topRow.Size = UDim2.new(1, 0, 0, 28)
    topRow.Position = UDim2.new(0, 0, 0, 0)
    topRow.BackgroundColor3 = Color3.fromRGB(18, 18, 21)
    topRow.BorderSizePixel = 0
    topRow.Parent = main

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 34, 1, 0)
    closeBtn.Position = UDim2.new(0, 0, 0, 0)
    closeBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
    closeBtn.BorderSizePixel = 1
    closeBtn.BorderColor3 = Color3.fromRGB(45, 45, 52)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(235, 235, 240)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 13
    closeBtn.Parent = topRow

    local bodyRow = Instance.new("Frame")
    bodyRow.Size = UDim2.new(1, 0, 1, -28)
    bodyRow.Position = UDim2.new(0, 0, 0, 28)
    bodyRow.BackgroundTransparency = 1
    bodyRow.Parent = main

    local leftGrid = Instance.new("Frame")
    leftGrid.Size = UDim2.new(0, 92, 1, 0)
    leftGrid.Position = UDim2.new(0, 0, 0, 0)
    leftGrid.BackgroundTransparency = 1
    leftGrid.Parent = bodyRow

    local function mkPadBtn(txt, x, y, w, h)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(0, w, 0, h)
        b.Position = UDim2.new(0, x, 0, y)
        b.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
        b.BorderSizePixel = 1
        b.BorderColor3 = Color3.fromRGB(48, 48, 56)
        b.Text = txt
        b.TextColor3 = Color3.fromRGB(240, 240, 245)
        b.Font = Enum.Font.Gotham
        b.TextSize = 13
        b.AutoButtonColor = true
        b.Parent = leftGrid
        return b
    end

    local upBtn = mkPadBtn("up", 0, 0, 46, 34)
    local plusBtn = mkPadBtn("+", 46, 0, 46, 34)
    local downBtn = mkPadBtn("down", 0, 34, 46, 34)
    local minusBtn = mkPadBtn("-", 46, 34, 46, 34)

    local rightPanel = Instance.new("Frame")
    rightPanel.Size = UDim2.new(1, -92, 1, 0)
    rightPanel.Position = UDim2.new(0, 92, 0, 0)
    rightPanel.BackgroundColor3 = Color3.fromRGB(16, 16, 19)
    rightPanel.BorderSizePixel = 1
    rightPanel.BorderColor3 = Color3.fromRGB(42, 42, 48)
    rightPanel.Parent = bodyRow

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(1, 0, 0, 24)
    titleLbl.Position = UDim2.new(0, 0, 0, 2)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = "Fly GUI"
    titleLbl.TextColor3 = Color3.fromRGB(245, 245, 250)
    titleLbl.Font = Enum.Font.GothamMedium
    titleLbl.TextSize = 15
    titleLbl.Parent = rightPanel

    local speedLbl = Instance.new("TextLabel")
    speedLbl.Size = UDim2.new(1, -6, 0, 20)
    speedLbl.Position = UDim2.new(0, 3, 0, 25)
    speedLbl.BackgroundTransparency = 1
    speedLbl.Text = tostring(nexusSpeed)
    speedLbl.TextColor3 = Color3.fromRGB(235, 235, 240)
    speedLbl.Font = Enum.Font.GothamBold
    speedLbl.TextSize = 14
    speedLbl.TextWrapped = true
    speedLbl.Parent = rightPanel

    local flyBtn = Instance.new("TextButton")
    flyBtn.Size = UDim2.new(0, 56, 0, 20)
    flyBtn.Position = UDim2.new(0.5, -28, 1, -22)
    flyBtn.BackgroundColor3 = Color3.fromRGB(36, 36, 42)
    flyBtn.BorderSizePixel = 1
    flyBtn.BorderColor3 = Color3.fromRGB(70, 70, 82)
    flyBtn.Text = "fly"
    flyBtn.TextColor3 = Color3.fromRGB(220, 220, 230)
    flyBtn.Font = Enum.Font.GothamMedium
    flyBtn.TextSize = 12
    flyBtn.Parent = rightPanel
    Instance.new("UICorner", flyBtn).CornerRadius = UDim.new(0, 4)

    local noticeToken = 0
    local function showTempNotice(msg)
        noticeToken = noticeToken + 1
        local tok = noticeToken
        speedLbl.Text = msg
        speedLbl.TextColor3 = Color3.fromRGB(255, 195, 90)
        task.delay(1.1, function()
            if tok == noticeToken and speedLbl and speedLbl.Parent then
                speedLbl.Text = tostring(nexusSpeed)
                speedLbl.TextColor3 = Color3.fromRGB(235, 235, 240)
            end
        end)
    end

    local function syncFlyVisual()
        if nexusFlyEnabled then
            flyBtn.BackgroundColor3 = Color3.fromRGB(45, 165, 85)
            flyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            flyBtn.Text = "fly: on"
        else
            flyBtn.BackgroundColor3 = Color3.fromRGB(36, 36, 42)
            flyBtn.TextColor3 = Color3.fromRGB(220, 220, 230)
            flyBtn.Text = "fly"
        end
    end

    plusBtn.MouseButton1Click:Connect(function()
        if nexusSpeed < 50 then
            nexusSpeed = nexusSpeed + 1
            noticeToken = noticeToken + 1
            speedLbl.Text = tostring(nexusSpeed)
            speedLbl.TextColor3 = Color3.fromRGB(235, 235, 240)
        end
    end)

    minusBtn.MouseButton1Click:Connect(function()
        if nexusSpeed > 1 then
            nexusSpeed = nexusSpeed - 1
            noticeToken = noticeToken + 1
            speedLbl.Text = tostring(nexusSpeed)
            speedLbl.TextColor3 = Color3.fromRGB(235, 235, 240)
        else
            nexusSpeed = 1
            showTempNotice("cannot be less than 1")
        end
    end)

    upBtn.MouseButton1Down:Connect(function() nexusVertHold = 1 end)
    upBtn.MouseButton1Up:Connect(function() if nexusVertHold == 1 then nexusVertHold = 0 end end)
    upBtn.MouseLeave:Connect(function() if nexusVertHold == 1 then nexusVertHold = 0 end end)

    downBtn.MouseButton1Down:Connect(function() nexusVertHold = -1 end)
    downBtn.MouseButton1Up:Connect(function() if nexusVertHold == -1 then nexusVertHold = 0 end end)
    downBtn.MouseLeave:Connect(function() if nexusVertHold == -1 then nexusVertHold = 0 end end)

    flyBtn.MouseButton1Click:Connect(function()
        if not nexusFlyEnabled then
            nexusFlyEnabled = true
            syncFlyVisual()
            ensureNexusForces()
            startNexusLoop()
        else
            stopNexusLoop()
            syncFlyVisual()
        end
    end)

    closeBtn.MouseButton1Click:Connect(function()
        destroyNexusGui()
    end)

    nexusCharConn = LP.CharacterAdded:Connect(function(newChar)
        cleanNexusForces()
        if nexusFlyEnabled then
            local hum = newChar:WaitForChild("Humanoid", 10)
            local hrp = newChar:WaitForChild("HumanoidRootPart", 10)
            if hum and hrp then
                task.wait(0.15)
                ensureNexusForces()
            end
        end
    end)
end

nexusTglBtn = addTgl(CScripts, "FLY GUI (NEXUS)", 5, function(st)
    if st then
        createNexusGui()
    else
        destroyNexusGui()
    end
end)

local fOn, fBv = false, nil
addTgl(CScripts, "Float (Lơ lửng)", 38, function(st)
    fOn = st
    local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if fOn and hrp then
        fBv = Instance.new("BodyVelocity", hrp)
        fBv.MaxForce = Vector3.new(0, 9e9, 0)
        fBv.Velocity = Vector3.new(0, 0, 0)
    else
        if fBv then fBv:Destroy() fBv = nil end
    end
end)

local UpB = Instance.new("TextButton", CScripts)
UpB.Size = UDim2.new(0.48, 0, 0, 26) UpB.Position = UDim2.new(0, 0, 0, 72)
UpB.BackgroundColor3 = Color3.fromRGB(60, 130, 80) UpB.Text = "⬆️ Lên" UpB.TextColor3 = Color3.fromRGB(255, 255, 255) UpB.Font = Enum.Font.GothamBold UpB.TextSize = 11
Instance.new("UICorner", UpB).CornerRadius = UDim.new(0, 6)
UpB.MouseButton1Click:Connect(function()
    local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.CFrame = hrp.CFrame + Vector3.new(0, 5, 0) end
end)

local DownB = Instance.new("TextButton", CScripts)
DownB.Size = UDim2.new(0.48, 0, 0, 26) DownB.Position = UDim2.new(0.52, 0, 0, 72)
DownB.BackgroundColor3 = Color3.fromRGB(130, 60, 60) DownB.Text = "⬇️ Xuống" DownB.TextColor3 = Color3.fromRGB(255, 255, 255) DownB.Font = Enum.Font.GothamBold DownB.TextSize = 11
Instance.new("UICorner", DownB).CornerRadius = UDim.new(0, 6)
DownB.MouseButton1Click:Connect(function()
    local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.CFrame = hrp.CFrame - Vector3.new(0, 5, 0) end
end)

addLbl(CScripts, "Position System:", 106)
local sPos = nil
local SaveP = Instance.new("TextButton", CScripts)
SaveP.Size = UDim2.new(0.48, 0, 0, 28) SaveP.Position = UDim2.new(0, 0, 0, 126)
SaveP.BackgroundColor3 = Color3.fromRGB(50, 150, 100) SaveP.Text = "💾 Save Pos" SaveP.TextColor3 = Color3.fromRGB(255, 255, 255) SaveP.Font = Enum.Font.GothamBold SaveP.TextSize = 11
Instance.new("UICorner", SaveP).CornerRadius = UDim.new(0, 6)
SaveP.MouseButton1Click:Connect(function()
    local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if hrp then sPos = hrp.CFrame SaveP.Text = "💾 Đã Lưu!" task.delay(1, function() SaveP.Text = "💾 Save Pos" end) end
end)

local TpP = Instance.new("TextButton", CScripts)
TpP.Size = UDim2.new(0.48, 0, 0, 28) TpP.Position = UDim2.new(0.52, 0, 0, 126)
TpP.BackgroundColor3 = Color3.fromRGB(150, 100, 50) TpP.Text = "⚡ TP Pos" TpP.TextColor3 = Color3.fromRGB(255, 255, 255) TpP.Font = Enum.Font.GothamBold TpP.TextSize = 11
Instance.new("UICorner", TpP).CornerRadius = UDim.new(0, 6)
TpP.MouseButton1Click:Connect(function()
    local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if hrp and sPos then hrp.CFrame = sPos end
end)

addLbl(CScripts, "TP Player:", 162)
local TPS = Instance.new("ScrollingFrame", CScripts)
TPS.Size = UDim2.new(1, 0, 0, 80) TPS.Position = UDim2.new(0, 0, 0, 182)
TPS.BackgroundColor3 = Color3.fromRGB(30, 30, 40) TPS.BorderSizePixel = 0 TPS.CanvasSize = UDim2.new(0, 0, 0, 150) TPS.ScrollBarThickness = 3
Instance.new("UICorner", TPS).CornerRadius = UDim.new(0, 6)

local RefTP = Instance.new("TextButton", CScripts)
RefTP.Size = UDim2.new(0.48, 0, 0, 26) RefTP.Position = UDim2.new(0, 0, 0, 266)
RefTP.BackgroundColor3 = Color3.fromRGB(50, 120, 180) RefTP.Text = "🔄 Cập Nhật" RefTP.TextColor3 = Color3.fromRGB(255, 255, 255) RefTP.Font = Enum.Font.GothamBold RefTP.TextSize = 10
Instance.new("UICorner", RefTP).CornerRadius = UDim.new(0, 6)

local ExecTP = Instance.new("TextButton", CScripts)
ExecTP.Size = UDim2.new(0.48, 0, 0, 26) ExecTP.Position = UDim2.new(0.52, 0, 0, 266)
ExecTP.BackgroundColor3 = Color3.fromRGB(180, 80, 50) ExecTP.Text = "🚀 Dịch Chuyển" ExecTP.TextColor3 = Color3.fromRGB(255, 255, 255) ExecTP.Font = Enum.Font.GothamBold ExecTP.TextSize = 10
Instance.new("UICorner", ExecTP).CornerRadius = UDim.new(0, 6)

local targetPlr = nil
local function updateTPList()
    for _, ch in ipairs(TPS:GetChildren()) do if ch:IsA("TextButton") then ch:Destroy() end end
    targetPlr = nil local y = 2
    for _, p in ipairs(Plrs:GetPlayers()) do
        if p ~= LP then
            local btn = Instance.new("TextButton", TPS)
            btn.Size = UDim2.new(1, -6, 0, 24) btn.Position = UDim2.new(0, 3, 0, y)
            btn.BackgroundColor3 = Color3.fromRGB(45, 45, 55) btn.Text = "👤 " .. p.Name btn.TextColor3 = Color3.fromRGB(255, 255, 255) btn.Font = Enum.Font.Gotham btn.TextSize = 11
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
            btn.MouseButton1Click:Connect(function()
                targetPlr = p
                for _, b in ipairs(TPS:GetChildren()) do if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(45, 45, 55) end end
                btn.BackgroundColor3 = Color3.fromRGB(50, 180, 80)
            end)
            y = y + 26
        end
    end
    TPS.CanvasSize = UDim2.new(0, 0, 0, y)
end
RefTP.MouseButton1Click:Connect(updateTPList) updateTPList()
ExecTP.MouseButton1Click:Connect(function()
    if targetPlr and targetPlr.Character and targetPlr.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.CFrame = targetPlr.Character.HumanoidRootPart.CFrame end
    end
end)

addLbl(CScripts, "Follow Player:", 300)
local FolS = Instance.new("ScrollingFrame", CScripts)
FolS.Size = UDim2.new(1, 0, 0, 80) FolS.Position = UDim2.new(0, 0, 0, 320)
FolS.BackgroundColor3 = Color3.fromRGB(30, 30, 40) FolS.BorderSizePixel = 0 FolS.CanvasSize = UDim2.new(0, 0, 0, 150) FolS.ScrollBarThickness = 3
Instance.new("UICorner", FolS).CornerRadius = UDim.new(0, 6)

local RefFol = Instance.new("TextButton", CScripts)
RefFol.Size = UDim2.new(0.31, 0, 0, 26) RefFol.Position = UDim2.new(0, 0, 0, 404)
RefFol.BackgroundColor3 = Color3.fromRGB(50, 120, 180) RefFol.Text = "🔄 Cập Nhật" RefFol.TextColor3 = Color3.fromRGB(255, 255, 255) RefFol.Font = Enum.Font.GothamBold RefFol.TextSize = 10
Instance.new("UICorner", RefFol).CornerRadius = UDim.new(0, 6)

local StartFol = Instance.new("TextButton", CScripts)
StartFol.Size = UDim2.new(0.32, 0, 0, 26) StartFol.Position = UDim2.new(0.34, 0, 0, 404)
StartFol.BackgroundColor3 = Color3.fromRGB(50, 160, 80) StartFol.Text = "▶️ Bắt Đầu" StartFol.TextColor3 = Color3.fromRGB(255, 255, 255) StartFol.Font = Enum.Font.GothamBold StartFol.TextSize = 10
Instance.new("UICorner", StartFol).CornerRadius = UDim.new(0, 6)

local StopFol = Instance.new("TextButton", CScripts)
StopFol.Size = UDim2.new(0.31, 0, 0, 26) StopFol.Position = UDim2.new(0.69, 0, 0, 404)
StopFol.BackgroundColor3 = Color3.fromRGB(180, 50, 50) StopFol.Text = "⏹️ Dừng" StopFol.TextColor3 = Color3.fromRGB(255, 255, 255) StopFol.Font = Enum.Font.GothamBold StopFol.TextSize = 10
Instance.new("UICorner", StopFol).CornerRadius = UDim.new(0, 6)

local folTarget, folConn = nil, nil
local function updateFolList()
    for _, ch in ipairs(FolS:GetChildren()) do if ch:IsA("TextButton") then ch:Destroy() end end
    folTarget = nil local y = 2
    for _, p in ipairs(Plrs:GetPlayers()) do
        if p ~= LP then
            local btn = Instance.new("TextButton", FolS)
            btn.Size = UDim2.new(1, -6, 0, 24) btn.Position = UDim2.new(0, 3, 0, y)
            btn.BackgroundColor3 = Color3.fromRGB(45, 45, 55) btn.Text = "🏃 " .. p.Name btn.TextColor3 = Color3.fromRGB(255, 255, 255) btn.Font = Enum.Font.Gotham btn.TextSize = 11
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
            btn.MouseButton1Click:Connect(function()
                folTarget = p
                for _, b in ipairs(FolS:GetChildren()) do if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(45, 45, 55) end end
                btn.BackgroundColor3 = Color3.fromRGB(50, 180, 80)
            end)
            y = y + 26
        end
    end
    FolS.CanvasSize = UDim2.new(0, 0, 0, y)
end
RefFol.MouseButton1Click:Connect(updateFolList) updateFolList()

StartFol.MouseButton1Click:Connect(function()
    if folConn then folConn:Disconnect() folConn = nil end
    if not folTarget then return end
    folConn = RunSvc.Heartbeat:Connect(function()
        local myChar, tChar = LP.Character, folTarget.Character
        local myHum, myHrp = myChar and myChar:FindFirstChildOfClass("Humanoid"), myChar and myChar:FindFirstChild("HumanoidRootPart")
        local tHrp = tChar and tChar:FindFirstChild("HumanoidRootPart")
        if myHum and myHrp and tHrp then
            if (myHrp.Position - tHrp.Position).Magnitude > 4 then
                myHum:MoveTo(tHrp.Position)
                if tHrp.Position.Y > myHrp.Position.Y + 3 then myHum.Jump = true end
            end
        end
    end)
end)
StopFol.MouseButton1Click:Connect(function() if folConn then folConn:Disconnect() folConn = nil end end)

-- ANTI AFK
local antiAfkConn = nil
local antiAfkLoop = nil
addTgl(CScripts, "Anti AFK", 438, function(st)
    if st then
        if antiAfkConn then antiAfkConn:Disconnect() antiAfkConn = nil end
        antiAfkConn = LP.Idled:Connect(function()
            pcall(function()
                VU:CaptureController()
                VU:ClickButton2(Vector2.new(0, 0), Wsp.CurrentCamera and Wsp.CurrentCamera.CFrame or CFrame.new())
            end)
        end)
        antiAfkLoop = task.spawn(function()
            while antiAfkConn do
                task.wait(120)
                if not antiAfkConn then break end
                pcall(function()
                    VU:CaptureController()
                    VU:ClickButton2(Vector2.new(0, 0), Wsp.CurrentCamera and Wsp.CurrentCamera.CFrame or CFrame.new())
                end)
            end
        end)
    else
        if antiAfkConn then antiAfkConn:Disconnect() antiAfkConn = nil end
        if antiAfkLoop then task.cancel(antiAfkLoop) antiAfkLoop = nil end
    end
end)

-- REJOIN (DỊCH CHUYỂN ĐẾN SERVER HỒI TRƯỚC / HIỆN TẠI)
local savedPlaceId = game.PlaceId
local savedJobId = game.JobId

local RejoinBtn = Instance.new("TextButton", CScripts)
RejoinBtn.Size = UDim2.new(1, 0, 0, 28)
RejoinBtn.Position = UDim2.new(0, 0, 0, 472)
RejoinBtn.BackgroundColor3 = Color3.fromRGB(50, 120, 180)
RejoinBtn.Text = "🔁 Rejoin Server"
RejoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RejoinBtn.Font = Enum.Font.GothamBold
RejoinBtn.TextSize = 11
Instance.new("UICorner", RejoinBtn).CornerRadius = UDim.new(0, 6)
RejoinBtn.MouseButton1Click:Connect(function()
    RejoinBtn.Text = "🔁 Đang dịch chuyển..."
    local ok = pcall(function()
        if savedJobId and savedJobId ~= "" then
            TS:TeleportToPlaceInstance(savedPlaceId, savedJobId, LP)
        else
            TS:Teleport(savedPlaceId, LP)
        end
    end)
    if not ok then
        pcall(function() TS:Teleport(savedPlaceId, LP) end)
    end
end)

-- HỖ TRỢ TẦM NGẮM (TÂM ĐỨT ĐOẠN + CHẤM TRUNG TÂM CHÍNH XÁC TUYỆT ĐỐI)
local crosshairGui = nil

local function destroyCrosshair()
    if crosshairGui then
        pcall(function() crosshairGui:Destroy() end)
        crosshairGui = nil
    end
    if Cg:FindFirstChild("CrosshairGui") then
        pcall(function() Cg.CrosshairGui:Destroy() end)
    end
end

local function createCrosshair()
    destroyCrosshair()

    local g = Instance.new("ScreenGui")
    g.Name = "CrosshairGui"
    g.ResetOnSpawn = false
    g.IgnoreGuiInset = true
    g.DisplayOrder = 999999
    g.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    g.Parent = Cg
    crosshairGui = g

    local holder = Instance.new("Frame")
    holder.Name = "CenterReticle"
    holder.AnchorPoint = Vector2.new(0.5, 0.5)
    holder.Size = UDim2.new(0, 41, 0, 41)
    holder.Position = UDim2.new(0.5, 0, 0.5, 0)
    holder.BackgroundTransparency = 1
    holder.BorderSizePixel = 0
    holder.Parent = g

    local gap = 5
    local armLen = 11
    local thick = 2

    local function mkArm(w, h, ax, ay, px, py)
        local bar = Instance.new("Frame")
        bar.AnchorPoint = Vector2.new(ax, ay)
        bar.Size = UDim2.new(0, w, 0, h)
        bar.Position = UDim2.new(0.5, px, 0.5, py)
        bar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        bar.BackgroundTransparency = 0.05
        bar.BorderSizePixel = 0
        bar.Parent = holder

        local st = Instance.new("UIStroke")
        st.Color = Color3.fromRGB(0, 0, 0)
        st.Thickness = 1
        st.Transparency = 0.35
        st.Parent = bar
    end

    mkArm(thick, armLen, 0.5, 1, 0, -gap)
    mkArm(thick, armLen, 0.5, 0, 0, gap)
    mkArm(armLen, thick, 1, 0.5, -gap, 0)
    mkArm(armLen, thick, 0, 0.5, gap, 0)

    local dot = Instance.new("Frame")
    dot.AnchorPoint = Vector2.new(0.5, 0.5)
    dot.Size = UDim2.new(0, 2, 0, 2)
    dot.Position = UDim2.new(0.5, 0, 0.5, 0)
    dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    dot.BorderSizePixel = 0
    dot.Parent = holder
end

addTgl(CScripts, "Hỗ trợ tầm ngắm", 506, function(st)
    if st then
        createCrosshair()
    else
        destroyCrosshair()
    end
end)

-- RADAR (PLAYER = XANH LÁ, NPC/QUÁI = ĐỎ, XÁC NGƯỜI CHƠI CHẾT = ĐEN)
local RADAR_RADIUS_STUDS = 120
local radarGui = nil
local radarFrame = nil
local radarStatusLbl = nil
local radarInnerClip = nil
local radarBlipPool = {}
local radarActiveBlips = 0
local radarConn = nil
local radarLastScan = 0
local radarCachedEntities = {}

local function hideRadarUnusedBlips()
    for i = radarActiveBlips + 1, #radarBlipPool do
        if radarBlipPool[i] then
            radarBlipPool[i].Visible = false
        end
    end
end

local function getRadarBlip(kind, color)
    radarActiveBlips = radarActiveBlips + 1
    local dot = radarBlipPool[radarActiveBlips]
    if not dot and radarInnerClip then
        dot = Instance.new("Frame")
        dot.AnchorPoint = Vector2.new(0.5, 0.5)
        dot.Size = UDim2.new(0, 7, 0, 7)
        dot.BorderSizePixel = 0
        dot.ZIndex = 4
        dot.Parent = radarInnerClip
        Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

        local st = Instance.new("UIStroke")
        st.Name = "DotStroke"
        st.Thickness = 1.1
        st.Transparency = 0.15
        st.Parent = dot

        radarBlipPool[radarActiveBlips] = dot
    end

    if not dot then return nil end
    dot.Name = kind .. "Blip"
    dot.BackgroundColor3 = color
    local st = dot:FindFirstChild("DotStroke")
    if st then
        if kind == "DeadPlayer" then
            st.Color = Color3.fromRGB(215, 220, 230)
        elseif kind == "Entity" then
            st.Color = Color3.fromRGB(255, 165, 165)
        else
            st.Color = Color3.fromRGB(185, 255, 210)
        end
    end
    dot.Visible = true
    return dot
end

local function getRadarOriginCFrame()
    local cam = Wsp.CurrentCamera
    local char = LP.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if cam and hrp then
        local look = cam.CFrame.LookVector
        local flatLook = Vector3.new(look.X, 0, look.Z)
        if flatLook.Magnitude > 0.001 then
            return CFrame.lookAt(hrp.Position, hrp.Position + flatLook.Unit)
        end
        return CFrame.new(hrp.Position)
    elseif hrp then
        return hrp.CFrame
    end
    return nil
end

local function worldToRadarCoord(originCF, targetPos, halfRadiusPx)
    local delta = targetPos - originCF.Position
    local flatDelta = Vector3.new(delta.X, 0, delta.Z)
    local dist = flatDelta.Magnitude

    if dist > RADAR_RADIUS_STUDS or dist < 0.05 then
        return nil
    end

    local localOffset = originCF:VectorToObjectSpace(flatDelta)
    local normX = math.clamp(localOffset.X / RADAR_RADIUS_STUDS, -1, 1)
    local normY = math.clamp(localOffset.Z / RADAR_RADIUS_STUDS, -1, 1)

    if (normX * normX + normY * normY) > 1 then
        return nil
    end

    local pxX = 0.5 + (normX * (halfRadiusPx - 5)) / halfRadiusPx * 0.5
    local pxY = 0.5 + (normY * (halfRadiusPx - 5)) / halfRadiusPx * 0.5
    return UDim2.new(pxX, 0, pxY, 0)
end

local function getOtherPlayerNameSet()
    local names = {}
    for _, p in ipairs(Plrs:GetPlayers()) do
        if p ~= LP then
            names[p.Name:lower()] = true
            names[p.DisplayName:lower()] = true
        end
    end
    return names
end

local function findModelRootPart(model)
    return model:FindFirstChild("HumanoidRootPart")
        or model:FindFirstChild("Torso")
        or model:FindFirstChild("UpperTorso")
        or model.PrimaryPart
        or model:FindFirstChildWhichIsA("BasePart")
end

local function refreshRadarEntities()
    table.clear(radarCachedEntities)
    local otherPlayerNames = getOtherPlayerNameSet()

    for _, desc in ipairs(Wsp:GetDescendants()) do
        if desc:IsA("Model") and desc ~= LP.Character then
            local ownerPlr = Plrs:GetPlayerFromCharacter(desc)
            if ownerPlr == LP then
                continue
            end

            local hum = desc:FindFirstChildOfClass("Humanoid")
            local root = findModelRootPart(desc)
            if not root then
                continue
            end

            local lowerName = desc.Name:lower()
            local isPlayerModel = (ownerPlr ~= nil) or (otherPlayerNames[lowerName] == true)

            if isPlayerModel then
                if hum and hum.Health <= 0 then
                    table.insert(radarCachedEntities, { root = root, kind = "DeadPlayer" })
                end
            elseif hum and hum.Health > 0 then
                table.insert(radarCachedEntities, { root = root, kind = "Entity" })
            end
        end
    end
end

local function destroyRadar()
    if radarConn then
        radarConn:Disconnect()
        radarConn = nil
    end
    table.clear(radarBlipPool)
    table.clear(radarCachedEntities)
    radarActiveBlips = 0
    radarLastScan = 0
    radarFrame = nil
    radarStatusLbl = nil
    radarInnerClip = nil
    if radarGui then
        pcall(function() radarGui:Destroy() end)
        radarGui = nil
    end
    if Cg:FindFirstChild("USBHubRadarGui") then
        pcall(function() Cg.USBHubRadarGui:Destroy() end)
    end
end

local function createRadar()
    destroyRadar()

    local g = Instance.new("ScreenGui")
    g.Name = "USBHubRadarGui"
    g.ResetOnSpawn = false
    g.IgnoreGuiInset = true
    g.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    g.Parent = Cg
    radarGui = g

    local radarSize = 152
    local rf = Instance.new("Frame")
    rf.Name = "RadarCircle"
    rf.AnchorPoint = Vector2.new(1, 0.5)
    rf.Size = UDim2.new(0, radarSize, 0, radarSize)
    rf.Position = UDim2.new(1, -18, 0.44, 0)
    rf.BackgroundColor3 = Color3.fromRGB(6, 22, 15)
    rf.BackgroundTransparency = 0.22
    rf.BorderSizePixel = 0
    rf.Active = true
    rf.Draggable = true
    rf.Parent = g
    Instance.new("UICorner", rf).CornerRadius = UDim.new(1, 0)
    radarFrame = rf

    local rStroke = Instance.new("UIStroke")
    rStroke.Color = Color3.fromRGB(60, 235, 140)
    rStroke.Thickness = 2.2
    rStroke.Parent = rf

    for i = 0, 59 do
        local angleDeg = i * 6
        local isMajor = (i % 5 == 0)
        local tickLen = isMajor and 7 or 4
        local tickHolder = Instance.new("Frame")
        tickHolder.AnchorPoint = Vector2.new(0.5, 0.5)
        tickHolder.Size = UDim2.new(1, 0, 1, 0)
        tickHolder.Position = UDim2.new(0.5, 0, 0.5, 0)
        tickHolder.BackgroundTransparency = 1
        tickHolder.Rotation = angleDeg
        tickHolder.Parent = rf

        local tick = Instance.new("Frame")
        tick.AnchorPoint = Vector2.new(0.5, 0)
        tick.Size = UDim2.new(0, isMajor and 2 or 1, 0, tickLen)
        tick.Position = UDim2.new(0.5, 0, 0, 1)
        tick.BackgroundColor3 = Color3.fromRGB(85, 245, 155)
        tick.BackgroundTransparency = isMajor and 0.1 or 0.45
        tick.BorderSizePixel = 0
        tick.Parent = tickHolder
    end

    local clip = Instance.new("Frame")
    clip.Name = "InnerClip"
    clip.AnchorPoint = Vector2.new(0.5, 0.5)
    clip.Size = UDim2.new(1, -16, 1, -16)
    clip.Position = UDim2.new(0.5, 0, 0.5, 0)
    clip.BackgroundColor3 = Color3.fromRGB(8, 28, 19)
    clip.BackgroundTransparency = 0.35
    clip.BorderSizePixel = 0
    clip.ClipsDescendants = true
    clip.Parent = rf
    Instance.new("UICorner", clip).CornerRadius = UDim.new(1, 0)
    radarInnerClip = clip

    for _, ratio in ipairs({0.33, 0.66, 0.96}) do
        local ring = Instance.new("Frame")
        ring.AnchorPoint = Vector2.new(0.5, 0.5)
        ring.Size = UDim2.new(ratio, 0, ratio, 0)
        ring.Position = UDim2.new(0.5, 0, 0.5, 0)
        ring.BackgroundTransparency = 1
        ring.BorderSizePixel = 0
        ring.Parent = clip
        Instance.new("UICorner", ring).CornerRadius = UDim.new(1, 0)

        local st = Instance.new("UIStroke")
        st.Color = Color3.fromRGB(55, 210, 125)
        st.Thickness = 1
        st.Transparency = 0.68
        st.Parent = ring
    end

    local hLine = Instance.new("Frame")
    hLine.AnchorPoint = Vector2.new(0.5, 0.5)
    hLine.Size = UDim2.new(1, 0, 0, 1)
    hLine.Position = UDim2.new(0.5, 0, 0.5, 0)
    hLine.BackgroundColor3 = Color3.fromRGB(55, 210, 125)
    hLine.BackgroundTransparency = 0.72
    hLine.BorderSizePixel = 0
    hLine.Parent = clip

    local vLine = Instance.new("Frame")
    vLine.AnchorPoint = Vector2.new(0.5, 0.5)
    vLine.Size = UDim2.new(0, 1, 1, 0)
    vLine.Position = UDim2.new(0.5, 0, 0.5, 0)
    vLine.BackgroundColor3 = Color3.fromRGB(55, 210, 125)
    vLine.BackgroundTransparency = 0.72
    vLine.BorderSizePixel = 0
    vLine.Parent = clip

    local sl = Instance.new("TextLabel")
    sl.Name = "StatusLabel"
    sl.AnchorPoint = Vector2.new(0.5, 0)
    sl.Size = UDim2.new(1, 44, 0, 18)
    sl.Position = UDim2.new(0.5, 0, 1, 4)
    sl.BackgroundTransparency = 1
    sl.Text = "SCANNING"
    sl.TextColor3 = Color3.fromRGB(95, 245, 160)
    sl.Font = Enum.Font.GothamBold
    sl.TextSize = 10
    sl.Parent = rf
    radarStatusLbl = sl

    local selfArrow = Instance.new("TextLabel")
    selfArrow.Name = "SelfArrow"
    selfArrow.AnchorPoint = Vector2.new(0.5, 0.5)
    selfArrow.Size = UDim2.new(0, 16, 0, 16)
    selfArrow.Position = UDim2.new(0.5, 0, 0.5, 0)
    selfArrow.BackgroundTransparency = 1
    selfArrow.Text = "^"
    selfArrow.TextColor3 = Color3.fromRGB(220, 255, 235)
    selfArrow.Font = Enum.Font.GothamBlack
    selfArrow.TextSize = 14
    selfArrow.ZIndex = 6
    selfArrow.Parent = clip

    radarConn = RunSvc.RenderStepped:Connect(function()
        if not radarGui or not radarGui.Parent or not radarFrame or not radarInnerClip then return end

        radarActiveBlips = 0
        local originCF = getRadarOriginCFrame()
        if not originCF then
            if radarStatusLbl then radarStatusLbl.Text = "NO SIGNAL" end
            hideRadarUnusedBlips()
            return
        end

        local halfPx = (radarSize - 16) * 0.5
        local playerCount = 0
        local entityCount = 0
        local deadCount = 0

        for _, plr in ipairs(Plrs:GetPlayers()) do
            if plr ~= LP and plr.Character then
                local hrp = findModelRootPart(plr.Character)
                local hum = plr.Character:FindFirstChildOfClass("Humanoid")
                if hrp and hum and hum.Health > 0 then
                    local pos = worldToRadarCoord(originCF, hrp.Position, halfPx)
                    if pos then
                        local blip = getRadarBlip("Player", Color3.fromRGB(45, 245, 110))
                        if blip then
                            blip.Position = pos
                            playerCount = playerCount + 1
                        end
                    end
                end
            end
        end

        local now = os.clock()
        if now - radarLastScan >= 0.5 then
            radarLastScan = now
            pcall(refreshRadarEntities)
        end

        for i = #radarCachedEntities, 1, -1 do
            local entry = radarCachedEntities[i]
            local root = entry.root
            if not root or not root.Parent then
                table.remove(radarCachedEntities, i)
            else
                local okPos, pos = pcall(worldToRadarCoord, originCF, root.Position, halfPx)
                if okPos and pos then
                    if entry.kind == "DeadPlayer" then
                        local blip = getRadarBlip("DeadPlayer", Color3.fromRGB(16, 16, 20))
                        if blip then
                            blip.Position = pos
                            deadCount = deadCount + 1
                        end
                    else
                        local blip = getRadarBlip("Entity", Color3.fromRGB(255, 55, 55))
                        if blip then
                            blip.Position = pos
                            entityCount = entityCount + 1
                        end
                    end
                end
            end
        end

        hideRadarUnusedBlips()
        if radarStatusLbl then
            radarStatusLbl.Text = string.format("P:%d  NPC/Q:%d  X:%d", playerCount, entityCount, deadCount)
        end
    end)
end

addTgl(CScripts, "Radar", 540, function(st)
    if st then
        createRadar()
    else
        destroyRadar()
    end
end)

-- TAB 4: VISUALS (ESP)
addLbl(CVisuals, "ESP Nhìn Xuyên Tường:", 5)
local espOn = false
local function makeEsp(plr)
    if plr == LP then return end
    local function addTag(char)
        if char:FindFirstChild("EspTag") then return end
        local hrp, hum = char:WaitForChild("HumanoidRootPart", 5), char:WaitForChild("Humanoid", 5)
        if not hrp or not hum then return end
        local bg = Instance.new("BillboardGui", hrp)
        bg.Name = "EspTag" bg.Adornee = hrp bg.Size = UDim2.new(0, 220, 0, 50) bg.StudsOffset = Vector3.new(0, 3, 0) bg.AlwaysOnTop = true
        local txt = Instance.new("TextLabel", bg)
        txt.Size = UDim2.new(1, 0, 1, 0) txt.BackgroundTransparency = 1 txt.TextColor3 = Color3.fromRGB(255, 255, 255) txt.TextStrokeTransparency = 0.2 txt.Font = Enum.Font.GothamBold txt.TextSize = 11 txt.TextWrapped = true
        task.spawn(function()
            while bg and bg.Parent and char and hrp and hum do
                RunSvc.RenderStepped:Wait()
                local myHrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
                if myHrp then
                    txt.Text = "Name: " .. plr.Name .. " | HP: " .. math.floor(hum.Health) .. " | Studs: " .. math.floor((myHrp.Position - hrp.Position).Magnitude)
                end
            end
        end)
    end
    if plr.Character then addTag(plr.Character) end
    plr.CharacterAdded:Connect(addTag)
end

local EspBtn = Instance.new("TextButton", CVisuals)
EspBtn.Size = UDim2.new(1, 0, 0, 28) EspBtn.Position = UDim2.new(0, 0, 0, 28)
EspBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55) EspBtn.Text = "ESP (Name/HP/Studs): TẮT" EspBtn.TextColor3 = Color3.fromRGB(255, 255, 255) EspBtn.Font = Enum.Font.GothamBold EspBtn.TextSize = 11
Instance.new("UICorner", EspBtn).CornerRadius = UDim.new(0, 6)
EspBtn.MouseButton1Click:Connect(function()
    espOn = not espOn
    EspBtn.Text = "ESP (Name/HP/Studs): " .. (espOn and "BẬT" or "TẮT")
    EspBtn.BackgroundColor3 = espOn and Color3.fromRGB(50, 180, 80) or Color3.fromRGB(45, 45, 55)
    if espOn then
        for _, p in ipairs(Plrs:GetPlayers()) do makeEsp(p) end
        Plrs.PlayerAdded:Connect(makeEsp)
    else
        for _, p in ipairs(Plrs:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local tag = p.Character.HumanoidRootPart:FindFirstChild("EspTag")
                if tag then tag:Destroy() end
            end
        end
    end
end)

-- TAB 5: INFO
addLbl(CInfo, "Thông tin & Tiện ích:", 5)

local function mkInfoBtn(txt, y, col, cb)
    local b = Instance.new("TextButton", CInfo)
    b.Size = UDim2.new(1, 0, 0, 32) b.Position = UDim2.new(0, 0, 0, y)
    b.BackgroundColor3 = col b.Text = txt b.TextColor3 = Color3.fromRGB(255, 255, 255) b.Font = Enum.Font.GothamBold b.TextSize = 12
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(cb)
end

mkInfoBtn("💬 Mickey Chat", 28, Color3.fromRGB(60, 50, 90), function()
    if Cg:FindFirstChild("MickeyChatGui") then Cg.MickeyChatGui:Destroy() return end
    local g = Instance.new("ScreenGui", Cg) g.Name = "MickeyChatGui"
    local f = Instance.new("Frame", g) f.Size = UDim2.new(0, 320, 0, 220) f.Position = UDim2.new(0.5, -160, 0.4, -110) f.BackgroundColor3 = Color3.fromRGB(30, 30, 38) f.Active = true f.Draggable = true
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
    local ti = Instance.new("TextLabel", f) ti.Size = UDim2.new(1, -30, 0, 28) ti.Position = UDim2.new(0, 10, 0, 0) ti.BackgroundTransparency = 1 ti.Text = "MICKEY CHAT" ti.TextColor3 = Color3.fromRGB(180, 140, 255) ti.Font = Enum.Font.GothamBold ti.TextSize = 12 ti.TextXAlignment = Enum.TextXAlignment.Left
    local cl = Instance.new("TextButton", f) cl.Size = UDim2.new(0, 24, 0, 24) cl.Position = UDim2.new(1, -28, 0, 2) cl.BackgroundColor3 = Color3.fromRGB(180, 50, 50) cl.Text = "X" cl.TextColor3 = Color3.fromRGB(255, 255, 255) cl.Font = Enum.Font.GothamBold cl.TextSize = 10
    Instance.new("UICorner", cl).CornerRadius = UDim.new(0, 4)
    cl.MouseButton1Click:Connect(function() g:Destroy() end)
    local sc = Instance.new("ScrollingFrame", f) sc.Size = UDim2.new(1, -16, 1, -75) sc.Position = UDim2.new(0, 8, 0, 32) sc.BackgroundColor3 = Color3.fromRGB(20, 20, 26) sc.BorderSizePixel = 0 sc.CanvasSize = UDim2.new(0, 0, 0, 0) sc.ScrollBarThickness = 3
    Instance.new("UICorner", sc).CornerRadius = UDim.new(0, 6)
    local lay = Instance.new("UIListLayout", sc) lay.SortOrder = Enum.SortOrder.LayoutOrder lay.Padding = UDim.new(0, 4)
    local ib = Instance.new("TextBox", f) ib.Size = UDim2.new(1, -16, 0, 30) ib.Position = UDim2.new(0, 8, 1, -36) ib.BackgroundColor3 = Color3.fromRGB(40, 40, 50) ib.Text = "" ib.PlaceholderText = "Nhập chat..." ib.TextColor3 = Color3.fromRGB(255, 255, 255) ib.Font = Enum.Font.Gotham ib.TextSize = 11
    Instance.new("UICorner", ib).CornerRadius = UDim.new(0, 6)
    ib.FocusLost:Connect(function(ep)
        if ep and ib.Text ~= "" then
            local lb = Instance.new("TextLabel", sc) lb.Size = UDim2.new(1, -10, 0, 20) lb.BackgroundTransparency = 1 lb.TextColor3 = Color3.fromRGB(220, 220, 220) lb.Font = Enum.Font.Gotham lb.TextSize = 11 lb.TextXAlignment = Enum.TextXAlignment.Left lb.Text = "[" .. LP.Name .. "]: " .. ib.Text
            ib.Text = "" sc.CanvasSize = UDim2.new(0, 0, 0, lay.AbsoluteContentSize.Y + 10) sc.CanvasPosition = Vector2.new(0, sc.CanvasSize.Y.Offset)
        end
    end)
end)

mkInfoBtn("🌍 Server Hop", 68, Color3.fromRGB(50, 100, 150), function()
    TS:Teleport(game.PlaceId, LP)
end)

mkInfoBtn("🌐 Translation Table", 108, Color3.fromRGB(150, 80, 50), function()
    if Cg:FindFirstChild("TranslationGui") then Cg.TranslationGui:Destroy() return end
    local g = Instance.new("ScreenGui", Cg) g.Name = "TranslationGui"
    local f = Instance.new("Frame", g) f.Size = UDim2.new(0, 310, 0, 210) f.Position = UDim2.new(0.5, -155, 0.4, -105) f.BackgroundColor3 = Color3.fromRGB(30, 30, 38) f.Active = true f.Draggable = true
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
    local ti = Instance.new("TextLabel", f) ti.Size = UDim2.new(1, -30, 0, 28) ti.Position = UDim2.new(0, 10, 0, 0) ti.BackgroundTransparency = 1 ti.Text = "Dịch Tiếng Việt" ti.TextColor3 = Color3.fromRGB(180, 140, 255) ti.Font = Enum.Font.GothamBold ti.TextSize = 11 ti.TextXAlignment = Enum.TextXAlignment.Left
    local cl = Instance.new("TextButton", f) cl.Size = UDim2.new(0, 24, 0, 24) cl.Position = UDim2.new(1, -28, 0, 2) cl.BackgroundColor3 = Color3.fromRGB(180, 50, 50) cl.Text = "X" cl.TextColor3 = Color3.fromRGB(255, 255, 255) cl.Font = Enum.Font.GothamBold cl.TextSize = 10
    Instance.new("UICorner", cl).CornerRadius = UDim.new(0, 4)
    cl.MouseButton1Click:Connect(function() g:Destroy() end)
    local ib = Instance.new("TextBox", f) ib.Size = UDim2.new(1, -16, 0, 50) ib.Position = UDim2.new(0, 8, 0, 32) ib.BackgroundColor3 = Color3.fromRGB(40, 40, 50) ib.Text = "" ib.PlaceholderText = "Nhập tiếng Anh..." ib.TextColor3 = Color3.fromRGB(255, 255, 255) ib.Font = Enum.Font.Gotham ib.TextSize = 11 ib.TextWrapped = true
    Instance.new("UICorner", ib).CornerRadius = UDim.new(0, 6)
    local btn = Instance.new("TextButton", f) btn.Size = UDim2.new(1, -16, 0, 26) btn.Position = UDim2.new(0, 8, 0, 88) btn.BackgroundColor3 = Color3.fromRGB(50, 160, 80) btn.Text = "Dịch" btn.TextColor3 = Color3.fromRGB(255, 255, 255) btn.Font = Enum.Font.GothamBold btn.TextSize = 11
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    local rs = Instance.new("ScrollingFrame", f) rs.Size = UDim2.new(1, -16, 0, 80) rs.Position = UDim2.new(0, 8, 0, 120) rs.BackgroundColor3 = Color3.fromRGB(20, 20, 26) rs.BorderSizePixel = 0 rs.CanvasSize = UDim2.new(0, 0, 0, 100) rs.ScrollBarThickness = 3
    Instance.new("UICorner", rs).CornerRadius = UDim.new(0, 6)
    local rl = Instance.new("TextLabel", rs) rl.Size = UDim2.new(1, -10, 1, 0) rl.Position = UDim2.new(0, 5, 0, 0) rl.BackgroundTransparency = 1 rl.Text = "Kết quả..." rl.TextColor3 = Color3.fromRGB(220, 220, 220) rl.Font = Enum.Font.Gotham rl.TextSize = 11 rl.TextXAlignment = Enum.TextXAlignment.Left rl.TextYAlignment = Enum.TextYAlignment.Top rl.TextWrapped = true
    btn.MouseButton1Click:Connect(function()
        if ib.Text == "" then return end
        rl.Text = "Đang dịch..."
        task.spawn(function()
            local sc, res = pcall(function()
                local resp = game:HttpGet("https://api.mymemory.translated.net/get?q=" .. HS:UrlEncode(ib.Text) .. "&langpair=en|vi")
                local data = HS:JSONDecode(resp)
                return data and data.responseData and data.responseData.translatedText or "Lỗi."
            end)
            rl.Text = sc and res or "Lỗi API."
        end)
    end)
end)

mkInfoBtn("👤 Player Info", 148, Color3.fromRGB(90, 50, 150), function()
    if Cg:FindFirstChild("PlayerInfoGui") then Cg.PlayerInfoGui:Destroy() return end
    local g = Instance.new("ScreenGui", Cg) g.Name = "PlayerInfoGui"
    local f = Instance.new("Frame", g) f.Size = UDim2.new(0, 360, 0, 310) f.Position = UDim2.new(0.5, -180, 0.4, -155) f.BackgroundColor3 = Color3.fromRGB(30, 30, 38) f.Active = true f.Draggable = true
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
    
    local ti = Instance.new("TextLabel", f) ti.Size = UDim2.new(1, -30, 0, 28) ti.Position = UDim2.new(0, 10, 0, 0) ti.BackgroundTransparency = 1 ti.Text = "Tra Cứu Player Chi Tiết" ti.TextColor3 = Color3.fromRGB(180, 140, 255) ti.Font = Enum.Font.GothamBold ti.TextSize = 12 ti.TextXAlignment = Enum.TextXAlignment.Left
    local cl = Instance.new("TextButton", f) cl.Size = UDim2.new(0, 24, 0, 24) cl.Position = UDim2.new(1, -28, 0, 2) cl.BackgroundColor3 = Color3.fromRGB(180, 50, 50) cl.Text = "X" cl.TextColor3 = Color3.fromRGB(255, 255, 255) cl.Font = Enum.Font.GothamBold cl.TextSize = 10
    Instance.new("UICorner", cl).CornerRadius = UDim.new(0, 4)
    cl.MouseButton1Click:Connect(function() g:Destroy() end)
    
    local ib = Instance.new("TextBox", f) ib.Size = UDim2.new(1, -16, 0, 28) ib.Position = UDim2.new(0, 8, 0, 32) ib.BackgroundColor3 = Color3.fromRGB(40, 40, 50) ib.Text = "" ib.PlaceholderText = "Nhập tên bất kỳ trên Roblox..." ib.TextColor3 = Color3.fromRGB(255, 255, 255) ib.Font = Enum.Font.Gotham ib.TextSize = 11
    Instance.new("UICorner", ib).CornerRadius = UDim.new(0, 6)
    
    local sBtn = Instance.new("TextButton", f) sBtn.Size = UDim2.new(0.48, -4, 0, 26) sBtn.Position = UDim2.new(0, 8, 0, 65) sBtn.BackgroundColor3 = Color3.fromRGB(50, 120, 180) sBtn.Text = "🔍 Tìm Kiếm" sBtn.TextColor3 = Color3.fromRGB(255, 255, 255) sBtn.Font = Enum.Font.GothamBold sBtn.TextSize = 11
    Instance.new("UICorner", sBtn).CornerRadius = UDim.new(0, 6)
    
    local rBtn = Instance.new("TextButton", f) rBtn.Size = UDim2.new(0.48, -4, 0, 26) rBtn.Position = UDim2.new(0.52, 4, 0, 65) rBtn.BackgroundColor3 = Color3.fromRGB(50, 160, 80) rBtn.Text = "🔄 Cập Nhật" rBtn.TextColor3 = Color3.fromRGB(255, 255, 255) rBtn.Font = Enum.Font.GothamBold rBtn.TextSize = 11
    Instance.new("UICorner", rBtn).CornerRadius = UDim.new(0, 6)
    
    local av = Instance.new("ImageLabel", f) av.Size = UDim2.new(0, 75, 0, 75) av.Position = UDim2.new(0, 8, 0, 96) av.BackgroundColor3 = Color3.fromRGB(20, 20, 26) av.Image = "rbxassetid://6023426915"
    Instance.new("UICorner", av).CornerRadius = UDim.new(0, 6)
    
    local infoSc = Instance.new("ScrollingFrame", f) infoSc.Size = UDim2.new(1, -95, 0, 75) infoSc.Position = UDim2.new(0, 88, 0, 96) infoSc.BackgroundColor3 = Color3.fromRGB(20, 20, 26) infoSc.BorderSizePixel = 0 infoSc.CanvasSize = UDim2.new(0, 0, 0, 100) infoSc.ScrollBarThickness = 3
    Instance.new("UICorner", infoSc).CornerRadius = UDim.new(0, 6)
    local lb = Instance.new("TextLabel", infoSc) lb.Size = UDim2.new(1, -10, 1, 0) lb.Position = UDim2.new(0, 5, 0, 0) lb.BackgroundTransparency = 1 lb.Text = "Nhập tên bất kỳ và bấm Tìm Kiếm." lb.TextColor3 = Color3.fromRGB(200, 200, 200) lb.Font = Enum.Font.Gotham lb.TextSize = 11 lb.TextXAlignment = Enum.TextXAlignment.Left lb.TextYAlignment = Enum.TextYAlignment.Top lb.TextWrapped = true

    local detailSc = Instance.new("ScrollingFrame", f) detailSc.Size = UDim2.new(1, -16, 0, 120) detailSc.Position = UDim2.new(0, 8, 0, 178) detailSc.BackgroundColor3 = Color3.fromRGB(20, 20, 26) detailSc.BorderSizePixel = 0 detailSc.CanvasSize = UDim2.new(0, 0, 0, 0) detailSc.ScrollBarThickness = 4
    Instance.new("UICorner", detailSc).CornerRadius = UDim.new(0, 6)
    local detailLay = Instance.new("UIListLayout", detailSc) detailLay.SortOrder = Enum.SortOrder.LayoutOrder detailLay.Padding = UDim.new(0, 4)

    local function search()
        local q = ib.Text:lower()
        if q == "" then lb.Text = "Vui lòng nhập tên!" return end
        lb.Text = "⏳ Đang tra cứu chi tiết..."
        for _, ch in ipairs(detailSc:GetChildren()) do if ch:IsA("TextLabel") then ch:Destroy() end end
        
        task.spawn(function()
            local targetUserId = nil
            local foundPlr = nil
            
            for _, p in ipairs(Plrs:GetPlayers()) do
                if p.Name:lower():sub(1, #q) == q or p.DisplayName:lower():sub(1, #q) == q then
                    foundPlr = p
                    targetUserId = p.UserId
                    break
                end
            end
            
            if not targetUserId then
                local successId, id = pcall(function()
                    return Plrs:GetUserIdFromNameAsync(ib.Text)
                end)
                if successId and id then
                    targetUserId = id
                end
            end
            
            if targetUserId then
                local scs, url = pcall(function() return Plrs:GetUserThumbnailAsync(targetUserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420) end)
                if scs and url then av.Image = url end
                
                local username = foundPlr and foundPlr.Name or ib.Text
                local displayName = username
                local creationDateText = "Không rõ"
                
                local scsApi, apiRes = pcall(function()
                    return game:HttpGet("https://users.roblox.com/v1/users/" .. targetUserId)
                end)
                if scsApi and apiRes then
                    local data = HS:JSONDecode(apiRes)
                    if data then
                        if data.name then username = data.name end
                        if data.displayName then displayName = data.displayName end
                        if data.created then
                            local year, month, day = data.created:match("(%d+)-(%d+)-(%d+)")
                            if year and month and day then
                                creationDateText = day .. "/" .. month .. "/" .. year
                            end
                        end
                    end
                end
                
                local totalRobux = 0
                local hasLimited = false
                local scsD, desc = pcall(function() return Plrs:GetHumanoidDescriptionFromUserId(targetUserId) end)
                
                if scsD and desc then
                    local seenIds = {}
                    local allAssetIds = {}

                    local function pushAsset(id)
                        if type(id) == "number" and id > 0 and not seenIds[id] then
                            seenIds[id] = true
                            table.insert(allAssetIds, id)
                        end
                    end

                    pushAsset(desc.GraphicTShirt)
                    pushAsset(desc.Shirt)
                    pushAsset(desc.Pants)
                    pushAsset(desc.Face)
                    pushAsset(desc.Head)
                    pushAsset(desc.Torso)
                    pushAsset(desc.LeftArm)
                    pushAsset(desc.RightArm)
                    pushAsset(desc.LeftLeg)
                    pushAsset(desc.RightLeg)
                    
                    local function addAccList(accs)
                        if accs then
                            for _, a in ipairs(accs) do
                                pushAsset(a.AssetId or a.assetId)
                            end
                        end
                    end
                    
                    pcall(function() addAccList(desc:GetAccessories(false)) end)
                    pcall(function() addAccList(desc:GetAccessories(true)) end)
                    
                    for _, id in ipairs(allAssetIds) do
                        local sInfo, info = pcall(function() return MS:GetProductInfo(id) end)
                        if sInfo and info then
                            local itemName = info.Name or ("Món đồ (#" .. id .. ")")
                            local creatorName = (info.Creator and info.Creator.Name) or "Roblox"
                            local isLim = (info.IsLimited == true) or (info.IsLimitedUnique == true)
                            
                            local rawPrice = info.PriceInRobux
                            local priceText = "0 R$ (Miễn phí)"
                            
                            if rawPrice and type(rawPrice) == "number" and rawPrice > 0 and rawPrice < 1000000000 then
                                totalRobux = totalRobux + rawPrice
                                priceText = rawPrice .. " R$"
                            elseif isLim then
                                hasLimited = true
                                priceText = "[Limited]"
                            end

                            if isLim then
                                hasLimited = true
                            end
                            
                            local itemLbl = Instance.new("TextLabel", detailSc)
                            itemLbl.Size = UDim2.new(1, -10, 0, 36)
                            itemLbl.BackgroundTransparency = 1
                            itemLbl.TextColor3 = Color3.fromRGB(230, 230, 230)
                            itemLbl.Font = Enum.Font.Gotham
                            itemLbl.TextSize = 10
                            itemLbl.TextXAlignment = Enum.TextXAlignment.Left
                            itemLbl.TextYAlignment = Enum.TextYAlignment.Top
                            itemLbl.TextWrapped = true
                            itemLbl.Text = "🔸 " .. itemName .. "\n   Tác giả: " .. creatorName .. " | Giá: " .. priceText
                        end
                    end
                end
                
                local limNote = hasLimited and " (có đồ Limited)" or ""
                detailSc.CanvasSize = UDim2.new(0, 0, 0, detailLay.AbsoluteContentSize.Y + 10)
                lb.Text = "👤 " .. displayName .. "\n   @" .. username .. "\n🆔 ID: " .. targetUserId .. "\n📅 Tạo: " .. creationDateText .. "\n💎 Tổng: " .. totalRobux .. " R$" .. limNote
            else
                lb.Text = "❌ Không tìm thấy người chơi này!"
                av.Image = "rbxassetid://6023426915"
            end
        end)
    end
    
    sBtn.MouseButton1Click:Connect(search)
    rBtn.MouseButton1Click:Connect(search)
end)

mkInfoBtn("🧮 Máy Tính", 188, Color3.fromRGB(45, 45, 58), function()
    if Cg:FindFirstChild("CalculatorGui") then Cg.CalculatorGui:Destroy() return end

    local g = Instance.new("ScreenGui", Cg)
    g.Name = "CalculatorGui"
    g.ResetOnSpawn = false

    local f = Instance.new("Frame", g)
    f.Size = UDim2.new(0, 236, 0, 355)
    f.Position = UDim2.new(0.5, -118, 0.5, -177)
    f.BackgroundColor3 = Color3.fromRGB(16, 16, 18)
    f.BorderSizePixel = 0
    f.Active = true
    f.Draggable = true
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 16)

    local topBar = Instance.new("Frame", f)
    topBar.Size = UDim2.new(1, 0, 0, 28)
    topBar.BackgroundTransparency = 1

    local titleLbl = Instance.new("TextLabel", topBar)
    titleLbl.Size = UDim2.new(1, -36, 1, 0)
    titleLbl.Position = UDim2.new(0, 12, 0, 0)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = "MÁY TÍNH"
    titleLbl.TextColor3 = Color3.fromRGB(180, 180, 190)
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.TextSize = 11
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left

    local closeBtn = Instance.new("TextButton", topBar)
    closeBtn.Size = UDim2.new(0, 22, 0, 22)
    closeBtn.Position = UDim2.new(1, -26, 0, 3)
    closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 11
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)
    closeBtn.MouseButton1Click:Connect(function() g:Destroy() end)

    local exprLbl = Instance.new("TextLabel", f)
    exprLbl.Size = UDim2.new(1, -20, 0, 22)
    exprLbl.Position = UDim2.new(0, 10, 0, 32)
    exprLbl.BackgroundTransparency = 1
    exprLbl.Text = ""
    exprLbl.TextColor3 = Color3.fromRGB(150, 150, 160)
    exprLbl.Font = Enum.Font.Gotham
    exprLbl.TextSize = 12
    exprLbl.TextXAlignment = Enum.TextXAlignment.Right
    exprLbl.TextTruncate = Enum.TextTruncate.AtEnd

    local dispLbl = Instance.new("TextLabel", f)
    dispLbl.Size = UDim2.new(1, -20, 0, 42)
    dispLbl.Position = UDim2.new(0, 10, 0, 54)
    dispLbl.BackgroundTransparency = 1
    dispLbl.Text = "0"
    dispLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    dispLbl.Font = Enum.Font.GothamBold
    dispLbl.TextSize = 24
    dispLbl.TextXAlignment = Enum.TextXAlignment.Right
    dispLbl.TextTruncate = Enum.TextTruncate.AtEnd

    local pad = Instance.new("Frame", f)
    pad.Size = UDim2.new(1, -16, 1, -106)
    pad.Position = UDim2.new(0, 8, 0, 100)
    pad.BackgroundTransparency = 1

    local expr = ""
    local justEvaluated = false

    local function fmtNum(n)
        if type(n) ~= "number" or n ~= n or n == math.huge or n == -math.huge then
            return "Lỗi"
        end
        local rounded = math.floor(n * 1e9 + 0.5) / 1e9
        if math.abs(rounded - math.floor(rounded)) < 1e-9 then
            return tostring(math.floor(rounded))
        end
        local s = tostring(rounded):gsub("%.", ",")
        return s
    end

    local function evalExpr(raw)
        if raw == "" then return "0" end
        local luaExpr = raw:gsub(",", "."):gsub("x", "*"):gsub(":", "/")
        if luaExpr:match("[^%d%+%-%*/%.%(%)%s]") then
            return "Lỗi"
        end
        local fn, err = loadstring("return (" .. luaExpr .. ")")
        if not fn or err then
            return "Lỗi"
        end
        local ok, res = pcall(fn)
        if not ok or type(res) ~= "number" then
            return "Lỗi"
        end
        return fmtNum(res)
    end

    local function refreshDisp()
        if expr == "" then
            dispLbl.Text = "0"
            exprLbl.Text = ""
        else
            dispLbl.Text = expr
            exprLbl.Text = ""
        end
    end

    local function isOp(ch)
        return ch == "+" or ch == "-" or ch == "x" or ch == ":"
    end

    local function currentNumberPart()
        local lastOpPos = 0
        for i = #expr, 1, -1 do
            local c = expr:sub(i, i)
            if isOp(c) then
                lastOpPos = i
                break
            end
        end
        return expr:sub(lastOpPos + 1)
    end

    local function pressKey(key)
        if key == "AC" then
            expr = ""
            justEvaluated = false
            dispLbl.Text = "0"
            exprLbl.Text = ""
            return
        end

        if key == "DEL" then
            if justEvaluated then
                expr = ""
                justEvaluated = false
                dispLbl.Text = "0"
                exprLbl.Text = ""
                return
            end
            if #expr > 0 then
                expr = expr:sub(1, -2)
            end
            refreshDisp()
            return
        end

        if key == "=" then
            if expr == "" then return end
            local clean = expr
            while #clean > 0 and isOp(clean:sub(-1, -1)) do
                clean = clean:sub(1, -2)
            end
            if clean == "" then
                expr = ""
                dispLbl.Text = "0"
                exprLbl.Text = ""
                return
            end
            exprLbl.Text = clean
            local resText = evalExpr(clean)
            dispLbl.Text = resText
            if resText == "Lỗi" then
                expr = ""
                justEvaluated = false
            else
                expr = resText
                justEvaluated = true
            end
            return
        end

        if isOp(key) then
            justEvaluated = false
            if expr == "" then
                if key == "-" then
                    expr = "-"
                end
                refreshDisp()
                return
            end
            local lastChar = expr:sub(-1, -1)
            if isOp(lastChar) then
                expr = expr:sub(1, -2) .. key
            elseif lastChar == "," then
                expr = expr .. "0" .. key
            else
                expr = expr .. key
            end
            refreshDisp()
            return
        end

        if key == "," then
            if justEvaluated then
                expr = "0,"
                justEvaluated = false
                refreshDisp()
                return
            end
            local part = currentNumberPart()
            if part == "" or isOp(expr:sub(-1, -1)) then
                expr = expr .. "0,"
            elseif not part:find(",", 1, true) then
                expr = expr .. ","
            end
            refreshDisp()
            return
        end

        if justEvaluated then
            expr = (key == "00") and "0" or key
            justEvaluated = false
            refreshDisp()
            return
        end

        local part = currentNumberPart()
        if part == "0" then
            if key == "00" or key == "0" then
                refreshDisp()
                return
            else
                expr = expr:sub(1, -2) .. key
                refreshDisp()
                return
            end
        end

        if part == "" and key == "00" then
            expr = expr .. "0"
            refreshDisp()
            return
        end

        expr = expr .. key
        refreshDisp()
    end

    local rows = {
        {
            {t = "AC", k = "AC", bg = Color3.fromRGB(52, 52, 58), fg = Color3.fromRGB(255, 255, 255)},
            {t = "⌫",  k = "DEL", bg = Color3.fromRGB(40, 40, 46), fg = Color3.fromRGB(255, 190, 110)},
            {t = ":",  k = ":", bg = Color3.fromRGB(40, 40, 46), fg = Color3.fromRGB(255, 159, 67)},
            {t = "x",  k = "x", bg = Color3.fromRGB(40, 40, 46), fg = Color3.fromRGB(255, 159, 67)},
        },
        {
            {t = "7",  k = "7", bg = Color3.fromRGB(32, 32, 36), fg = Color3.fromRGB(255, 255, 255)},
            {t = "8",  k = "8", bg = Color3.fromRGB(32, 32, 36), fg = Color3.fromRGB(255, 255, 255)},
            {t = "9",  k = "9", bg = Color3.fromRGB(32, 32, 36), fg = Color3.fromRGB(255, 255, 255)},
            {t = "-",  k = "-", bg = Color3.fromRGB(40, 40, 46), fg = Color3.fromRGB(255, 159, 67)},
        },
        {
            {t = "4",  k = "4", bg = Color3.fromRGB(32, 32, 36), fg = Color3.fromRGB(255, 255, 255)},
            {t = "5",  k = "5", bg = Color3.fromRGB(32, 32, 36), fg = Color3.fromRGB(255, 255, 255)},
            {t = "6",  k = "6", bg = Color3.fromRGB(32, 32, 36), fg = Color3.fromRGB(255, 255, 255)},
            {t = "+",  k = "+", bg = Color3.fromRGB(40, 40, 46), fg = Color3.fromRGB(255, 159, 67)},
        },
        {
            {t = "1",  k = "1", bg = Color3.fromRGB(32, 32, 36), fg = Color3.fromRGB(255, 255, 255)},
            {t = "2",  k = "2", bg = Color3.fromRGB(32, 32, 36), fg = Color3.fromRGB(255, 255, 255)},
            {t = "3",  k = "3", bg = Color3.fromRGB(32, 32, 36), fg = Color3.fromRGB(255, 255, 255)},
            {t = "=",  k = "=", bg = Color3.fromRGB(255, 149, 0), fg = Color3.fromRGB(255, 255, 255)},
        },
        {
            {t = "00", k = "00", bg = Color3.fromRGB(32, 32, 36), fg = Color3.fromRGB(255, 255, 255)},
            {t = "0",  k = "0", bg = Color3.fromRGB(32, 32, 36), fg = Color3.fromRGB(255, 255, 255)},
            {t = ",",  k = ",", bg = Color3.fromRGB(32, 32, 36), fg = Color3.fromRGB(255, 255, 255)},
        },
    }

    local gap = 6
    local cols = 4
    local rowCount = #rows
    local btnW = (220 - gap * (cols - 1)) / cols
    local btnH = (245 - gap * (rowCount - 1)) / rowCount

    for rIdx, row in ipairs(rows) do
        for cIdx, cfg in ipairs(row) do
            local btn = Instance.new("TextButton", pad)
            local w = (cfg.k == ",") and (btnW * 2 + gap) or btnW
            local x = (cIdx - 1) * (btnW + gap)
            local y = (rIdx - 1) * (btnH + gap)

            btn.Size = UDim2.new(0, w, 0, btnH)
            btn.Position = UDim2.new(0, x, 0, y)
            btn.BackgroundColor3 = cfg.bg
            btn.Text = cfg.t
            btn.TextColor3 = cfg.fg
            btn.Font = Enum.Font.GothamBold
            btn.TextSize = 15
            btn.BorderSizePixel = 0
            Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)

            btn.MouseButton1Click:Connect(function()
                pressKey(cfg.k)
            end)
        end
    end
end)

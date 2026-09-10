-- == SERVICES ==
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- == KIRIM DONOR MESSAGE (script asli kamu) ==
local remotes = ReplicatedStorage:FindFirstChild("Remotes")
if remotes then
    local submitDonorMessage = remotes:FindFirstChild("SubmitDonorMessage")
    if submitDonorMessage then
        submitDonorMessage:FireServer({
            userId = player.UserId,
            message = "by kurama",
            token = "kuramamods"
        })
    end
end

-- == HAPUS GUI LAMA KALAU ADA ==
local oldGui = playerGui:FindFirstChild("SupportGUI")
if oldGui then oldGui:Destroy() end

-- == BUAT SCREEN GUI ==
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SupportGUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- == FRAME UTAMA ==
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 380, 0, 260)
mainFrame.Position = UDim2.new(0.5, -190, 0.5, -130)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Parent = screenGui

-- Corner
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainFrame

-- Stroke
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(90, 90, 130)
stroke.Thickness = 1.5
stroke.Parent = mainFrame

-- == TITLE BAR ==
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = titleBar

-- Fix sudut bawah title bar biar kotak
local titleFix = Instance.new("Frame")
titleFix.Size = UDim2.new(1, 0, 0, 15)
titleFix.Position = UDim2.new(0, 0, 1, -15)
titleFix.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
titleFix.BorderSizePixel = 0
titleFix.Parent = titleBar

-- Title Text
local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, -80, 1, 0)
titleText.Position = UDim2.new(0, 10, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "📩 Support Message"
titleText.TextColor3 = Color3.fromRGB(220, 220, 255)
titleText.TextSize = 16
titleText.Font = Enum.Font.GothamBold
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

-- == TOMBOL CLOSE ==
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseBtn"
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -34, 0, 4)
closeBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 16
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- == TOMBOL MINIMIZE ==
local minBtn = Instance.new("TextButton")
minBtn.Name = "MinBtn"
minBtn.Size = UDim2.new(0, 28, 0, 28)
minBtn.Position = UDim2.new(1, -68, 0, 4)
minBtn.BackgroundColor3 = Color3.fromRGB(240, 190, 60)
minBtn.Text = "—"
minBtn.TextColor3 = Color3.fromRGB(40, 40, 40)
minBtn.TextSize = 18
minBtn.Font = Enum.Font.GothamBold
minBtn.BorderSizePixel = 0
minBtn.Parent = titleBar

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 6)
minCorner.Parent = minBtn

-- == CONTAINER ISI (untuk hide saat minimize) ==
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, -20, 1, -55)
contentFrame.Position = UDim2.new(0, 10, 0, 45)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

local isMinimized = false
minBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        contentFrame.Visible = false
        mainFrame.Size = UDim2.new(0, 380, 0, 40)
        minBtn.Text = "□"
    else
        contentFrame.Visible = true
        mainFrame.Size = UDim2.new(0, 380, 0, 260)
        minBtn.Text = "—"
    end
end)

-- == LABEL MESSAGE ==
local msgLabel = Instance.new("TextLabel")
msgLabel.Size = UDim2.new(1, 0, 0, 20)
msgLabel.Position = UDim2.new(0, 0, 0, 0)
msgLabel.BackgroundTransparency = 1
msgLabel.Text = "Pesan Support:"
msgLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
msgLabel.TextSize = 14
msgLabel.Font = Enum.Font.GothamMedium
msgLabel.TextXAlignment = Enum.TextXAlignment.Left
msgLabel.Parent = contentFrame

-- == TEXTBOX MESSAGE ==
local msgBox = Instance.new("TextBox")
msgBox.Size = UDim2.new(1, 0, 0, 120)
msgBox.Position = UDim2.new(0, 0, 0, 24)
msgBox.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
msgBox.Text = ""
msgBox.PlaceholderText = "Tulis pesan support di sini..."
msgBox.TextColor3 = Color3.fromRGB(230, 230, 255)
msgBox.PlaceholderColor3 = Color3.fromRGB(130, 130, 160)
msgBox.TextSize = 14
msgBox.Font = Enum.Font.Gotham
msgBox.TextXAlignment = Enum.TextXAlignment.Left
msgBox.TextYAlignment = Enum.TextYAlignment.Top
msgBox.TextWrapped = true
msgBox.ClearTextOnFocus = false
msgBox.MultiLine = true
msgBox.BorderSizePixel = 0
msgBox.Parent = contentFrame

local tbCorner = Instance.new("UICorner")
tbCorner.CornerRadius = UDim.new(0, 6)
tbCorner.Parent = msgBox

local tbPad = Instance.new("UIPadding")
tbPad.PaddingTop = UDim.new(0, 6)
tbPad.PaddingLeft = UDim.new(0, 8)
tbPad.PaddingRight = UDim.new(0, 8)
tbPad.Parent = msgBox

-- == TOMBOL KIRIM ==
local sendBtn = Instance.new("TextButton")
sendBtn.Size = UDim2.new(1, 0, 0, 34)
sendBtn.Position = UDim2.new(0, 0, 0, 152)
sendBtn.BackgroundColor3 = Color3.fromRGB(80, 140, 255)
sendBtn.Text = "📤  Kirim Support"
sendBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
sendBtn.TextSize = 15
sendBtn.Font = Enum.Font.GothamBold
sendBtn.BorderSizePixel = 0
sendBtn.Parent = contentFrame

local sbCorner = Instance.new("UICorner")
sbCorner.CornerRadius = UDim.new(0, 6)
sbCorner.Parent = sendBtn

-- == NOTIFIKASI SEDERHANA ==
local function showNotif(text, color)
    local notif = Instance.new("TextLabel")
    notif.Size = UDim2.new(0, 260, 0, 36)
    notif.Position = UDim2.new(0.5, -130, 1, -60)
    notif.BackgroundColor3 = color or Color3.fromRGB(50, 50, 70)
    notif.Text = text
    notif.TextColor3 = Color3.fromRGB(255, 255, 255)
    notif.TextSize = 14
    notif.Font = Enum.Font.GothamBold
    notif.BorderSizePixel = 0
    notif.Parent = screenGui
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = notif
    task.delay(2, function()
        local tween = TweenService:Create(notif, TweenInfo.new(0.4), {BackgroundTransparency = 1, TextTransparency = 1})
        tween:Play()
        tween.Completed:Connect(function() notif:Destroy() end)
    end)
end

-- == HANDLE KIRIM ==
sendBtn.MouseButton1Click:Connect(function()
    local pesan = msgBox.Text
    if pesan == "" or #pesan < 2 then
        showNotif("⚠️ Pesan tidak boleh kosong!", Color3.fromRGB(180, 60, 60))
        return
    end

    -- Kirim lewat remote (kalau ada)
    if remotes then
        local submitDonorMessage = remotes:FindFirstChild("SubmitDonorMessage")
        if submitDonorMessage then
            local success, err = pcall(function()
                submitDonorMessage:FireServer({
                    userId = player.UserId,
                    message = pesan,
                    token = "kuramamods"
                })
            end)
            if success then
                showNotif("✅ Support terkirim!", Color3.fromRGB(50, 140, 80))
                msgBox.Text = ""
            else
                showNotif("❌ Gagal kirim: " .. tostring(err), Color3.fromRGB(180, 60, 60))
            end
        else
            showNotif("❌ Remote tidak ditemukan", Color3.fromRGB(180, 60, 60))
        end
    else
        showNotif("❌ Remotes folder tidak ada", Color3.fromRGB(180, 60, 60))
    end
end)

-- == DRAG SUPPORT (manual, lebih smooth) ==
local dragging, dragInput, dragStart, startPos

local function updateDrag(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(
        startPos.X.Scale, startPos.X.Offset + delta.X,
        startPos.Y.Scale, startPos.Y.Offset + delta.Y
    )
end

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateDrag(input)
    end
end)

-- == BUKA GUI OTOMATIS ==
screenGui.Enabled = true
print("[SupportGUI] GUI berhasil dimuat - by kurama")
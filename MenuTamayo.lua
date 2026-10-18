local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

if PlayerGui:FindFirstChild("MenuTamayo") then PlayerGui.MenuTamayo:Destroy() end

local Minimizado, AbaAtiva = false, "Combat"
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MenuTamayo"; ScreenGui.ResetOnSpawn = false; ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 420); 
MainFrame.Position = UDim2.new(0.5, -160, 0.3, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 25, 35); MainFrame.BorderSizePixel = 0
MainFrame.Active = true; MainFrame.Draggable = true; MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -45, 0, 35); Title.Position = UDim2.new(0, 12, 0, 0); Title.BackgroundTransparency = 1
Title.Text = "🔮 Menu Tamayo v14.1"; Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold; Title.TextSize = 14; Title.TextXAlignment = Enum.TextXAlignment.Left; Title.Parent = MainFrame

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 26, 0, 26); MinimizeButton.Position = UDim2.new(1, -32, 0, 5)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(45, 38, 52); MinimizeButton.Text = "-"; MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Font = Enum.Font.SourceSansBold; MinimizeButton.TextSize = 14; MinimizeButton.Parent = MainFrame
Instance.new("UICorner", MinimizeButton).CornerRadius = UDim.new(0, 6)

local TabsContainer = Instance.new("Frame")
TabsContainer.Size = UDim2.new(1, -20, 0, 30); TabsContainer.Position = UDim2.new(0, 10, 0, 40); TabsContainer.BackgroundTransparency = 1; TabsContainer.Parent = MainFrame

local function CriarPagina()
    local Page = Instance.new("Frame")
    Page.Size = UDim2.new(1, -20, 1, -85); Page.Position = UDim2.new(0, 10, 0, 75); Page.BackgroundTransparency = 1
    Page.Visible = false; Page.Parent = MainFrame
    return Page
end

local AutoFarmPage, PetsPage, CombatPage, SpinPage = CriarPagina(), CriarPagina(), CriarPagina(), CriarPagina()
CombatPage.Visible = true 

local function CriarAba(nome, pos, pag, idAba)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0, 70, 1, 0); Btn.Position = UDim2.new(0, pos, 0, 0)
    Btn.BackgroundColor3 = (idAba == "Combat") and Color3.fromRGB(65, 55, 80) or Color3.fromRGB(40, 35, 45)
    Btn.Text = nome; Btn.TextColor3 = (idAba == "Combat") and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
    Btn.Font = Enum.Font.SourceSansBold; Btn.TextSize = 10; Btn.Parent = TabsContainer
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    
    Btn.Activated:Connect(function()
        AbaAtiva = idAba
        for _, b in pairs(TabsContainer:GetChildren()) do
            if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(40, 35, 45); b.TextColor3 = Color3.fromRGB(180, 180, 180) end
        end
        Btn.BackgroundColor3 = Color3.fromRGB(65, 55, 80); Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        AutoFarmPage.Visible, PetsPage.Visible, CombatPage.Visible, SpinPage.Visible = false, false, false, false
        pag.Visible = true
    end)
end

CriarAba("Farm", 0, AutoFarmPage, "AutoFarm") 
CriarAba("Pets", 75, PetsPage, "Pets")
CriarAba("Combat", 150, CombatPage, "Combat")
CriarAba("Spin", 225, SpinPage, "Spin")

-- === CONTAINER COM ROLAGEM NA ABA COMBAT ===
local CombatScroll = Instance.new("ScrollingFrame")
CombatScroll.Size = UDim2.new(1, 0, 1, 0)
CombatScroll.BackgroundTransparency = 1
CombatScroll.ScrollBarThickness = 2
CombatScroll.ScrollBarImageColor3 = Color3.fromRGB(80, 70, 95)
CombatScroll.CanvasSize = UDim2.new(0, 0, 0, 420)
CombatScroll.Parent = CombatPage

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = CombatScroll
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)

-- === SISTEMA DE VELOCIDADE ===
local SpeedEnabled = true 
local TargetSpeed = 16 

RunService.RenderStepped:Connect(function()
    if SpeedEnabled then
        local char = Players.LocalPlayer.Character
        if char then
            local humanoid = char:FindFirstChild("Humanoid")
            if humanoid and humanoid.WalkSpeed ~= TargetSpeed then
                humanoid.WalkSpeed = TargetSpeed
            end
        end
    end
end)

local WalkspeedHeader = Instance.new("TextLabel")
WalkspeedHeader.Size = UDim2.new(1, 0, 0, 20)
WalkspeedHeader.BackgroundTransparency = 1
WalkspeedHeader.Text = "Enable Custom WalkSpeed"
WalkspeedHeader.TextColor3 = Color3.fromRGB(200, 200, 200)
WalkspeedHeader.Font = Enum.Font.SourceSansBold
WalkspeedHeader.TextSize = 13
WalkspeedHeader.TextXAlignment = Enum.TextXAlignment.Left
WalkspeedHeader.LayoutOrder = 1
WalkspeedHeader.Parent = CombatScroll

local SpeedFrame = Instance.new("Frame")
SpeedFrame.Size = UDim2.new(1, 0, 0, 45)
SpeedFrame.BackgroundColor3 = Color3.fromRGB(45, 38, 52)
SpeedFrame.LayoutOrder = 2
SpeedFrame.Parent = CombatScroll
Instance.new("UICorner", SpeedFrame).CornerRadius = UDim.new(0, 6)

local ToggleSwitch = Instance.new("TextButton")
ToggleSwitch.Size = UDim2.new(0, 35, 0, 18)
ToggleSwitch.Position = UDim2.new(1, -45, 0, 13)
ToggleSwitch.BackgroundColor3 = Color3.fromRGB(50, 150, 80)
ToggleSwitch.Text = ""
ToggleSwitch.Parent = SpeedFrame
Instance.new("UICorner", ToggleSwitch).CornerRadius = UDim.new(0, 9)

local ToggleCircle = Instance.new("Frame")
ToggleCircle.Size = UDim2.new(0, 14, 0, 14)
ToggleCircle.Position = UDim2.new(1, -16, 0, 2)
ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ToggleCircle.Parent = ToggleSwitch
Instance.new("UICorner", ToggleCircle).CornerRadius = UDim.new(0, 7)

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0, 120, 1, 0)
SpeedLabel.Position = UDim2.new(0, 12, 0, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "WalkSpeed Value"
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Font = Enum.Font.SourceSansBold
SpeedLabel.TextSize = 13
SpeedLabel.Parent = SpeedFrame

local SpeedDisplayContainer = Instance.new("Frame")
SpeedDisplayContainer.Size = UDim2.new(0, 90, 0, 24)
SpeedDisplayContainer.Position = UDim2.new(0, 140, 0, 10)
SpeedDisplayContainer.BackgroundColor3 = Color3.fromRGB(25, 20, 30)
SpeedDisplayContainer.BorderSizePixel = 1
SpeedDisplayContainer.BorderColor3 = Color3.fromRGB(65, 110, 210)
SpeedDisplayContainer.Parent = SpeedFrame
Instance.new("UICorner", SpeedDisplayContainer).CornerRadius = UDim.new(0, 5)

local SpeedBarFill = Instance.new("Frame")
SpeedBarFill.Size = UDim2.new(0, 0, 1, 0)
SpeedBarFill.BackgroundColor3 = Color3.fromRGB(35, 75, 150)
SpeedBarFill.BackgroundTransparency = 0.4
SpeedBarFill.BorderSizePixel = 0
SpeedBarFill.Parent = SpeedDisplayContainer
Instance.new("UICorner", SpeedBarFill).CornerRadius = UDim.new(0, 5)

local SpeedDisplayText = Instance.new("TextLabel")
SpeedDisplayText.Size = UDim2.new(1, -10, 1, 0)
SpeedDisplayText.Position = UDim2.new(0, 8, 0, 0)
SpeedDisplayText.BackgroundTransparency = 1
SpeedDisplayText.Text = "16 spd"
SpeedDisplayText.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedDisplayText.TextXAlignment = Enum.TextXAlignment.Left
SpeedDisplayText.Font = Enum.Font.SourceSans
SpeedDisplayText.TextSize = 12
SpeedDisplayText.Parent = SpeedDisplayContainer

local SliderBtn = Instance.new("TextButton")
SliderBtn.Size = UDim2.new(1, 0, 1, 0)
SliderBtn.BackgroundTransparency = 1
SliderBtn.Text = ""
SliderBtn.Parent = SpeedDisplayContainer

local isDragging = false
local minSpeed, maxSpeed = 16, 150

local function UpdateSpeed(inputX)
    local relativeX = math.clamp(inputX - SpeedDisplayContainer.AbsolutePosition.X, 0, SpeedDisplayContainer.AbsoluteSize.X)
    local percentage = relativeX / SpeedDisplayContainer.AbsoluteSize.X
    local speedValue = math.floor(minSpeed + (maxSpeed - minSpeed) * percentage)
    SpeedBarFill.Size = UDim2.new(percentage, 0, 1, 0)
    SpeedDisplayText.Text = speedValue .. " spd"
    TargetSpeed = speedValue
end

SliderBtn.MouseButton1Down:Connect(function() isDragging = true end)
UserInputService.InputEnded:Connect(function(input) 
    if input.InputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then isDragging = false end 
end)
RunService.RenderStepped:Connect(function()
    if isDragging then UpdateSpeed(UserInputService:GetMouseLocation().X) end
end)

**ToggleSwitch.Activated:Connect(function()
    SpeedEnabled = not SpeedEnabled
    TweenService:Create(ToggleCircle, TweenInfo.new(0.15), {Position = SpeedEnabled and UDim2.new(1, -16, 0, 2) or UDim2.new(0, 2, 0, 2)}):Play()
    ToggleSwitch.BackgroundColor3 = SpeedEnabled and Color3.fromRGB(50, 150, 80) or Color3.fromRGB(80, 75, 85)
    if not SpeedEnabled then
        local char = Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then char.Humanoid.WalkSpeed = 16 end
    end
end)**

-- === NOVO DROPDOWN CORRIGIDO ===
local OpenDropdown = nil

local function CriarDropdownNovo(nome, opcoes, ordem, callback)
    local HeaderLabel = Instance.new("TextLabel")
    HeaderLabel.Size = UDim2.new(1, 0, 0, 18)
    HeaderLabel.BackgroundTransparency = 1
    HeaderLabel.Text = nome
    HeaderLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    HeaderLabel.Font = Enum.Font.SourceSansBold
    HeaderLabel.TextSize = 13
    HeaderLabel.TextXAlignment = Enum.TextXAlignment.Left
    HeaderLabel.LayoutOrder = ordem
    HeaderLabel.Parent = CombatScroll

    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, 0, 0, 36)
end
CriarBotao("Auto Train Farm Kill", 5, AutoFarmPage, LoopTrainFarm)
CriarBotao("Auto Comprar Pet", 5, PetsPage, LoopPets)
CriarBotao("Auto Upgrade Pet", 48, PetsPage, LoopUpgradePet)
CriarBotao("Auto Spin Roleta", 5, SpinPage, LoopSpin)
MinimizeButton.Activated:Connect(function()
Minimizado = not Minimizado
MinimizeButton.Text = Minimizado and "+" or "-"
MainFrame.Size = Minimizado and UDim2.new(0, 320, 0, 35) or UDim2.new(0, 320, 0, 420)
TabsContainer.Visible = not Minimizado
AutoFarmPage.Visible = (not Minimizado and AbaAtiva == "AutoFarm")
PetsPage.Visible = (not Minimizado and AbaAtiva == "Pets")
CombatPage.Visible = (not Minimizado and AbaAtiva == "Combat")
SpinPage.Visible = not Minimizado and AbaAtiva == "Spin"
end)
task.wait(0.5)
CombatScroll.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 20)
print("[Sucesso] Menu Tamayo v14.1 - Carregado perfeitamente!")

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

if PlayerGui:FindFirstChild("MenuTamayo") then PlayerGui.MenuTamayo:Destroy() end

local Minimizado, AbaAtiva = false, "AutoFarm"
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MenuTamayo"; ScreenGui.ResetOnSpawn = false; ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 270); 
MainFrame.Position = UDim2.new(0.5, -150, 0.3, -110)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 25, 35); MainFrame.BorderSizePixel = 0
MainFrame.Active = true; MainFrame.Draggable = true; MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -45, 0, 35); Title.Position = UDim2.new(0, 12, 0, 0); Title.BackgroundTransparency = 1
Title.Text = "🔮 Menu Tamayo v12.1"; Title.TextColor3 = Color3.fromRGB(255, 255, 255)
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
AutoFarmPage.Visible = true 

local function CriarAba(nome, pos, pag, idAba)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0, 65, 1, 0); Btn.Position = UDim2.new(0, pos, 0, 0)
    Btn.BackgroundColor3 = (idAba == "AutoFarm") and Color3.fromRGB(65, 55, 80) or Color3.fromRGB(40, 35, 45)
    Btn.Text = nome; Btn.TextColor3 = (idAba == "AutoFarm") and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
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
CriarAba("Pets", 70, PetsPage, "Pets")
CriarAba("Combat", 140, CombatPage, "Combat")
CriarAba("Spin", 210, SpinPage, "Spin")

-- === SISTEMA ANTI-RESET DE VELOCIDADE ===
local SpeedEnabled = true 
local TargetSpeed = 16 

RunService.Heartbeat:Connect(function()
    if SpeedEnabled then
        local char = Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            if char.Humanoid.WalkSpeed ~= TargetSpeed then
                char.Humanoid.WalkSpeed = TargetSpeed
            end
        end
    end
end)

local SpeedFrame = Instance.new("Frame")
SpeedFrame.Size = UDim2.new(1, 0, 0, 55); SpeedFrame.Position = UDim2.new(0, 0, 0, 0)
SpeedFrame.BackgroundColor3 = Color3.fromRGB(45, 38, 52); SpeedFrame.BorderSizePixel = 0; SpeedFrame.Parent = CombatPage
Instance.new("UICorner", SpeedFrame).CornerRadius = UDim.new(0, 6)

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 150, 0, 20); ToggleBtn.Position = UDim2.new(0, 10, 0, 8)
ToggleBtn.BackgroundTransparency = 1; ToggleBtn.Text = "Enable Custom WalkSpeed"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255); ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 12; ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left; ToggleBtn.Parent = SpeedFrame

local ToggleSwitch = Instance.new("TextButton")
ToggleSwitch.Size = UDim2.new(0, 40, 0, 20); ToggleSwitch.Position = UDim2.new(1, -50, 0, 8)
ToggleSwitch.BackgroundColor3 = Color3.fromRGB(50, 150, 80); ToggleSwitch.Text = "ON"
ToggleSwitch.TextColor3 = Color3.fromRGB(255, 255, 255); ToggleSwitch.Font = Enum.Font.SourceSansBold
ToggleSwitch.TextSize = 10; ToggleSwitch.Parent = SpeedFrame
Instance.new("UICorner", ToggleSwitch).CornerRadius = UDim.new(0, 10)

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, -20, 0, 15); SpeedLabel.Position = UDim2.new(0, 10, 0, 30)
SpeedLabel.BackgroundTransparency = 1; SpeedLabel.Text = "WalkSpeed Value: 16"
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255); SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Font = Enum.Font.SourceSans; SpeedLabel.TextSize = 11; SpeedLabel.Parent = SpeedFrame

local SpeedBarBg = Instance.new("Frame")
SpeedBarBg.Size = UDim2.new(0, 180, 0, 8); SpeedBarBg.Position = UDim2.new(0, 10, 0, 45)
SpeedBarBg.BackgroundColor3 = Color3.fromRGB(25, 20, 30); SpeedBarBg.BorderSizePixel = 0; SpeedBarBg.Parent = SpeedFrame
Instance.new("UICorner", SpeedBarBg).CornerRadius = UDim.new(0, 4)

local SpeedBarFill = Instance.new("Frame")
SpeedBarFill.Size = UDim2.new(0, 0, 1, 0); SpeedBarFill.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
SpeedBarFill.BorderSizePixel = 0; SpeedBarFill.Parent = SpeedBarBg
Instance.new("UICorner", SpeedBarFill).CornerRadius = UDim.new(0, 4)

local SliderBtn = Instance.new("TextButton")
SliderBtn.Size = UDim2.new(1, 0, 1, 20); SliderBtn.Position = UDim2.new(0, 0, -0.5, 0)
SliderBtn.BackgroundTransparency = 1; SliderBtn.Text = ""; SliderBtn.Parent = SpeedBarBg

local isDragging = false
local minSpeed, maxSpeed = 16, 100

local function UpdateSpeed(inputX)
    local relativeX = math.clamp(inputX - SpeedBarBg.AbsolutePosition.X, 0, SpeedBarBg.AbsoluteSize.X)
    local percentage = relativeX / SpeedBarBg.AbsoluteSize.X
    local speedValue = math.floor(minSpeed + (maxSpeed - minSpeed) * percentage)
    SpeedBarFill.Size = UDim2.new(percentage, 0, 1, 0)
    SpeedLabel.Text = "WalkSpeed Value: " .. speedValue .. " spd"
    TargetSpeed = speedValue
end

SliderBtn.MouseButton1Down:Connect(function() isDragging = true end)
UserInputService.InputEnded:Connect(function(input) 
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then 
        isDragging = false 
    end 
end)
RunService.RenderStepped:Connect(function()
    if isDragging then UpdateSpeed(UserInputService:GetMouseLocation().X) end
end)

ToggleSwitch.Activated:Connect(function()
    SpeedEnabled = not SpeedEnabled
    ToggleSwitch.Text = SpeedEnabled and "ON" or "OFF"
    ToggleSwitch.BackgroundColor3 = SpeedEnabled and Color3.fromRGB(50, 150, 80) or Color3.fromRGB(180, 50, 50)
    if not SpeedEnabled then
        local char = Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then char.Humanoid.WalkSpeed = 16 end
    end
end)

-- === SISTEMA DE LOOPS ===
local LoopsAtivos = {}

local function CriarBotao(nome, pos, pag, funcaoLoop)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 35); Btn.Position = UDim2.new(0, 0, 0, pos)
    Btn.BackgroundColor3 = Color3.fromRGB(180, 50, 50); Btn.Text = nome .. ": DESLIGADO"
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255); Btn.Font = Enum.Font.SourceSansBold; Btn.TextSize = 12; Btn.Parent = pag
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    
    local estado = false
    LoopsAtivos[nome] = false
    
    Btn.Activated:Connect(function()
        estado = not estado
        LoopsAtivos[nome] = estado
        Btn.Text = nome .. (estado and ": LIGADO" or ": DESLIGADO")
        Btn.BackgroundColor3 = estado and Color3.fromRGB(50, 150, 80) or Color3.fromRGB(180, 50, 50)
        
        if estado and funcaoLoop then
            task.spawn(function()
                while LoopsAtivos[nome] do
                    local sucesso, erro = pcall(funcaoLoop)
                    if not sucesso then warn("["..nome.."] Erro: "..tostring(erro)) end
                    task.wait(0.5) -- Mais devagar para não bugar a tela
                end
            end)
        end
    end)
end

-- === FUNÇÕES DO JOGO ===
local function LoopSpin()
    local RemoteEvents = ReplicatedStorage:FindFirstChild("RemoteEvents")
    if RemoteEvents and RemoteEvents:FindFirstChild("Roulette") then RemoteEvents.Roulette:FireServer(true) end
end

local function LoopUpgradePet()
    local RemoteFunc = ReplicatedStorage:FindFirstChild("RemoteFunction") 
    if RemoteFunc then RemoteFunc:InvokeServer({{PetId = 1, Version = 15910, Level = 0}}) end
end

local function LoopCombat()
    local RemoteEvents = ReplicatedStorage:FindFirstChild("RemoteEvents")
    if RemoteEvents then
        local GeneralAttack, SkillAttack = RemoteEvents:FindFirstChild("GeneralAttack"), RemoteEvents:FindFirstChild("SkillAttack")
        if GeneralAttack then 
            for i = 1, 4 do GeneralAttack:FireServer(i); task.wait(0.05) end
        end
        if SkillAttack then SkillAttack:FireServer(3); SkillAttack:FireServer(4) end
    end
end

local function LoopPets()
    local RemoteEvents = ReplicatedStorage:FindFirstChild("RemoteEvents")
    if RemoteEvents then
        local TouchPetShop, BuyPet = RemoteEvents:FindFirstChild("TouchPetShop"), RemoteEvents:FindFirstChild("BuyPet")
        if TouchPetShop then TouchPetShop:FireServer() end
        if BuyPet then BuyPet:FireServer("Pet", 1, 15910) end
    end
end

-- === A LÓGICA INTELIGENTE DO TREM ===
local function LoopTrainFarm()
    local char = Players.LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    -- 1. Verifica se tem algum inimigo vivo no mapa (Workspace)
    local temInimigoVivo = false
    for _, obj in pairs(workspace:GetChildren()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj.Humanoid.Health > 0 then
            -- Se não for o nosso próprio personagem, é um inimigo vivo.
            if obj ~= char then
                temInimigoVivo = true
                break
            end
        end
    end

    -- 2. Se o inimigo estiver morto (ou não tiver ninguém), avança!
    if not temInimigoVivo then
        char.HumanoidRootPart.CFrame = CFrame.new(-1009.036, -1952.459, -173.605)
        task.wait(0.3) -- Espera um tiquinho para o servidor registrar a posição

        local RemoteEvents = ReplicatedStorage:FindFirstChild("RemoteEvents")
        if RemoteEvents then
            local GoNextTrainLevel = RemoteEvents:FindFirstChild("GoNextTrainLevel")
            if GoNextTrainLevel then
                GoNextTrainLevel:FireServer(char.HumanoidRootPart.CFrame, char.HumanoidRootPart.CFrame)
                print("[Train Farm] Inimigo derrotado! Avançando de nível...")
            end
        end
    else
        -- Se o inimigo estiver vivo, só avisa no console e espera
        print("[Train Farm] Inimigo vivo. Lutando...")
    end
end


-- === PREENCHENDO OS BOTÕES ===
CriarBotao("Auto Train Farm Kill", 5, AutoFarmPage, LoopTrainFarm) 
CriarBotao("Auto Farm Kill (Visual)", 48, AutoFarmPage, nil)

CriarBotao("Fast Attack + Skills", 65, CombatPage, LoopCombat)
CriarBotao("Auto Skills", 108, CombatPage, LoopCombat)

CriarBotao("Auto Comprar Pet (Forçado)", 5, PetsPage, LoopPets)
CriarBotao("Auto Upgrade Pet", 48, PetsPage, LoopUpgradePet)

CriarBotao("Auto Spin Roleta", 5, SpinPage, LoopSpin)
CriarBotao("Ignorar Animação", 48, SpinPage, nil)

MinimizeButton.Activated:Connect(function()
    Minimizado = not Minimizado
    MinimizeButton.Text = Minimizado and "+" or "-"
    MainFrame.Size = Minimizado and UDim2.new(0, 300, 0, 35) or UDim2.new(0, 300, 0, 270)
    TabsContainer.Visible = not Minimizado
    AutoFarmPage.Visible = (not Minimizado and AbaAtiva == "AutoFarm")
    PetsPage.Visible = (not Minimizado and AbaAtiva == "Pets")
    CombatPage.Visible = (not Minimizado and AbaAtiva == "Combat")
    SpinPage.Visible = not Minimizado and AbaAtiva == "Spin"
end)

print("[Sucesso] Menu Tamayo v12.1 - Farm Inteligente Ativado!")

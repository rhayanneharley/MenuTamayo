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
MainFrame.Size = UDim2.new(0, 320, 0, 420); 
MainFrame.Position = UDim2.new(0.5, -160, 0.3, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 25, 35); MainFrame.BorderSizePixel = 0
MainFrame.Active = true; MainFrame.Draggable = true; MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -45, 0, 35); Title.Position = UDim2.new(0, 12, 0, 0); Title.BackgroundTransparency = 1
Title.Text = "🔮 Menu Tamayo v19.2"; Title.TextColor3 = Color3.fromRGB(255, 255, 255)
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
    
    local UIList = Instance.new("UIListLayout")
    UIList.SortOrder = Enum.SortOrder.LayoutOrder; UIList.Padding = UDim.new(0, 8); UIList.Parent = Page
    return Page
end

local AutoFarmPage, PetsPage, CombatPage, SpinPage = CriarPagina(), CriarPagina(), CriarPagina(), CriarPagina()
AutoFarmPage.Visible = true 

local function CriarAba(nome, pos, pag, idAba)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0, 70, 1, 0); Btn.Position = UDim2.new(0, pos, 0, 0)
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
CriarAba("Pets", 75, PetsPage, "Pets")
CriarAba("Combat", 150, CombatPage, "Combat")
CriarAba("Spin", 225, SpinPage, "Spin")

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

local SpeedFrame = Instance.new("Frame")
SpeedFrame.Size = UDim2.new(1, 0, 0, 55); SpeedFrame.LayoutOrder = 1
SpeedFrame.BackgroundColor3 = Color3.fromRGB(45, 38, 52); SpeedFrame.BorderSizePixel = 0; SpeedFrame.Parent = CombatPage
Instance.new("UICorner", SpeedFrame).CornerRadius = UDim.new(0, 6)

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
SpeedBarBg.Size = UDim2.new(0, 200, 0, 8); SpeedBarBg.Position = UDim2.new(0, 10, 0, 45)
SpeedBarBg.BackgroundColor3 = Color3.fromRGB(25, 20, 30); SpeedBarBg.BorderSizePixel = 0; SpeedBarBg.Parent = SpeedFrame
Instance.new("UICorner", SpeedBarBg).CornerRadius = UDim.new(0, 4)

local SpeedBarFill = Instance.new("Frame")
SpeedBarFill.Size = UDim2.new(0, 0, 1, 0); SpeedBarFill.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
SpeedBarFill.BorderSizePixel = 0; SpeedBarFill.Parent = SpeedBarBg
Instance.new("UICorner", SpeedBarFill).CornerRadius = UDim.new(0, 4)

local SliderBtn = Instance.new("TextButton")
SliderBtn.Size = UDim2.new(1, 0, 1, 40); SliderBtn.Position = UDim2.new(0, 0, -0.5, 0)
SliderBtn.BackgroundTransparency = 1; SliderBtn.Text = ""; SliderBtn.Parent = SpeedBarBg

local minSpeed, maxSpeed = 16, 150
local isDragging = false

local function UpdateSpeed(input)
    local mousePos = input.Position.X
    local relativeX = math.clamp(mousePos - SpeedBarBg.AbsolutePosition.X, 0, SpeedBarBg.AbsoluteSize.X)
    local percentage = relativeX / SpeedBarBg.AbsoluteSize.X
    local speedValue = math.floor(minSpeed + (maxSpeed - minSpeed) * percentage)
    SpeedBarFill.Size = UDim2.new(percentage, 0, 1, 0)
    SpeedLabel.Text = "WalkSpeed Value: " .. speedValue .. " spd"
    TargetSpeed = speedValue
end

SliderBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDragging = true; UpdateSpeed(input)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then UpdateSpeed(input) end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then isDragging = false end
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

-- === SISTEMA DE COMBATE ===
local CombateAtivo = false
local SkillSpamAtivo = false
local PadraoAtaque = "Combo (1-4)" 
local SkillEscolhida = "Todas as Skills"

local function CriarDropdown(nomeLabel, opcoes, layoutOrder, callback)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, 0, 0, 35); Container.LayoutOrder = layoutOrder
    Container.BackgroundColor3 = Color3.fromRGB(45, 38, 52); Container.BorderSizePixel = 0; Container.Parent = CombatPage
    Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 6)

    local BotaoPrincipal = Instance.new("TextButton")
    BotaoPrincipal.Size = UDim2.new(1, 0, 0, 35); BotaoPrincipal.Position = UDim2.new(0, 0, 0, 0)
    BotaoPrincipal.BackgroundColor3 = Color3.fromRGB(45, 38, 52); BotaoPrincipal.Text = "  " .. nomeLabel .. ":  " .. opcoes[1] .. "  v"
    BotaoPrincipal.TextColor3 = Color3.fromRGB(255, 255, 255); BotaoPrincipal.Font = Enum.Font.SourceSans; BotaoPrincipal.TextSize = 12
    BotaoPrincipal.TextXAlignment = Enum.TextXAlignment.Left; BotaoPrincipal.Parent = Container
    Instance.new("UICorner", BotaoPrincipal).CornerRadius = UDim.new(0, 6)

    local Lista = Instance.new("Frame")
    Lista.Size = UDim2.new(1, 0, 0, 0); Lista.Position = UDim2.new(0, 0, 0, 35)
    Lista.BackgroundColor3 = Color3.fromRGB(35, 30, 40); Lista.BorderSizePixel = 0; Lista.ClipsDescendants = true; Lista.Parent = Container
    
    local UIList = Instance.new("UIListLayout")
    UIList.SortOrder = Enum.SortOrder.LayoutOrder; UIList.Parent = Lista

    local aberto = false
    BotaoPrincipal.Activated:Connect(function()
        aberto = not aberto
        if aberto then
            Lista.Size = UDim2.new(1, 0, 0, #opcoes * 25)
            BotaoPrincipal.Text = "  " .. nomeLabel .. ":  " .. opcoes[1] .. "  ^"
        else
            Lista.Size = UDim2.new(1, 0, 0, 0)
            BotaoPrincipal.Text = "  " .. nomeLabel .. ":  " .. opcoes[1] .. "  v"
        end
        Container.Size = UDim2.new(1, 0, 0, 35 + Lista.Size.Y.Offset)
    end)

    for i, opcao in ipairs(opcoes) do
        local OpcaoBtn = Instance.new("TextButton")
        OpcaoBtn.Size = UDim2.new(1, 0, 0, 25); OpcaoBtn.LayoutOrder = i
        OpcaoBtn.BackgroundColor3 = Color3.fromRGB(35, 30, 40); OpcaoBtn.BorderSizePixel = 0
        OpcaoBtn.Text = opcao; OpcaoBtn.TextColor3 = Color3.fromRGB(255, 255, 255); OpcaoBtn.Font = Enum.Font.SourceSans; OpcaoBtn.TextSize = 11
        OpcaoBtn.Parent = Lista
        OpcaoBtn.Activated:Connect(function()
            aberto = false
            Lista.Size = UDim2.new(1, 0, 0, 0)
            Container.Size = UDim2.new(1, 0, 0, 35)
            BotaoPrincipal.Text = "  " .. nomeLabel .. ":  " .. opcao .. "  v"
            callback(opcao)
        end)
    end
end

local function CriarBotaoToggle(nome, layoutOrder, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 35); Btn.LayoutOrder = layoutOrder
    Btn.BackgroundColor3 = Color3.fromRGB(180, 50, 50); Btn.Text = nome .. ": DESLIGADO"
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255); Btn.Font = Enum.Font.SourceSansBold; Btn.TextSize = 12; Btn.Parent = CombatPage
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

    local estado = false
    Btn.Activated:Connect(function()
        estado = not estado
        Btn.Text = nome .. (estado and ": LIGADO" or ": DESLIGADO")
        Btn.BackgroundColor3 = estado and Color3.fromRGB(50, 150, 80) or Color3.fromRGB(180, 50, 50)
        callback(estado)
    end)
end

CriarBotaoToggle("Fast Attack", 2, function(estado) CombateAtivo = estado end)
CriarDropdown("Attack Pattern", {"Combo (1-4)", "Heavy Hit (4)", "Light Hit (1)"}, 3, function(escolha) PadraoAtaque = escolha end)
CriarDropdown("Select Skill", {"Todas as Skills", "Skill 1", "Skill 2", "Skill 3", "Skill 4"}, 4, function(escolha) SkillEscolhida = escolha end)
CriarBotaoToggle("Spam Selected Skill", 5, function(estado) SkillSpamAtivo = estado end)

-- === LÓGICA DE COMBATE ===
task.spawn(function()
    local RemoteEvents = ReplicatedStorage:FindFirstChild("RemoteEvents")
    if not RemoteEvents then return end
    local GeneralAttack = RemoteEvents:FindFirstChild("GeneralAttack")
    local SkillAttack = RemoteEvents:FindFirstChild("SkillAttack")

    while task.wait(0.1) do
        if CombateAtivo and GeneralAttack then
            if PadraoAtaque == "Combo (1-4)" then
                for i = 1, 4 do GeneralAttack:FireServer(i); task.wait(0.05) end
            elseif PadraoAtaque == "Heavy Hit (4)" then
                GeneralAttack:FireServer(4); task.wait(0.2)
            elseif PadraoAtaque == "Light Hit (1)" then
                GeneralAttack:FireServer(1); task.wait(0.2)
            end
        end

        if SkillSpamAtivo and SkillAttack then
            if SkillEscolhida == "Todas as Skills" then
                SkillAttack:FireServer(1); task.wait(0.1)
                SkillAttack:FireServer(2); task.wait(0.1)
                SkillAttack:FireServer(3); task.wait(0.1)
                SkillAttack:FireServer(4); task.wait(0.4)
            else
                local numSkill = tonumber(SkillEscolhida:match("%d+"))
                if numSkill then
                    SkillAttack:FireServer(numSkill)
                    task.wait(0.5)
                end
            end
        end
    end
end)

-- === OUTRAS ABAS ===
local LoopsAtivos = {}
local function CriarBotao(nome, layoutOrder, pag, funcaoLoop)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 35); Btn.LayoutOrder = layoutOrder
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
                    task.wait(1.5) -- Tempo de segurança entre verificações
                end
            end)
        end
    end)
end

local function LoopSpin()
    local RemoteEvents = ReplicatedStorage:FindFirstChild("RemoteEvents")
    if RemoteEvents and RemoteEvents:FindFirstChild("Roulette") then RemoteEvents.Roulette:FireServer(true) end
end
local function LoopUpgradePet()
    local RemoteFunc = ReplicatedStorage:FindFirstChild("RemoteFunction") 
    if RemoteFunc then RemoteFunc:InvokeServer({{PetId = 1, Version = 15910, Level = 0}}) end
end
local function LoopPets()
    local RemoteEvents = ReplicatedStorage:FindFirstChild("RemoteEvents")
    if RemoteEvents then
        local TouchPetShop, BuyPet = RemoteEvents:FindFirstChild("TouchPetShop"), RemoteEvents:FindFirstChild("BuyPet")
        if TouchPetShop then TouchPetShop:FireServer() end
        if BuyPet then BuyPet:FireServer("Pet", 1, 15910) end
    end
end

-- === A LÓGICA DEFINITIVA DO TREM ===
local function LoopTrainFarm()
    local char = Players.LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    -- 1. Verifica se tem algum inimigo VIVO na pasta Workspace
    local temInimigo = false
    for _, obj in pairs(workspace:GetDescendants()) do
        -- Verifica se é um Humanoid com vida e se NÃO é o jogador
        if obj:IsA("Humanoid") and obj.Health > 0 then
            local model = obj.Parent
            if model and not Players:GetPlayerFromCharacter(model) then
                -- Se o nome da Model tiver "NPC", "Demon", "Train", "Enemy" ou for parecido
                local nameLower = string.lower(model.Name)
                if string.find(nameLower, "npc") or string.find(nameLower, "demon") or string.find(nameLower, "train") or string.find(nameLower, "enemy") or string.find(nameLower, "mob") then
                    temInimigo = true
                    break
                end
            end
        end
    end

    -- 2. Se NÃO tem inimigo vivo, envia o comando
    if not temInimigo then
        local RemoteEvents = ReplicatedStorage:FindFirstChild("RemoteEvents")
        if RemoteEvents then
            local GoNextTrainLevel = RemoteEvents:FindFirstChild("GoNextTrainLevel")
            if GoNextTrainLevel then
                local PosAtual = CFrame.new(-1009.036, -1952.459, -173.605)
                local ProximoNivel = CFrame.new(-1008.998, -1955.500, -98.368)
                
                GoNextTrainLevel:FireServer(PosAtual, ProximoNivel)
                print("[Auto Train Farm] Nenhum inimigo! Avançando para o próximo vagão...")
                
                task.wait(2) -- Espera 2 segundos para o novo NPC nascer
            end
        end
    else
        print("[Auto Train Farm] Inimigo detectado. Lutando...")
    end
end

CriarBotao("Auto Train Farm", 1, AutoFarmPage, LoopTrainFarm) 
CriarBotao("Auto Comprar Pet", 1, PetsPage, LoopPets)
CriarBotao("Auto Upgrade Pet", 2, PetsPage, LoopUpgradePet)
CriarBotao("Auto Spin Roleta", 1, SpinPage, LoopSpin)

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

print("[Sucesso] Menu Tamayo v19.2 - Trem Inteligente!")

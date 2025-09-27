-- made with love <3
local itemsFolder = workspace:FindFirstChild("Items")
local bodiesfolder = workspace:FindFirstChild("Characters")
local Players = game:GetService("Players")
local heal = {"MedKit", "Bandage"}
local fuel = {"Fuel Canister", "Coal", "Log", "Bio Fuel", "Oil Barrel", "Cultist", "Crossbow Cultist", "Wolf Corpse", "Alpha Wolf Corpse", "Bear Corpse"}
local Scraps = {"Old Radio", "Sheet Metal", "Bolt", "UFO Junk", "UFO Component", "Broken Fan", "Broken Microwave", "Tyre", "Metal Chair", "Old Car Engine", "Washing Machine", "Cultist Experiment", "Cultist Prototype", "UFO Scrap"}
local Ammo = {"Revolver Ammo", "Rifle Ammo", "Shotgun Ammo"}
local Armor = {"Leather Body", "Iron Body", "Thorn Body", "Riot Shield", "Alien Armor"}
local weapons = {"Spear", "Morningstar", "Laser Sword", "Ice Sword", "Revolver", "Rifle", "Shotgun"}
local eatable = {"Carrot", "Berry", "Chilli", "Apple", "Cooked Morsel", "Cooked Steak"}
local tobring = {"Carrot", "Berry", "Chilli", "Apple", "Morsel", "Steak"}
local enemys = workspace:FindFirstChild("Characters") -- but check each item inside the folder without getting the players body yk what I mean
local feedingfire = false
local search_for_deadplayers = true
local centerpart = workspace.Map.Campground.MainFire.Center
local enemylist = {"Cultist", "Crossbow Cultist"}
local UILib = loadstring(game:HttpGet("https://raw.githubusercontent.com/HacksCreator102/UILIB/refs/heads/main/source.lua"))()
local function feed_fire()
    
    if feedingfire then
        warn("ALREADY FARMING")
        return
    end
    feedingfire = true

    for _, item in pairs(itemsFolder:GetChildren()) do
        if table.find(fuel, item.Name) then
            if item:IsA("Model") then
                if item.PrimaryPart then
                    item:SetPrimaryPartCFrame(centerpart.CFrame + Vector3.new(0, 5, 0))
                else
                    warn("No PrimaryPart found for " .. item.Name)
                end
            elseif item:IsA("BasePart") then
                item.CFrame = centerpart.CFrame + Vector3.new(0, 5, 0) -- Move item above the fire
            end
        end
    end

    feedingfire = false
end

-- this to the end
while search_for_deadplayer do
    task.wait(1) -- prevent freezing
    for _, player in ipairs(Players:GetPlayers()) do
        if bodiesfolder:FindFirstChild(player.Name .."  Body") and player.Character:FindFirstChild("Humanoid") then
            if player.Character.Humanoid.Health <= 0 then
                -- check If localplayer has bandage item
                local item = game.Players.LocalPlayer.BackPack:FindFirstChild("MedKit" or "Bandage")
                if item then
                    local bodyname = player.Name
                    local bodyworkspace = bodiesfolder:WaitForChild(bodyname.." Body")
                    game.Players.LocalPlayer.Character.CFrame = bodyworkspace.CFrame + CFrame.new(0,5,0) -- for safety
                    task.wait(1)
                    search_for_deadplayers = false
                end
    end
end
    end
end
  
if not search_for_deadplayers then
    for _, player in ipairs(Players:GetPlayers()) do
        if bodiesfolder:FindFirstChild(player.Name .."  Body") and player.Character:FindFirstChild("Humanoid") then
           print("still reviving")
            
        else
            task.wait(2.2)
            search_for_deadplayers = true
        end
end


--always when a request is should do this
local function killenemyswhileafk()
    if not enemys then
        warn("No enemies found in the workspace.")
        return
    end
    -- anti kick script clicks each 1 minute a key to prevent kick
    local player = game.Players.LocalPlayer
    local UserInputService = game:GetService("UserInputService")
    local function clickKey()
        UserInputService.InputBegan:Fire({KeyCode = Enum.KeyCode.E}, false)
    end
    while true do
        clickKey()
        
    end
   
    for _, enemy in pairs(enemys:GetChildren()) do
        if table.find(enemylist, enemy.Name) then
            local humanoid = enemy:FindFirstChild("Humanoid")
            if humanoid and humanoid.Health > 0 then
                local weapon
                for _, wName in ipairs(weapons) do
                    weapon = game.Players.LocalPlayer.Backpack:FindFirstChild(wName)
                    if weapon then break end
                end

                if weapon then
                    local enemyPosition = enemy.HumanoidRootPart.Position
                    local player = game.Players.LocalPlayer
                    local char = player.Character
                    char.HumanoidRootPart.CFrame = CFrame.new(enemyPosition + Vector3.new(0, 5, 0))
                    task.wait(1)

                    char.Humanoid:EquipTool(weapon)
                    task.wait(0.5)

                    char.Humanoid:MoveTo(enemyPosition)
                    task.wait(1)

                    -- Heal if low health
                    if char.Humanoid.Health <= 25 then
                        char.Humanoid.Health = char.Humanoid.MaxHealth
                    end
                end
            end
        end
    end
end

end
for _, i in pairs(enemys:GetChildren()) do
    if table.find(enemylist, i.Name) then
        local humanoid = i:FindFirstChild("Humanoid")
        if humanoid and i:FindFirstChild("HumanoidRootPart") then
            -- Find weapon
            local weapon
            for _, wName in ipairs(weapons) do
                weapon = game.Players.LocalPlayer.Backpack:FindFirstChild(wName)
                if weapon then break end
            end

            if weapon then
                local enemyPosition = i.HumanoidRootPart.Position
                local player = game.Players.LocalPlayer
                local char = player.Character
                local humanoid = char:FindFirstChild("Humanoid")
                -- Move above enemy for safety
                char.HumanoidRootPart.CFrame = CFrame.new(enemyPosition + Vector3.new(0, 5, 0))
                task.wait(1)

                -- Equip weapon
                char.Humanoid:EquipTool(weapon)
                task.wait(0.5)

                -- Move to enemy
                char.Humanoid:MoveTo(enemyPosition)
                task.wait(1)

                -- Heal if low health
                if char.Humanoid.Health <= 25 then
                   humanoid.Health = humanoid.MaxHealth
                   
                    end
                end
            end
        end
    end
end
-- ===== Load Executor Settings =====
local settings = loadSettings() -- Load previous saved settings

-- ===== Create UI Window =====
local Window = UILib:CreateWindow({Title = "My Script"})

-- Create Tabs
local HomeTab = Window:CreateTab("Home")
local AutoTab = Window:CreateTab("Auto")
local BringTab = Window:CreateTab("Bring")

-- ===== Home Tab Components =====
HomeTab:CreateToggle("Anti-AFK", "antiafk", settings.antiafk)
HomeTab:CreateKeybind("Set Keybind", "keybind")
HomeTab:CreateButton("Set Configurations File", function()
    -- You can open a file config UI here if needed
end)

-- ===== Auto Tab Components =====
AutoTab:CreateButton("Kill Enemies While AFK", function()
    killenemyswhileafk() -- Your function
end)

-- ===== Bring Tab Components =====
BringTab:CreateButton("Auto Fire", function()
    feed_fire() -- Your function
end)

BringTab:CreateToggle("Revive Dead Players", "revivedead", settings.revivedead)
BringTab:CreateButton("Bring Food", function()
    local TweenService = game:GetService("TweenService")
    local localPlayer = game.Players.LocalPlayer
    local hrp = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return warn("No HumanoidRootPart found") end

    local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    for _, item in pairs(itemsFolder:GetChildren()) do
        if table.find(tobring, item.Name) then
            if item:IsA("Model") and item.PrimaryPart then
                local upPos = item.PrimaryPart.CFrame + CFrame.new(0,100,0)
                local tweenUp = TweenService:Create(item.PrimaryPart, tweenInfo, {CFrame=upPos})
                tweenUp:Play()
                tweenUp.Completed:Wait()
                local finalPos = CFrame.new(hrp.Position)
                local tweenFinal = TweenService:Create(item.PrimaryPart, tweenInfo, {CFrame=finalPos})
                tweenFinal:Play()
                tweenFinal.Completed:Wait()
            elseif item:IsA("BasePart") then
                local upPos = item.CFrame + CFrame.new(0,100,0)
                local tweenUp = TweenService:Create(item, tweenInfo, {CFrame=upPos})
                tweenUp:Play()
                tweenUp.Completed:Wait()
                local finalPos = CFrame.new(hrp.Position)
                local tweenFinal = TweenService:Create(item, tweenInfo, {CFrame=finalPos})
                tweenFinal:Play()
                tweenFinal.Completed:Wait()
            end
        end
    end
end)




Window:Notify("Welcome!", "Script loaded successfully.", 3)
-- made with love <3

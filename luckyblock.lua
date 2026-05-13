-- تـحـمـيـل الـمـكـتـبـة
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- إنـشـاء الـنـافـذة الـرئـيـسـيـة
local Window = Rayfield:CreateWindow({
   Name = "The Architect Hub | Sailor Piece 🔥",
   LoadingTitle = "جـاري حـقـن مـلـفـات سـيـلـر بـيـس...",
   LoadingSubtitle = "بـواسـطـة The Architect",
   ConfigurationSaving = { Enabled = false },
   Discord = { Enabled = false, Invite = "no", RememberJoins = true },
   KeySystem = false
})

Rayfield:Notify({
   Title = "اكـتـمـل الـحـقـن",
   Content = "جـاهـز سـيـدي الـمـطـور، تـم تـجـهـيـز أقـوى سـكـريـبـت لـمـاب سـيـلـر بـيـس 🔥",
   Duration = 5,
   Image = 4483345998,
})

-- ==========================================
-- تـقـسـيـم الـأقـسـام لـسـهـولـة الـتـحـكـم
-- ==========================================
local FarmTab = Window:CreateTab("الـفـارم والـمـهـام", 4483345998)
local ItemsTab = Window:CreateTab("الـشـظـايـا والـصـنـاديـق", 4483345998)
local StatsTab = Window:CreateTab("الـتـطـويـر الـتـلـقـائـي", 4483345998)
local EspTab = Window:CreateTab("الـكـشـف (ESP)", 4483345998)
local PlayerTab = Window:CreateTab("إعـدادات الـلـاعـب", 4483345998)

-- مـتـغـيـرات الـتـشـغـيـل
_G.AutoQuest = false
_G.AutoFarm = false
_G.FastAttack = false
_G.AutoHaki = false
_G.AutoSkills = false
_G.AutoFragments = false
_G.AutoChests = false
_G.AutoMelee = false
_G.AutoDefense = false
_G.AutoSword = false

-- دالـة الـانـتـقـال الـسـلـس والـآمـن
local function TweenTo(targetCFrame)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local distance = (hrp.Position - targetCFrame.Position).Magnitude
        local speed = 200
        local tweenInfo = TweenInfo.new(distance / speed, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(hrp, tweenInfo, {CFrame = targetCFrame})
        tween:Play()
        return tween
    end
end

-- ==========================================
-- الـفـارم والـمـهـام
-- ==========================================
FarmTab:CreateToggle({
   Name = "أخـذ الـمـهـام تـلـقـائـيـاً 📜",
   CurrentValue = false,
   Flag = "AutoQuestToggle",
   Callback = function(Value)
      _G.AutoQuest = Value
   end,
})

FarmTab:CreateToggle({
   Name = "تـلـفـيـل تـلـقـائـي (Auto Farm) ⚔️",
   CurrentValue = false,
   Flag = "AutoFarmToggle",
   Callback = function(Value)
      _G.AutoFarm = Value
      task.spawn(function()
          while _G.AutoFarm do
              pcall(function()
                  local char = LocalPlayer.Character
                  local hrp = char and char:FindFirstChild("HumanoidRootPart")
                  if hrp then
                      -- جـلـب أقـرب وحـش فـي الـمـاب لـتـلـفـيـل الـحـسـاب
                      for _, enemy in pairs(workspace:GetDescendants()) do
                          if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 and enemy.Name ~= LocalPlayer.Name then
                              TweenTo(enemy.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3))
                              
                              -- مـحـاكـاة الـضـرب
                              VirtualUser:CaptureController()
                              VirtualUser:ClickButton1(Vector2.new(0,0))
                              break
                          end
                      end
                  end
              end)
              task.wait(0.5)
          end
      end)
   end,
})

FarmTab:CreateToggle({
   Name = "هـجـوم سـريـع (Fast Attack) ⚡",
   CurrentValue = false,
   Flag = "FastAttackToggle",
   Callback = function(Value)
      _G.FastAttack = Value
      task.spawn(function()
          while _G.FastAttack do
              pcall(function()
                  local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
                  if tool then
                      tool:Activate()
                  end
              end)
              task.wait(0.1)
          end
      end)
   end,
})

FarmTab:CreateToggle({
   Name = "تـفـعـيـل الـهـاكـي تـلـقـائـيـاً 🛡️",
   CurrentValue = false,
   Flag = "AutoHakiToggle",
   Callback = function(Value)
      _G.AutoHaki = Value
      task.spawn(function()
          while _G.AutoHaki do
              pcall(function()
                  -- يـفـعـل الـهـاكـي إذا لـم يـكـن مـفـعـلاً لا يـوجـد خـطـر
                  game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Haki"):FireServer()
              end)
              task.wait(10)
          end
      end)
   end,
})

FarmTab:CreateToggle({
   Name = "اسـتـخـدام الـمـهـارات تـلـقـائـيـاً 🪄",
   CurrentValue = false,
   Flag = "AutoSkillsToggle",
   Callback = function(Value)
      _G.AutoSkills = Value
      task.spawn(function()
          local vim = game:GetService("VirtualInputManager")
          while _G.AutoSkills do
              pcall(function()
                  vim:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
                  task.wait(0.2)
                  vim:SendKeyEvent(true, Enum.KeyCode.X, false, game)
                  task.wait(0.2)
                  vim:SendKeyEvent(true, Enum.KeyCode.C, false, game)
              end)
              task.wait(3)
          end
      end)
   end,
})

-- ==========================================
-- الـشـظـايـا والـصـنـاديـق (لـلـعـالـم الـثـانـي)
-- ==========================================
ItemsTab:CreateToggle({
   Name = "تـجـمـيـع الـشـظـايـا لـلـعـالـم الـثـانـي (Ancient Fragments) 💎",
   CurrentValue = false,
   Flag = "AutoFragmentsToggle",
   Callback = function(Value)
      _G.AutoFragments = Value
      task.spawn(function()
          while _G.AutoFragments do
              pcall(function()
                  for _, item in pairs(workspace:GetDescendants()) do
                      if item:IsA("Part") and item.Name:lower():find("fragment") then
                          TweenTo(item.CFrame)
                          task.wait(1.5)
                          if item:FindFirstChild("ProximityPrompt") then
                              fireproximityprompt(item.ProximityPrompt)
                          end
                      end
                  end
              end)
              task.wait(5)
          end
      end)
   end,
})

ItemsTab:CreateToggle({
   Name = "تـجـمـيـع الـصـنـاديـق تـلـقـائـيـاً 💰",
   CurrentValue = false,
   Flag = "AutoChestsToggle",
   Callback = function(Value)
      _G.AutoChests = Value
      task.spawn(function()
          while _G.AutoChests do
              pcall(function()
                  for _, chest in pairs(workspace:GetDescendants()) do
                      if chest:IsA("Part") and chest.Name:lower():find("chest") then
                          TweenTo(chest.CFrame)
                          task.wait(0.5)
                          firetouchinterest(LocalPlayer.Character.HumanoidRootPart, chest, 0)
                          firetouchinterest(LocalPlayer.Character.HumanoidRootPart, chest, 1)
                      end
                  end
              end)
              task.wait(3)
          end
      end)
   end,
})

-- ==========================================
-- الـتـطـويـر الـتـلـقـائـي (Stats)
-- ==========================================
StatsTab:CreateToggle({
   Name = "تـطـويـر قـوة الـضـرب (Melee) 👊",
   CurrentValue = false,
   Flag = "AutoMeleeToggle",
   Callback = function(Value)
      _G.AutoMelee = Value
      task.spawn(function()
          while _G.AutoMelee do
              pcall(function() game.ReplicatedStorage.Events.AddStat:FireServer("Melee", 1) end)
              task.wait(0.5)
          end
      end)
   end,
})

StatsTab:CreateToggle({
   Name = "تـطـويـر الـدفـاع (Defense) 🛡️",
   CurrentValue = false,
   Flag = "AutoDefenseToggle",
   Callback = function(Value)
      _G.AutoDefense = Value
      task.spawn(function()
          while _G.AutoDefense do
              pcall(function() game.ReplicatedStorage.Events.AddStat:FireServer("Defense", 1) end)
              task.wait(0.5)
          end
      end)
   end,
})

StatsTab:CreateToggle({
   Name = "تـطـويـر الـسـيـف (Sword) ⚔️",
   CurrentValue = false,
   Flag = "AutoSwordToggle",
   Callback = function(Value)
      _G.AutoSword = Value
      task.spawn(function()
          while _G.AutoSword do
              pcall(function() game.ReplicatedStorage.Events.AddStat:FireServer("Sword", 1) end)
              task.wait(0.5)
          end
      end)
   end,
})

-- ==========================================
-- الـكـشـف (ESP)
-- ==========================================
EspTab:CreateToggle({
   Name = "كـشـف الـلـاعـبـيـن (ESP Players) 👤",
   CurrentValue = false,
   Flag = "EspToggle",
   Callback = function(Value)
       for _, p in pairs(Players:GetPlayers()) do
           if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
               if Value then
                   local bg = Instance.new("BillboardGui", p.Character.Head)
                   bg.Name = "ESP"
                   bg.AlwaysOnTop = true
                   bg.Size = UDim2.new(0, 100, 0, 50)
                   local text = Instance.new("TextLabel", bg)
                   text.Size = UDim2.new(1, 0, 1, 0)
                   text.Text = p.Name
                   text.TextColor3 = Color3.new(1, 0, 0)
                   text.BackgroundTransparency = 1
               else
                   if p.Character.Head:FindFirstChild("ESP") then
                       p.Character.Head.ESP:Destroy()
                   end
               end
           end
       end
   end,
})

-- ==========================================
-- إعـدادات الـلـاعـب
-- ==========================================
PlayerTab:CreateSlider({
   Name = "سـرعـة الـمـشـي ⚡",
   Range = {16, 300},
   Increment = 1,
   CurrentValue = 16,
   Flag = "WalkSpeedSlider",
   Callback = function(Value)
      pcall(function() LocalPlayer.Character.Humanoid.WalkSpeed = Value end)
   end,
})

PlayerTab:CreateSlider({
   Name = "قـوة الـقـفـز 🦘",
   Range = {50, 400},
   Increment = 1,
   CurrentValue = 50,
   Flag = "JumpPowerSlider",
   Callback = function(Value)
      pcall(function() LocalPlayer.Character.Humanoid.JumpPower = Value end)
   end,
})

Rayfield:LoadConfiguration()

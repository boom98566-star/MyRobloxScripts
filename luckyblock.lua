-- تـحـمـيـل مـكـتـبـات الـنـظـام
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local VirtualInputManager = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- إنـشـاء الـنـافـذة الـرئـيـسـيـة
local Window = Rayfield:CreateWindow({
   Name = "The Architect Hub | Kick a Lucky Block 🔥",
   LoadingTitle = "جـاري حـقـن الـسـكـريـبـت...",
   LoadingSubtitle = "تـم الـتـطـويـر بـواسـطـة The Architect",
   ConfigurationSaving = { Enabled = false },
   Discord = { Enabled = false, Invite = "no", RememberJoins = true },
   KeySystem = false
})

local MainTab = Window:CreateTab("الـتـلـقـائـيـات", 4483345998)
local SettingsTab = Window:CreateTab("إعـدادات الـتـوقـيـت والـسـرعـة", 4483345998)

_G.AutoTrain = false
_G.TrainDelay = 1.5

_G.AutoKick = false
_G.MeterDelay = 0.5 -- وقـت حـركـة الـمـؤشـر لـلـوصـول لـلـقـسـم الـمـمـتـاز
_G.PetWait = 4.0
_G.TweenSpeed = 60 -- سـرعـة الـانـتـقـال الـسـلـس لـحـمـايـة الـحـيـوان

-- ==========================================
-- إعـدادات الـتـوقـيـت والـسـرعـة
-- ==========================================
SettingsTab:CreateSlider({
   Name = "سـرعـة الـانـتـقـال (لـحـمـايـة الـحـيـوان) 🏃",
   Range = {20, 150},
   Increment = 5,
   CurrentValue = 60,
   Flag = "TweenSpeedSlider",
   Callback = function(Value)
      _G.TweenSpeed = Value
   end,
})

SettingsTab:CreateSlider({
   Name = "تـوقـيـت إيـقـاف الـمـؤشـر (لـركـلـة مـمـتـازة) 🎯",
   Range = {0.1, 2.0},
   Increment = 0.1,
   CurrentValue = 0.5,
   Flag = "MeterDelaySlider",
   Callback = function(Value)
      _G.MeterDelay = Value
   end,
})

SettingsTab:CreateSlider({
   Name = "وقـت انـتـظـار جـمـع الـحـيـوان 🐾",
   Range = {1.0, 10.0},
   Increment = 0.5,
   CurrentValue = 4.0,
   Flag = "PetWaitSlider",
   Callback = function(Value)
      _G.PetWait = Value
   end,
})

-- ==========================================
-- قـسـم الـتـلـقـائـيـات
-- ==========================================
MainTab:CreateToggle({
   Name = "تـدريـب تـلـقـائـي 💪",
   CurrentValue = false,
   Flag = "AutoTrainToggle",
   Callback = function(Value)
      _G.AutoTrain = Value
      task.spawn(function()
          while _G.AutoTrain do
              pcall(function()
                  local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                  local tool = char:FindFirstChildOfClass("Tool") or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
                  
                  if tool then
                      char.Humanoid:EquipTool(tool)
                      VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                      task.wait(0.05)
                      VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                  end
              end)
              task.wait(_G.TrainDelay)
          end
      end)
   end,
})

MainTab:CreateToggle({
   Name = "تـجـمـيـع وركـل (انـتـقـال سـلـس + مـؤشـر مـمـتـاز) ⚽",
   CurrentValue = false,
   Flag = "AutoKickToggle",
   Callback = function(Value)
      _G.AutoKick = Value
      task.spawn(function()
          while _G.AutoKick do
              local foundBlock = false
              pcall(function()
                  local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                  local hrp = char:FindFirstChild("HumanoidRootPart")
                  
                  if hrp then
                      for _, v in pairs(workspace:GetDescendants()) do
                          if v:IsA("Part") and (v.Name:lower():find("block") or v.Name:lower():find("lucky") or v.Name:lower():find("kick")) then
                              foundBlock = true
                              
                              -- 1. الـانـتـقـال الـسـلـس (لـا يـوجـد انـتـقـال مـفـاجـئ لـحـمـايـة الـحـيـوان)
                              local distance = (hrp.Position - v.Position).Magnitude
                              local timeToTravel = distance / _G.TweenSpeed
                              local tweenInfo = TweenInfo.new(timeToTravel, Enum.EasingStyle.Linear)
                              local targetCFrame = v.CFrame * CFrame.new(0, 0, 4)
                              local tween = TweenService:Create(hrp, tweenInfo, {CFrame = targetCFrame})
                              
                              tween:Play()
                              tween.Completed:Wait() -- انـتـظـار حـتـى يـصـل الـلـاعـب بـسـلـام
                              task.wait(0.5) -- اسـتـقـرار لـلـحـيـوان
                              
                              -- 2. عـمـلـيـة الـمـؤشـر (ضـغـطـة لـلـبـدء ثـم ضـغـطـة لـلـإيـقـاف)
                              -- الـضـغـطـة الـأولـى
                              VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                              task.wait(0.05)
                              VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                              
                              -- انـتـظـار حـتـى يـصـل الـمـؤشـر لـلـمـنـطـقـة الـمـمـتـازة
                              task.wait(_G.MeterDelay)
                              
                              -- الـضـغـطـة الـثـانـيـة لـإيـقـاف الـمـؤشـر
                              VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                              task.wait(0.05)
                              VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                              
                              -- 3. انـتـظـار الـحـيـوان لـيـجـمـع بـدون خـطـأ
                              task.wait(_G.PetWait) 
                              break 
                          end
                      end
                  end
              end)
              
              if not foundBlock then
                  task.wait(1)
              end
          end
      end)
   end,
})

Rayfield:Notify({
   Title = "اكتمل الـحـقـن",
   Content = "تـم تـفـعـيـل الـانـتـقـال الـسـلـس ونـظـام الـمـؤشـر لـحـل كـل الـمـشـاكـل 🔥",
   Duration = 5,
   Image = 4483345998,
})

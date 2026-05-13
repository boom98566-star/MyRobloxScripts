-- تـحـمـيـل مـكـتـبـة Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local VirtualInputManager = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- إنـشـاء الـنـافـذة الـرئـيـسـيـة
local Window = Rayfield:CreateWindow({
   Name = "The Architect Hub | Kick a Lucky Block 🔥",
   LoadingTitle = "جـاري حـقـن الـسـكـريـبـت...",
   LoadingSubtitle = "تـم الـتـطـويـر بـواسـطـة The Architect",
   ConfigurationSaving = {
      Enabled = false 
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = false
})

local MainTab = Window:CreateTab("الـتـلـقـائـيـات", 4483345998)
local SettingsTab = Window:CreateTab("إعـدادات الـتـوقـيـت (هـام)", 4483345998)

_G.AutoTrain = false
_G.TrainDelay = 1.5

_G.AutoKick = false
_G.KickCharge = 1.2
_G.PetWait = 4.0

-- ==========================================
-- إعـدادات الـتـوقـيـت (لـحـل مـشـاكـل الـسـرعـة)
-- ==========================================
SettingsTab:CreateSlider({
   Name = "وقـت انـتـظـار نـزلـة الـتـدريـب (بـالـثـانـيـة) ⏱️",
   Range = {0.5, 4.0},
   Increment = 0.1,
   CurrentValue = 1.5,
   Flag = "TrainDelaySlider",
   Callback = function(Value)
      _G.TrainDelay = Value
   end,
})

SettingsTab:CreateSlider({
   Name = "مـدة شـحـن الـركـلـة (لـتـصـبـح مـمـتـازة) ⚡",
   Range = {0.1, 3.0},
   Increment = 0.1,
   CurrentValue = 1.2,
   Flag = "KickChargeSlider",
   Callback = function(Value)
      _G.KickCharge = Value
   end,
})

SettingsTab:CreateSlider({
   Name = "وقـت انـتـظـار عـودة الـحـيـوان (الـبـت) 🐾",
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
   Name = "تـدريـب تـلـقـائـي (نـزلـة كـامـلـة) 💪",
   CurrentValue = false,
   Flag = "AutoTrainToggle",
   Callback = function(Value)
      _G.AutoTrain = Value
      task.spawn(function()
          while _G.AutoTrain do
              local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
              local tool = char:FindFirstChildOfClass("Tool") or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
              
              if tool then
                  char.Humanoid:EquipTool(tool)
                  -- مـحـاكـاة ضـغـطـة سـريـعـة لـلـبـدء
                  VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                  task.wait(0.05)
                  VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                  
                  -- الـانـتـظـار حـتـى تـكـتـمـل حـركـة الـتـدريـب بـنـاءً عـلـى الـإعـدادات
                  task.wait(_G.TrainDelay)
              else
                  task.wait(1)
              end
          end
      end)
   end,
})

MainTab:CreateToggle({
   Name = "تـجـمـيـع وركـل (قـوي + انـتـظـار) ⚽",
   CurrentValue = false,
   Flag = "AutoKickToggle",
   Callback = function(Value)
      _G.AutoKick = Value
      task.spawn(function()
          while _G.AutoKick do
              local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
              local hrp = char:FindFirstChild("HumanoidRootPart")
              
              if hrp then
                  local foundBlock = false
                  for _, v in pairs(workspace:GetDescendants()) do
                      if v:IsA("Part") and (v.Name:lower():find("block") or v.Name:lower():find("lucky") or v.Name:lower():find("kick")) then
                          foundBlock = true
                          
                          -- الـوقـوف أمـام الـصـنـدوق
                          hrp.CFrame = v.CFrame * CFrame.new(0, 0, 4)
                          task.wait(0.5) 
                          
                          -- شـحـن الـركـلـة بـنـاءً عـلـى الـمـدة فـي الـإعـدادات
                          VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                          task.wait(_G.KickCharge) 
                          VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                          
                          -- انـتـظـار الـحـيـوان لـيـجـمـع الـمـكـافـآت
                          task.wait(_G.PetWait) 
                          break 
                      end
                  end
                  if not foundBlock then
                      task.wait(1)
                  end
              else
                  task.wait(1)
              end
          end
      end)
   end,
})

Rayfield:Notify({
   Title = "اكتمل الـحـقـن",
   Content = "تـم إضـافـة إعـدادات الـتـوقـيـت لـلـتـحـكـم الـكـامـل 🔥",
   Duration = 5,
   Image = 4483345998,
})

Rayfield:LoadConfiguration()

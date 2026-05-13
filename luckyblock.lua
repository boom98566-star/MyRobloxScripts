local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local VirtualUser = game:GetService("VirtualUser")
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
-- إعـدادات الـتـوقـيـت
-- ==========================================
SettingsTab:CreateSlider({
   Name = "وقـت انـتـظـار نـزلـة الـتـدريـب ⏱️",
   Range = {0.5, 4.0},
   Increment = 0.1,
   CurrentValue = 1.5,
   Flag = "TrainDelaySlider",
   Callback = function(Value)
      _G.TrainDelay = Value
   end,
})

SettingsTab:CreateSlider({
   Name = "مـدة شـحـن الـركـلـة ⚡",
   Range = {0.1, 3.0},
   Increment = 0.1,
   CurrentValue = 1.2,
   Flag = "KickChargeSlider",
   Callback = function(Value)
      _G.KickCharge = Value
   end,
})

SettingsTab:CreateSlider({
   Name = "وقـت انـتـظـار الـحـيـوان 🐾",
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
              pcall(function()
                  local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                  local tool = char:FindFirstChildOfClass("Tool") or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
                  
                  if tool then
                      char.Humanoid:EquipTool(tool)
                      VirtualUser:CaptureController()
                      VirtualUser:ClickButton1(Vector2.new(0,0))
                  end
              end)
              -- الانـتـظـار بـنـاءً عـلـى إعـداداتـك
              task.wait(_G.TrainDelay)
          end
      end)
   end,
})

MainTab:CreateToggle({
   Name = "تـجـمـيـع وركـل (شـحـن + انـتـظـار) ⚽",
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
                              
                              -- الانـتـقـال والاسـتـقـرار أمـام الـصـنـدوق
                              hrp.CFrame = v.CFrame * CFrame.new(0, 0, 4)
                              task.wait(0.5) 
                              
                              -- عـمـلـيـة الـشـحـن (ضـغـط مـسـتـمـر ثـم إفـلات)
                              VirtualUser:CaptureController()
                              VirtualUser:Button1Down(Vector2.new(0,0))
                              task.wait(_G.KickCharge) 
                              VirtualUser:Button1Up(Vector2.new(0,0))
                              
                              -- انـتـظـار الـحـيـوان
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

-- تـنـبـيـه نـهـائـي
Rayfield:Notify({
   Title = "اكتمل الـحـقـن",
   Content = "تـم تـحـسـيـن مـحـرك الـلـمـس لـيـعـمـل مـع الـمـوبـايـل بـكـفـاءة 🔥",
   Duration = 5,
   Image = 4483345998,
})

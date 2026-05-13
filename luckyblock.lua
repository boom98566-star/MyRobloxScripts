-- تـحـمـيـل مـكـتـبـة Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local VirtualInputManager = game:GetService("VirtualInputManager")

-- إنـشـاء الـنـافـذة الـرئـيـسـيـة
local Window = Rayfield:CreateWindow({
   Name = "The Architect Hub | Kick a Lucky Block 🔥",
   LoadingTitle = "جـاري حـقـن الـسـكـريـبـت...",
   LoadingSubtitle = "تـم الـتـطـويـر بـواسـطـة The Architect",
   ConfigurationSaving = {
      Enabled = false -- تـم إيـقـافـهـا لـتـجـنـب تـعـلـيـق الـواجـهـة فـي الـمـوبـايـل
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = false
})

local MainTab = Window:CreateTab("الـتـلـقـائـيـات", 4483345998)
local PlayerTab = Window:CreateTab("إعـدادات الـلـاعـب", 4483345998)

_G.AutoTrain = false
_G.AutoKick = false

-- مـيـزة الـتـدريـب بـمـحـاكـاة حـقـيـقـيـة 100%
MainTab:CreateToggle({
   Name = "تـدريـب تـلـقـائـي قـوي 💪",
   CurrentValue = false,
   Flag = "AutoTrainToggle",
   Callback = function(Value)
      _G.AutoTrain = Value
      task.spawn(function()
          while _G.AutoTrain do
              task.wait(0.1)
              local player = game.Players.LocalPlayer
              local char = player.Character or player.CharacterAdded:Wait()
              local tool = char:FindFirstChildOfClass("Tool") or player.Backpack:FindFirstChildOfClass("Tool")
              
              if tool then
                  char.Humanoid:EquipTool(tool)
                  tool:Activate()
                  
                  -- مـحـاكـاة ضـغـطـة إصـبـع حـقـيـقـيـة عـلـى الـشـاشـة
                  VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                  task.wait(0.05)
                  VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                  
                  -- إجـبـار الـسـيـرفـر عـلـى احـتـسـاب الـقـوة عـبـر الـأحـداث
                  for _, v in pairs(game.ReplicatedStorage:GetDescendants()) do
                      if v:IsA("RemoteEvent") and (v.Name:lower():find("click") or v.Name:lower():find("train") or v.Name:lower():find("add") or v.Name:lower():find("swing")) then
                          pcall(function() v:FireServer() end)
                      end
                  end
              end
          end
      end)
   end,
})

-- مـيـزة الـتـجـمـيـع والـركـل
MainTab:CreateToggle({
   Name = "تـجـمـيـع وركـل تـلـقـائـي ⚽",
   CurrentValue = false,
   Flag = "AutoKickToggle",
   Callback = function(Value)
      _G.AutoKick = Value
      task.spawn(function()
          while _G.AutoKick do
              task.wait(0.3)
              local player = game.Players.LocalPlayer
              local char = player.Character or player.CharacterAdded:Wait()
              local hrp = char:FindFirstChild("HumanoidRootPart")
              
              if hrp then
                  for _, v in pairs(workspace:GetDescendants()) do
                      if v:IsA("Part") and (v.Name:lower():find("block") or v.Name:lower():find("lucky") or v.Name:lower():find("kick")) then
                          -- الـانـتـقـال أمـام الـصـنـدوق
                          hrp.CFrame = v.CFrame * CFrame.new(0, 0, 3)
                          task.wait(0.1)
                          
                          -- الـلـمـس الـوهـمـي
                          pcall(function()
                              firetouchinterest(hrp, v, 0)
                              firetouchinterest(hrp, v, 1)
                          end)
                          
                          -- الـضـرب لـكـسـر الـصـنـدوق
                          VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                          task.wait(0.05)
                          VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                          break 
                      end
                  end
              end
          end
      end)
   end,
})

PlayerTab:CreateSlider({
   Name = "سـرعـة الـمـشـي ⚡",
   Range = {16, 250},
   Increment = 1,
   CurrentValue = 16,
   Flag = "SpeedSlider",
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

PlayerTab:CreateSlider({
   Name = "قـوة الـقـفـز 🦘",
   Range = {50, 300},
   Increment = 1,
   CurrentValue = 50,
   Flag = "JumpSlider",
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
   end,
})

-- تـنـبـيـه نـهـائـي وتـجـهـيـز الـواجـهـة
Rayfield:Notify({
   Title = "اكتمل الـحـقـن",
   Content = "جـاهـز سـيـدي الـمـطـور، تـم تـجـهـيـز الـأدوات مـع حـل الـمـشـاكـل 🔥",
   Duration = 5,
   Image = 4483345998,
})

Rayfield:LoadConfiguration()

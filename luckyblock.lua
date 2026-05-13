-- تـحـمـيـل مـكـتـبـة Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local VirtualInputManager = game:GetService("VirtualInputManager")

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
local PlayerTab = Window:CreateTab("إعـدادات الـلـاعـب", 4483345998)

_G.AutoTrain = false
_G.AutoKick = false

-- مـيـزة الـتـدريـب الـمـعـدلـة (نـزلـة كـامـلـة لـضـمـان الاحـتـسـاب)
MainTab:CreateToggle({
   Name = "تـدريـب تـلـقـائـي (نـزلـة كـامـلـة) 💪",
   CurrentValue = false,
   Flag = "AutoTrainToggle",
   Callback = function(Value)
      _G.AutoTrain = Value
      task.spawn(function()
          while _G.AutoTrain do
              local player = game.Players.LocalPlayer
              local char = player.Character or player.CharacterAdded:Wait()
              local tool = char:FindFirstChildOfClass("Tool") or player.Backpack:FindFirstChildOfClass("Tool")
              
              if tool then
                  char.Humanoid:EquipTool(tool)
                  tool:Activate()
                  
                  VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                  task.wait(0.1)
                  VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                  
                  -- انـتـظـار ثـانـيـة ونـصـف لـيـكـمـل الـلـاعـب نـزلـة الـتـدريـب الـكـامـلـة
                  task.wait(1.5)
              else
                  task.wait(0.5)
              end
          end
      end)
   end,
})

-- مـيـزة الـتـجـمـيـع الـمـعـدلـة (شـحـن الـركـلـة وانـتـظـار الـحـيـوان)
MainTab:CreateToggle({
   Name = "تـجـمـيـع وركـل (قـوي + انـتـظـار) ⚽",
   CurrentValue = false,
   Flag = "AutoKickToggle",
   Callback = function(Value)
      _G.AutoKick = Value
      task.spawn(function()
          while _G.AutoKick do
              local player = game.Players.LocalPlayer
              local char = player.Character or player.CharacterAdded:Wait()
              local hrp = char:FindFirstChild("HumanoidRootPart")
              
              if hrp then
                  local foundBlock = false
                  for _, v in pairs(workspace:GetDescendants()) do
                      if v:IsA("Part") and (v.Name:lower():find("block") or v.Name:lower():find("lucky") or v.Name:lower():find("kick")) then
                          foundBlock = true
                          
                          -- الانـتـقـال أمـام الـصـنـدوق بـمـسـافـة مـنـاسـبـة
                          hrp.CFrame = v.CFrame * CFrame.new(0, 0, 4)
                          task.wait(0.5) -- انـتـظـار لـلاسـتـقـرار
                          
                          -- شـحـن الـركـلـة (الـاسـتـمـرار بـالـضـغـط لـمـدة 1.2 ثـانـيـة לـتـصـبـح قـويـة أو مـمـتـازة)
                          VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                          task.wait(1.2) 
                          VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                          
                          -- انـتـظـار 3 ثـوانٍ حـتـى يـذهـب الـحـيـوان ويـجـمـع الـمـكـافـآت ويـعـود
                          task.wait(3) 
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

-- تـنـبـيـه اكـتـمـال الـحـقـن
Rayfield:Notify({
   Title = "اكتمل الـحـقـن",
   Content = "تـم تـعـديـل نـظـام الـتـدريـب وشـحـن الـركـلـة مـع انـتـظـار الـحـيـوان 🔥",
   Duration = 5,
   Image = 4483345998,
})

Rayfield:LoadConfiguration()
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

-- تـحـمـيـل مـكـتـبـة Rayfield الأقـوى لـلـمـوبـايـل
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local VirtualUser = game:GetService("VirtualUser")

-- إنـشـاء الـنـافـذة الـرئـيـسـيـة
local Window = Rayfield:CreateWindow({
   Name = "The Architect Hub | Kick a Lucky Block 🔥",
   LoadingTitle = "جـاري حـقـن الـسـكـريـبـت...",
   LoadingSubtitle = "تـم الـتـطـويـر بـواسـطـة The Architect",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "ArchitectScripts",
      FileName = "KickLuckyBlock"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = false
})

-- تـقـسـيـم الـأقـسـام
local MainTab = Window:CreateTab("الـتـلـقـائـيـات", 4483345998)
local PlayerTab = Window:CreateTab("إعـدادات الـلـاعـب", 4483345998)

-- مـتـغـيـرات الـتـشـغـيـل
_G.AutoTrain = false
_G.AutoKick = false

-- مـيـزة الـتـدريـب الـتـلـقـائـي (مـع مـحـاكـاة نـقـر حـقـيـقـيـة)
MainTab:CreateToggle({
   Name = "تـدريـب تـلـقـائـي وحـقـيـقـي 💪",
   CurrentValue = false,
   Flag = "AutoTrainToggle",
   Callback = function(Value)
      _G.AutoTrain = Value
      task.spawn(function()
          while _G.AutoTrain do
              task.wait(0.2) -- تـأخـيـر بـسـيـط لـكـي يـسـجـل الـخـادم الـنـقـاط
              local player = game.Players.LocalPlayer
              local char = player.Character or player.CharacterAdded:Wait()
              
              local tool = char:FindFirstChildOfClass("Tool") or player.Backpack:FindFirstChildOfClass("Tool")
              if tool then
                  char.Humanoid:EquipTool(tool)
                  tool:Activate()
                  -- مـحـاكـاة نـقـرة شـاشـة لـضـمـان حـسـاب الـقـوة
                  VirtualUser:CaptureController()
                  VirtualUser:ClickButton1(Vector2.new(0,0))
              end
          end
      end)
   end,
})

-- مـيـزة الـتـجـمـيـع والـركـل الـتـلـقـائـي (انـتـقـال ونـقـر)
MainTab:CreateToggle({
   Name = "تـجـمـيـع وركـل تـلـقـائـي ⚽",
   CurrentValue = false,
   Flag = "AutoKickToggle",
   Callback = function(Value)
      _G.AutoKick = Value
      task.spawn(function()
          while _G.AutoKick do
              task.wait(0.5)
              local player = game.Players.LocalPlayer
              local char = player.Character or player.CharacterAdded:Wait()
              local hrp = char:FindFirstChild("HumanoidRootPart")
              
              if hrp then
                  -- الـبـحـث عـن الـصـنـاديـق فـي الـمـاب
                  for _, v in pairs(workspace:GetDescendants()) do
                      if v:IsA("Part") and (v.Name:lower():find("block") or v.Name:lower():find("lucky")) then
                          -- الانـتـقـال أمـام الـصـنـدوق مـبـاشـرة
                          hrp.CFrame = v.CFrame * CFrame.new(0, 0, 3)
                          
                          -- مـحـاكـاة الـضـرب أو الـركـل
                          VirtualUser:CaptureController()
                          VirtualUser:ClickButton1(Vector2.new(0,0))
                          task.wait(0.2) -- انـتـظـار بـسـيـط بـيـن كـل ركـلـة لـتـجـنـب الـخـطـأ
                          break 
                      end
                  end
              end
          end
      end)
   end,
})

-- مـيـزة الـسـرعـة الـخـارقـة
PlayerTab:CreateSlider({
   Name = "سـرعـة الـمـشـي (WalkSpeed) ⚡",
   Range = {16, 250},
   Increment = 1,
   CurrentValue = 16,
   Flag = "SpeedSlider",
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

-- مـيـزة قـوة الـقـفـز
PlayerTab:CreateSlider({
   Name = "قـوة الـقـفـز (JumpPower) 🦘",
   Range = {50, 300},
   Increment = 1,
   CurrentValue = 50,
   Flag = "JumpSlider",
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
   end,
})

-- تـنـبـيـه بـأن الـكـود مـسـتـعـد
Rayfield:Notify({
   Title = "اكتمل الـحـقـن",
   Content = "جـاهـز سـيـدي الـمـطـور، تـم تـجـهـيـز الـأدوات مـع حـل الـمـشـاكـل 🔥",
   Duration = 5,
   Image = 4483345998,
})

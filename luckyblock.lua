-- تـحـمـيـل مـكـتـبـة Rayfield الأقـوى لـلـمـوبـايـل
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

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

-- مـيـزة الـتـدريـب الـتـلـقـائـي (لـزيـادة قـوة الـركـل)
MainTab:CreateToggle({
   Name = "تـدريـب تـلـقـائـي (Auto Lift Weights) 💪",
   CurrentValue = false,
   Flag = "AutoTrainToggle",
   Callback = function(Value)
      _G.AutoTrain = Value
      task.spawn(function()
          while _G.AutoTrain do
              task.wait(0.1)
              local player = game.Players.LocalPlayer
              local char = player.Character or player.CharacterAdded:Wait()
              -- الـبـحـث عـن أداة الـتـدريـب فـي الـحـقـيـبـة أو يـد الـلـاعـب
              local tool = char:FindFirstChildOfClass("Tool") or player.Backpack:FindFirstChildOfClass("Tool")
              if tool then
                  char.Humanoid:EquipTool(tool)
                  tool:Activate()
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
   Content = "جـاهـز سـيـدي الـمـطـور، تـم تـجـهـيـز الـأدوات 🔥",
   Duration = 5,
   Image = 4483345998,
})

-- تـنـبـيـه بـدء الـتـشـغـيـل
print("جـاهـز سـيـدي الـمـطـور.. جـاري تـشـغـيـل الـنـسـخـة الـمـسـتـقـرة 🔥")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- دالـة سـحـب جـمـيـع الـصـنـاديـق لـمـكـانـك
local function collectBlocks()
    for _, block in pairs(workspace:GetDescendants()) do
        if block:IsA("TouchTransmitter") and block.Parent.Name:find("Lucky") then
            firetouchinterest(Character.HumanoidRootPart, block.Parent, 0)
            firetouchinterest(Character.HumanoidRootPart, block.Parent, 1)
        end
    end
end

-- تـشـغـيـل الـسـرعـة والـقـفـز تـلـقـائـيـاً لـلـتـأكـد مـن الـعـمـل
Character.Humanoid.WalkSpeed = 100
Character.Humanoid.JumpPower = 150

-- تـشـغـيـل الـسـحـب فـوراً
collectBlocks()

-- إنـشـاء واجـهـة بـسـيـطـة جـداً (ScreenGui) لـتـفـادي مـشـاكـل الـمـكـتـبـات
local ScreenGui = Instance.new("ScreenGui")
local Button = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
Button.Parent = ScreenGui
Button.Size = UDim2.new(0, 150, 0, 50)
Button.Position = UDim2.new(0.5, -75, 0.1, 0)
Button.Text = "سـحـب الـصـنـاديـق 🔥"
Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Button.TextColor3 = Color3.fromRGB(255, 255, 255)

Button.MouseButton1Click:Connect(function()
    collectBlocks()
    print("تـم الـسـحـب!")
end)

-- Load the UI Library
local UILib = loadstring(game:HttpGet("https://raw.githubusercontent.com/HacksCreator102/UILIB/refs/heads/main/source.lua"))()

-- Create Window
local Window = UILib:CreateWindow("My Script Hub", UDim2.new(0,600,0,400))

-- Create Tabs
local MainTab = Window:CreateTab("Main")
local SettingsTab = Window:CreateTab("Settings")

-- Add Button
MainTab:CreateButton("Click Me!", function()
	Window:Notify("Button Clicked", "You clicked the button!", 3)
end)

-- Add Toggle
MainTab:CreateToggle("Enable Feature", false, function(state)
	if state then
		print("Feature Enabled")
	else
		print("Feature Disabled")
	end
end)

-- Add Slider
MainTab:CreateSlider("Volume", 0, 100, 50, function(value)
	print("Slider Value:", value)
end)

-- Add Dropdown
MainTab:CreateDropdown("Choose Option", {"Option 1","Option 2","Option 3"}, function(selected)
	print("Selected:", selected)
end)

-- Add Textbox
SettingsTab:CreateTextbox("Enter Name", "Your name...", function(text)
	print("Textbox input:", text)
end)

-- Show notification on load
Window:Notify("Welcome", "UI Loaded Successfully!", 3)

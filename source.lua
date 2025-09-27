-- AdvancedScripter UI Library v6.1 (Dual Argument Support)
-- Old UI style + Tabs + Animations + Minimize + Notifications + Confirm
-- Supports BOTH positional and keyword-style arguments.

local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local UILib = {}

-- ✅ CreateWindow
function UILib:CreateWindow(arg1, arg2)
	local title, size
	if typeof(arg1) == "table" then
		title = arg1.Title or "Advanced Scripter"
		size = arg1.Size or UDim2.new(0, 500, 0, 350)
	else
		title = arg1 or "Advanced Scripter"
		size = arg2 or UDim2.new(0, 500, 0, 350)
	end

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "AdvancedScripterUI"
	ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	ScreenGui.ResetOnSpawn = false

	local Frame = Instance.new("Frame", ScreenGui)
	Frame.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
	Frame.Size = size
	Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	Frame.BorderSizePixel = 0
	Frame.ClipsDescendants = true
	Frame.Active = true
	Frame.Draggable = true

	Frame.Size = UDim2.new(0, 0, 0, 0)
	TweenService:Create(Frame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = size}):Play()

	local Topbar = Instance.new("Frame", Frame)
	Topbar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Topbar.Size = UDim2.new(1, 0, 0, 35)
	Topbar.BorderSizePixel = 0

	local Title = Instance.new("TextLabel", Topbar)
	Title.BackgroundTransparency = 1
	Title.Position = UDim2.new(0, 10, 0, 0)
	Title.Size = UDim2.new(1, -90, 1, 0)
	Title.Font = Enum.Font.GothamBold
	Title.Text = title
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextSize = 18
	Title.TextXAlignment = Enum.TextXAlignment.Left

	-- Close Button
	local Close = Instance.new("TextButton", Topbar)
	Close.Text = "X"
	Close.Size = UDim2.new(0, 35, 1, 0)
	Close.Position = UDim2.new(1, -35, 0, 0)
	Close.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
	Close.TextColor3 = Color3.fromRGB(255, 255, 255)
	Close.Font = Enum.Font.GothamBold
	Close.TextSize = 18
	Close.BorderSizePixel = 0

	-- Minimize Button
	local Minimize = Instance.new("TextButton", Topbar)
	Minimize.Text = "-"
	Minimize.Size = UDim2.new(0, 35, 1, 0)
	Minimize.Position = UDim2.new(1, -70, 0, 0)
	Minimize.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
	Minimize.TextColor3 = Color3.fromRGB(255, 255, 255)
	Minimize.Font = Enum.Font.GothamBold
	Minimize.TextSize = 18
	Minimize.BorderSizePixel = 0

	local TabBar = Instance.new("Frame", Frame)
	TabBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	TabBar.Size = UDim2.new(0, 120, 1, -35)
	TabBar.Position = UDim2.new(0, 0, 0, 35)
	TabBar.BorderSizePixel = 0

	local TabLayout = Instance.new("UIListLayout", TabBar)
	TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
	TabLayout.Padding = UDim.new(0, 2)

	local Pages = Instance.new("Folder", Frame)
	local currentTab
	local window = {}
	local activeNotifications = {}

	-- ✅ CreateTab
	function window:CreateTab(arg)
		local tabName
		if typeof(arg) == "table" then
			tabName = arg.Name or "Tab"
		else
			tabName = arg or "Tab"
		end

		local TabButton = Instance.new("TextButton", TabBar)
		TabButton.Text = tabName
		TabButton.Size = UDim2.new(1, 0, 0, 30)
		TabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		TabButton.Font = Enum.Font.Gotham
		TabButton.TextSize = 16
		TabButton.BorderSizePixel = 0

		local Page = Instance.new("ScrollingFrame", Pages)
		Page.Name = tabName
		Page.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		Page.BorderSizePixel = 0
		Page.Position = UDim2.new(0, 120, 0, 35)
		Page.Size = UDim2.new(1, -120, 1, -35)
		Page.Visible = false
		Page.ScrollBarThickness = 6

		local UIList = Instance.new("UIListLayout", Page)
		UIList.SortOrder = Enum.SortOrder.LayoutOrder
		UIList.Padding = UDim.new(0, 6)

		TabButton.MouseButton1Click:Connect(function()
			if currentTab then currentTab.Visible = false end
			for _, btn in ipairs(TabBar:GetChildren()) do
				if btn:IsA("TextButton") then
					TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
				end
			end
			TweenService:Create(TabButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play()
			Page.Visible = true
			currentTab = Page
		end)

		if not currentTab then
			currentTab = Page
			Page.Visible = true
			TabButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
		end

		local tab = {}

		-- ✅ Button
		function tab:CreateButton(arg1, arg2)
			local text, callback
			if typeof(arg1) == "table" then
				text = arg1.Text or "Button"
				callback = arg1.Callback
			else
				text, callback = arg1, arg2
			end

			local Btn = Instance.new("TextButton", Page)
			Btn.Text = text
			Btn.Size = UDim2.new(1, -10, 0, 35)
			Btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
			Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
			Btn.Font = Enum.Font.Gotham
			Btn.TextSize = 16
			Btn.BorderSizePixel = 0
			Btn.MouseButton1Click:Connect(callback or function() end)
		end

		-- ✅ Toggle
		function tab:CreateToggle(arg1, arg2, arg3)
			local text, default, callback
			if typeof(arg1) == "table" then
				text = arg1.Text or "Toggle"
				default = arg1.Default or false
				callback = arg1.Callback
			else
				text, default, callback = arg1, arg2, arg3
			end

			local Toggle = Instance.new("TextButton", Page)
			Toggle.Size = UDim2.new(1, -10, 0, 35)
			Toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
			Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
			Toggle.Font = Enum.Font.Gotham
			Toggle.TextSize = 16
			Toggle.BorderSizePixel = 0
			local state = default
			Toggle.Text = text .. ": " .. (state and "ON" or "OFF")
			Toggle.MouseButton1Click:Connect(function()
				state = not state
				Toggle.Text = text .. ": " .. (state and "ON" or "OFF")
				if callback then callback(state) end
			end)
		end

		-- ✅ Slider
		function tab:CreateSlider(arg1, arg2, arg3, arg4, arg5)
			local text, min, max, default, callback
			if typeof(arg1) == "table" then
				text = arg1.Text or "Slider"
				min = arg1.Min or 0
				max = arg1.Max or 100
				default = arg1.Default or 0
				callback = arg1.Callback
			else
				text, min, max, default, callback = arg1, arg2, arg3, arg4, arg5
			end

			local Frame = Instance.new("Frame", Page)
			Frame.Size = UDim2.new(1, -10, 0, 45)
			Frame.BackgroundTransparency = 1

			local Label = Instance.new("TextLabel", Frame)
			Label.Text = text .. " (" .. default .. ")"
			Label.Size = UDim2.new(1, 0, 0, 20)
			Label.BackgroundTransparency = 1
			Label.TextColor3 = Color3.fromRGB(255, 255, 255)
			Label.Font = Enum.Font.Gotham
			Label.TextSize = 14

			local SliderBack = Instance.new("Frame", Frame)
			SliderBack.Size = UDim2.new(1, 0, 0, 15)
			SliderBack.Position = UDim2.new(0, 0, 0, 25)
			SliderBack.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
			SliderBack.BorderSizePixel = 0

			local Fill = Instance.new("Frame", SliderBack)
			Fill.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
			Fill.BorderSizePixel = 0
			Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)

			local dragging = false
			SliderBack.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
			end)
			UIS.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
			end)
			UIS.InputChanged:Connect(function(input)
				if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
					local pos = math.clamp((input.Position.X - SliderBack.AbsolutePosition.X) / SliderBack.AbsoluteSize.X, 0, 1)
					local value = math.floor(min + (max - min) * pos)
					Fill.Size = UDim2.new(pos, 0, 1, 0)
					Label.Text = text .. " (" .. value .. ")"
					if callback then callback(value) end
				end
			end)
		end

		-- ✅ Dropdown
		function tab:CreateDropdown(arg1, arg2, arg3)
			local text, options, callback
			if typeof(arg1) == "table" then
				text = arg1.Text or "Dropdown"
				options = arg1.Options or {}
				callback = arg1.Callback
			else
				text, options, callback = arg1, arg2, arg3
			end

			local Dropdown = Instance.new("TextButton", Page)
			Dropdown.Size = UDim2.new(1, -10, 0, 35)
			Dropdown.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
			Dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
			Dropdown.Font = Enum.Font.Gotham
			Dropdown.TextSize = 16
			Dropdown.Text = text .. ": " .. (options[1] or "None")
			Dropdown.BorderSizePixel = 0

			local selected = options[1] or "None"
			local open = false

			local OptionFrame = Instance.new("Frame", Page)
			OptionFrame.Size = UDim2.new(1, -10, 0, 0)
			OptionFrame.BackgroundTransparency = 1
			OptionFrame.Visible = false

			local List = Instance.new("UIListLayout", OptionFrame)
			List.SortOrder = Enum.SortOrder.LayoutOrder

			for _, opt in ipairs(options) do
				local Btn = Instance.new("TextButton", OptionFrame)
				Btn.Size = UDim2.new(1, 0, 0, 25)
				Btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
				Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
				Btn.Font = Enum.Font.Gotham
				Btn.TextSize = 14
				Btn.Text = opt
				Btn.BorderSizePixel = 0
				Btn.MouseButton1Click:Connect(function()
					selected = opt
					Dropdown.Text = text .. ": " .. opt
					OptionFrame.Visible = false
					open = false
					if callback then callback(opt) end
				end)
			end

			Dropdown.MouseButton1Click:Connect(function()
				open = not open
				OptionFrame.Visible = open
				OptionFrame.Size = UDim2.new(1, -10, 0, open and (#options * 25) or 0)
			end)
		end

		-- ✅ Textbox
		function tab:CreateTextbox(arg1, arg2, arg3)
			local text, placeholder, callback
			if typeof(arg1) == "table" then
				text = arg1.Text or "Textbox"
				placeholder = arg1.Placeholder or ""
				callback = arg1.Callback
			else
				text, placeholder, callback = arg1, arg2, arg3
			end

			local Frame = Instance.new("Frame", Page)
			Frame.Size = UDim2.new(1, -10, 0, 45)
			Frame.BackgroundTransparency = 1

			local Label = Instance.new("TextLabel", Frame)
			Label.Text = text
			Label.Size = UDim2.new(1, 0, 0, 20)
			Label.BackgroundTransparency = 1
			Label.TextColor3 = Color3.fromRGB(255, 255, 255)
			Label.Font = Enum.Font.Gotham
			Label.TextSize = 14

			local Box = Instance.new("TextBox", Frame)
			Box.PlaceholderText = placeholder
			Box.Size = UDim2.new(1, 0, 0, 25)
			Box.Position = UDim2.new(0, 0, 0, 20)
			Box.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
			Box.TextColor3 = Color3.fromRGB(255, 255, 255)
			Box.Font = Enum.Font.Gotham
			Box.TextSize = 14
			Box.ClearTextOnFocus = false
			Box.BorderSizePixel = 0

			Box.FocusLost:Connect(function(enter)
				if enter and callback then callback(Box.Text) end
			end)
		end

		return tab
	end

	-- ✅ Notifications
	function window:Notify(title, msg, duration)
		local Notification = Instance.new("Frame", Frame)
		Notification.Size = UDim2.new(0, 250, 0, 60)
		Notification.Position = UDim2.new(1, -260, 1, -70 - (#activeNotifications * 70))
		Notification.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		Notification.BorderSizePixel = 0
		Notification.ClipsDescendants = true

		local Title = Instance.new("TextLabel", Notification)
		Title.Text = title
		Title.Size = UDim2.new(1, -10, 0, 20)
		Title.Position = UDim2.new(0, 5, 0, 5)
		Title.TextColor3 = Color3.fromRGB(255, 255, 255)
		Title.BackgroundTransparency = 1
		Title.Font = Enum.Font.GothamBold
		Title.TextSize = 16
		Title.TextXAlignment = Enum.TextXAlignment.Left

		local Msg = Instance.new("TextLabel", Notification)
		Msg.Text = msg
		Msg.Size = UDim2.new(1, -10, 1, -25)
		Msg.Position = UDim2.new(0, 5, 0, 25)
		Msg.TextColor3 = Color3.fromRGB(200, 200, 200)
		Msg.BackgroundTransparency = 1
		Msg.Font = Enum.Font.Gotham
		Msg.TextSize = 14
		Msg.TextWrapped = true
		Msg.TextXAlignment = Enum.TextXAlignment.Left
		Msg.TextYAlignment = Enum.TextYAlignment.Top

		table.insert(activeNotifications, Notification)

		task.delay(duration or 3, function()
			Notification:Destroy()
			table.remove(activeNotifications, 1)
		end)
	end

	return window
end

return UILib

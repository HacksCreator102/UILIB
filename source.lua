-- AdvancedScripter UI Library (Fixed Tabs + UIListLayout + Unload Confirmation)
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local UILib = {}
local activeNotifications = {}

function UILib:CreateWindow(arg1, arg2)
	local title, size
	if typeof(arg1) == "table" then
		title = arg1.Title or "Window"
		size = arg1.Size or UDim2.new(0, 400, 0, 300)
	else
		title = arg1 or "Window"
		size = arg2 or UDim2.new(0, 400, 0, 300)
	end

	local window = {}
	local player = game.Players.LocalPlayer
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Parent = player:WaitForChild("PlayerGui")

	-- Main Window
	local MainFrame = Instance.new("Frame")
	MainFrame.Size = size
	MainFrame.Position = UDim2.new(0.5, -size.X.Offset/2, 0.5, -size.Y.Offset/2)
	MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	MainFrame.BorderSizePixel = 0
	MainFrame.Active = true
	MainFrame.Draggable = true
	MainFrame.Parent = ScreenGui

	-- Title Bar
	local TitleBar = Instance.new("Frame")
	TitleBar.Size = UDim2.new(1, 0, 0, 30)
	TitleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	TitleBar.Parent = MainFrame

	local TitleLabel = Instance.new("TextLabel")
	TitleLabel.Size = UDim2.new(1, -60, 1, 0)
	TitleLabel.Position = UDim2.new(0, 10, 0, 0)
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.Text = title
	TitleLabel.Font = Enum.Font.SourceSansBold
	TitleLabel.TextSize = 18
	TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	TitleLabel.Parent = TitleBar

	-- Close Button
	local CloseButton = Instance.new("TextButton")
	CloseButton.Size = UDim2.new(0, 30, 1, 0)
	CloseButton.Position = UDim2.new(1, -30, 0, 0)
	CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
	CloseButton.Text = "X"
	CloseButton.TextColor3 = Color3.new(1, 1, 1)
	CloseButton.Parent = TitleBar

	-- Tab Container
	local TabContainer = Instance.new("Frame")
	TabContainer.Size = UDim2.new(0, 120, 1, -30)
	TabContainer.Position = UDim2.new(0, 0, 0, 30)
	TabContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	TabContainer.Parent = MainFrame

	-- UIListLayout for stacked tab buttons
	local TabLayout = Instance.new("UIListLayout")
	TabLayout.FillDirection = Enum.FillDirection.Vertical
	TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
	TabLayout.Padding = UDim.new(0, 2)
	TabLayout.Parent = TabContainer

	local ContentContainer = Instance.new("Frame")
	ContentContainer.Size = UDim2.new(1, -120, 1, -30)
	ContentContainer.Position = UDim2.new(0, 120, 0, 30)
	ContentContainer.BackgroundTransparency = 1
	ContentContainer.Parent = MainFrame

	-- Confirmation Popup
	local function showUnloadConfirm()
		local ConfirmFrame = Instance.new("Frame")
		ConfirmFrame.Size = UDim2.new(0, 250, 0, 120)
		ConfirmFrame.Position = UDim2.new(0.5, -125, 0.5, -60)
		ConfirmFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		ConfirmFrame.Parent = MainFrame
		ConfirmFrame.ZIndex = 10

		local ConfirmLabel = Instance.new("TextLabel")
		ConfirmLabel.Size = UDim2.new(1, -20, 0, 60)
		ConfirmLabel.Position = UDim2.new(0, 10, 0, 10)
		ConfirmLabel.Text = "Do you really want to unload?"
		ConfirmLabel.BackgroundTransparency = 1
		ConfirmLabel.Font = Enum.Font.SourceSansBold
		ConfirmLabel.TextSize = 18
		ConfirmLabel.TextColor3 = Color3.new(1,1,1)
		ConfirmLabel.ZIndex = 10
		ConfirmLabel.Parent = ConfirmFrame

		local YesButton = Instance.new("TextButton")
		YesButton.Size = UDim2.new(0.5, -15, 0, 30)
		YesButton.Position = UDim2.new(0, 10, 1, -40)
		YesButton.Text = "Yes"
		YesButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
		YesButton.TextColor3 = Color3.new(1,1,1)
		YesButton.ZIndex = 10
		YesButton.Parent = ConfirmFrame

		local NoButton = Instance.new("TextButton")
		NoButton.Size = UDim2.new(0.5, -15, 0, 30)
		NoButton.Position = UDim2.new(0.5, 5, 1, -40)
		NoButton.Text = "No"
		NoButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
		NoButton.TextColor3 = Color3.new(1,1,1)
		NoButton.ZIndex = 10
		NoButton.Parent = ConfirmFrame

		YesButton.MouseButton1Click:Connect(function()
			ScreenGui:Destroy()
		end)

		NoButton.MouseButton1Click:Connect(function()
			ConfirmFrame:Destroy()
		end)
	end

	CloseButton.MouseButton1Click:Connect(function()
		showUnloadConfirm()
	end)

	-- Tab System
	local activePage, activeButton

	function window:CreateTab(arg)
		local tabName = typeof(arg) == "table" and arg.Name or arg
		local tab = {}

		local Button = Instance.new("TextButton")
		Button.Size = UDim2.new(1, -4, 0, 30)
		Button.Text = tabName
		Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		Button.TextColor3 = Color3.new(1,1,1)
		Button.Parent = TabContainer

		local Page = Instance.new("ScrollingFrame")
		Page.Size = UDim2.new(1, 0, 1, 0)
		Page.Visible = false
		Page.BackgroundTransparency = 1
		Page.ScrollBarThickness = 6
		Page.Parent = ContentContainer

		local PageLayout = Instance.new("UIListLayout")
		PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
		PageLayout.Padding = UDim.new(0, 5)
		PageLayout.Parent = Page

		Button.MouseButton1Click:Connect(function()
			if activePage then activePage.Visible = false end
			if activeButton then activeButton.BackgroundColor3 = Color3.fromRGB(60,60,60) end

			Page.Visible = true
			activePage = Page

			Button.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
			activeButton = Button
		end)

		-- Auto-select first tab
		if not activePage then
			Page.Visible = true
			activePage = Page
			Button.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
			activeButton = Button
		end

		function tab:CreateButton(arg, callback)
			local text = typeof(arg) == "table" and arg.Text or arg
			local Btn = Instance.new("TextButton")
			Btn.Size = UDim2.new(0, 200, 0, 30)
			Btn.Text = text
			Btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
			Btn.TextColor3 = Color3.new(1,1,1)
			Btn.Parent = Page
			Btn.LayoutOrder = #Page:GetChildren() -- Keep stacking in order
			Btn.MouseButton1Click:Connect(function()
				if callback then callback() end
			end)
		end

		function tab:CreateToggle(arg, default, callback)
			local text = typeof(arg) == "table" and arg.Text or arg
			local Toggle = Instance.new("TextButton")
			Toggle.Size = UDim2.new(0, 200, 0, 30)
			Toggle.Text = text .. ": " .. (default and "ON" or "OFF")
			Toggle.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
			Toggle.TextColor3 = Color3.new(1,1,1)
			Toggle.Parent = Page
			Toggle.LayoutOrder = #Page:GetChildren()
			local state = default
			Toggle.MouseButton1Click:Connect(function()
				state = not state
				Toggle.Text = text .. ": " .. (state and "ON" or "OFF")
				if callback then callback(state) end
			end)
		end

		function tab:CreateSlider(arg, min, max, default, callback)
			local text = typeof(arg) == "table" and arg.Text or arg
			local SliderLabel = Instance.new("TextLabel")
			SliderLabel.Size = UDim2.new(0, 200, 0, 30)
			SliderLabel.Text = text .. ": " .. default
			SliderLabel.TextColor3 = Color3.new(1,1,1)
			SliderLabel.BackgroundTransparency = 1
			SliderLabel.Parent = Page
			SliderLabel.LayoutOrder = #Page:GetChildren()
			local value = default
			if callback then callback(value) end
		end

		function tab:CreateDropdown(arg, options, callback)
			local text = typeof(arg) == "table" and arg.Text or arg
			local Dropdown = Instance.new("TextButton")
			Dropdown.Size = UDim2.new(0, 200, 0, 30)
			Dropdown.Text = text .. " ▼"
			Dropdown.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
			Dropdown.TextColor3 = Color3.new(1,1,1)
			Dropdown.Parent = Page
			Dropdown.LayoutOrder = #Page:GetChildren()
			Dropdown.MouseButton1Click:Connect(function()
				if callback then callback(options[1]) end
			end)
		end

		function tab:CreateTextbox(arg, placeholder, callback)
			local text = typeof(arg) == "table" and arg.Text or arg
			local Box = Instance.new("TextBox")
			Box.Size = UDim2.new(0, 200, 0, 30)
			Box.PlaceholderText = placeholder or ""
			Box.Text = ""
			Box.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
			Box.TextColor3 = Color3.new(1,1,1)
			Box.Parent = Page
			Box.LayoutOrder = #Page:GetChildren()
			Box.FocusLost:Connect(function()
				if callback then callback(Box.Text) end
			end)
		end

		return tab
	end

	function window:Notify(title, msg, duration)
		local Notification = Instance.new("Frame")
		Notification.Size = UDim2.new(0, 250, 0, 80)
		Notification.Position = UDim2.new(1, -260, 1, -(#activeNotifications * 90) - 90)
		Notification.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		Notification.Parent = ScreenGui
		Notification.ZIndex = 10

		local Title = Instance.new("TextLabel")
		Title.Size = UDim2.new(1, -10, 0, 20)
		Title.Position = UDim2.new(0, 5, 0, 5)
		Title.BackgroundTransparency = 1
		Title.Text = title
		Title.TextColor3 = Color3.new(1,1,1)
		Title.Font = Enum.Font.SourceSansBold
		Title.TextSize = 16
		Title.ZIndex = 10
		Title.Parent = Notification

		local Msg = Instance.new("TextLabel")
		Msg.Size = UDim2.new(1, -10, 1, -30)
		Msg.Position = UDim2.new(0, 5, 0, 25)
		Msg.BackgroundTransparency = 1
		Msg.Text = msg
		Msg.TextColor3 = Color3.new(1,1,1)
		Msg.Font = Enum.Font.SourceSans
		Msg.TextSize = 14
		Msg.TextWrapped = true
		Msg.ZIndex = 10
		Msg.Parent = Notification

		table.insert(activeNotifications, Notification)
		task.delay(duration or 3, function()
			Notification:Destroy()
			table.remove(activeNotifications, 1)
		end)
	end

	return window
end

return UILib

-- AdvancedScripter UI Library Full Version
-- Old UI style + Tabs + Animations + Minimize + Stackable Notifications + Unload Confirmation
-- Version 6.0

local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local UILib = {}

function UILib:CreateWindow(settings)
	settings = settings or {}
	local title = settings.Title or "Advanced Scripter"
	local size = settings.Size or UDim2.new(0, 500, 0, 350)

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "AdvancedScripterUI"
	ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	ScreenGui.ResetOnSpawn = false

	-- Main Frame
	local Frame = Instance.new("Frame", ScreenGui)
	Frame.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
	Frame.Size = size
	Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	Frame.BorderSizePixel = 0
	Frame.ClipsDescendants = true
	Frame.Active = true
	Frame.Draggable = true

	-- Appear animation
	Frame.Size = UDim2.new(0, 0, 0, 0)
	TweenService:Create(Frame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = size}):Play()

	-- Topbar
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

	-- Close & Minimize Buttons
	local CloseButton = Instance.new("TextButton", Topbar)
	CloseButton.Text = "X"
	CloseButton.Size = UDim2.new(0, 35, 0, 35)
	CloseButton.Position = UDim2.new(1, -35, 0, 0)
	CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
	CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	CloseButton.Font = Enum.Font.GothamBold
	CloseButton.TextSize = 18
	CloseButton.BorderSizePixel = 0

	local MinimizeButton = Instance.new("TextButton", Topbar)
	MinimizeButton.Text = "_"
	MinimizeButton.Size = UDim2.new(0, 35, 0, 35)
	MinimizeButton.Position = UDim2.new(1, -70, 0, 0)
	MinimizeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
	MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	MinimizeButton.Font = Enum.Font.GothamBold
	MinimizeButton.TextSize = 18
	MinimizeButton.BorderSizePixel = 0

	-- Minimized button
	local MiniButton = Instance.new("TextButton", ScreenGui)
	MiniButton.Text = title
	MiniButton.Size = UDim2.new(0, 120, 0, 30)
	MiniButton.Position = UDim2.new(0, 20, 1, -50)
	MiniButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	MiniButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	MiniButton.Font = Enum.Font.GothamBold
	MiniButton.TextSize = 14
	MiniButton.BorderSizePixel = 0
	MiniButton.Active = true
	MiniButton.Draggable = true
	MiniButton.Visible = false

	MinimizeButton.MouseButton1Click:Connect(function()
		Frame.Visible = false
		MiniButton.Visible = true
	end)

	MiniButton.MouseButton1Click:Connect(function()
		Frame.Visible = true
		MiniButton.Visible = false
	end)

	-- Close confirmation
	CloseButton.MouseButton1Click:Connect(function()
		local confirm = Instance.new("Frame", ScreenGui)
		confirm.Size = UDim2.new(0, 300, 0, 120)
		confirm.Position = UDim2.new(0.5, -150, 0.5, -60)
		confirm.BackgroundColor3 = Color3.fromRGB(50,50,50)
		confirm.BorderSizePixel = 0
		confirm.ClipsDescendants = true

		local txt = Instance.new("TextLabel", confirm)
		txt.Size = UDim2.new(1, -20, 0, 50)
		txt.Position = UDim2.new(0, 10, 0, 10)
		txt.BackgroundTransparency = 1
		txt.Text = "Are you sure to unload the Script?"
		txt.Font = Enum.Font.GothamBold
		txt.TextSize = 16
		txt.TextColor3 = Color3.fromRGB(255,255,255)
		txt.TextWrapped = true

		local yesBtn = Instance.new("TextButton", confirm)
		yesBtn.Text = "Yes"
		yesBtn.Size = UDim2.new(0.4,0,0,35)
		yesBtn.Position = UDim2.new(0.05,0,0,70)
		yesBtn.BackgroundColor3 = Color3.fromRGB(50,200,50)
		yesBtn.TextColor3 = Color3.fromRGB(255,255,255)
		yesBtn.Font = Enum.Font.GothamBold
		yesBtn.TextSize = 16
		yesBtn.BorderSizePixel = 0

		local noBtn = Instance.new("TextButton", confirm)
		noBtn.Text = "No"
		noBtn.Size = UDim2.new(0.4,0,0,35)
		noBtn.Position = UDim2.new(0.55,0,0,70)
		noBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
		noBtn.TextColor3 = Color3.fromRGB(255,255,255)
		noBtn.Font = Enum.Font.GothamBold
		noBtn.TextSize = 16
		noBtn.BorderSizePixel = 0

		yesBtn.MouseButton1Click:Connect(function()
			ScreenGui:Destroy()
		end)
		noBtn.MouseButton1Click:Connect(function()
			confirm:Destroy()
		end)
	end)

	-- Tab system
	local TabBar = Instance.new("Frame", Frame)
	TabBar.BackgroundColor3 = Color3.fromRGB(25,25,25)
	TabBar.Size = UDim2.new(0, 120, 1, -35)
	TabBar.Position = UDim2.new(0, 0, 0, 35)
	TabBar.BorderSizePixel = 0

	local TabLayout = Instance.new("UIListLayout", TabBar)
	TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
	TabLayout.Padding = UDim.new(0,2)

	local Pages = Instance.new("Folder", Frame)
	local currentTab
	local window = {}
	local activeNotifications = {}

	function window:CreateTab(tabName)
		local TabButton = Instance.new("TextButton", TabBar)
		TabButton.Text = tabName
		TabButton.Size = UDim2.new(1,0,0,30)
		TabButton.BackgroundColor3 = Color3.fromRGB(50,50,50)
		TabButton.TextColor3 = Color3.fromRGB(255,255,255)
		TabButton.Font = Enum.Font.Gotham
		TabButton.TextSize = 16
		TabButton.BorderSizePixel = 0

		local Page = Instance.new("ScrollingFrame", Pages)
		Page.Name = tabName
		Page.BackgroundColor3 = Color3.fromRGB(45,45,45)
		Page.BorderSizePixel = 0
		Page.Position = UDim2.new(0,120,0,35)
		Page.Size = UDim2.new(1,-120,1,-35)
		Page.Visible = false
		Page.ScrollBarThickness = 6

		local UIList = Instance.new("UIListLayout", Page)
		UIList.SortOrder = Enum.SortOrder.LayoutOrder
		UIList.Padding = UDim.new(0,6)

		TabButton.MouseButton1Click:Connect(function()
			if currentTab then
				currentTab.Visible = false
			end
			for _, btn in ipairs(TabBar:GetChildren()) do
				if btn:IsA("TextButton") then
					TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3=Color3.fromRGB(50,50,50)}):Play()
				end
			end
			TweenService:Create(TabButton, TweenInfo.new(0.2), {BackgroundColor3=Color3.fromRGB(80,80,80)}):Play()
			Page.Visible = true
			currentTab = Page
		end)

		if not currentTab then
			currentTab = Page
			Page.Visible = true
			TabButton.BackgroundColor3 = Color3.fromRGB(80,80,80)
		end

		local tab = {}

		function tab:CreateButton(text, callback)
			local Btn = Instance.new("TextButton", Page)
			Btn.Text = text
			Btn.Size = UDim2.new(1,-10,0,35)
			Btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
			Btn.TextColor3 = Color3.fromRGB(255,255,255)
			Btn.Font = Enum.Font.Gotham
			Btn.TextSize = 16
			Btn.BorderSizePixel = 0
			Btn.MouseButton1Click:Connect(callback)
		end

		function tab:CreateToggle(text, default, callback)
			local Toggle = Instance.new("TextButton", Page)
			Toggle.Size = UDim2.new(1,-10,0,35)
			Toggle.BackgroundColor3 = Color3.fromRGB(60,60,60)
			Toggle.TextColor3 = Color3.fromRGB(255,255,255)
			Toggle.Font = Enum.Font.Gotham
			Toggle.TextSize = 16
			Toggle.BorderSizePixel = 0
			local state = default or false
			Toggle.Text = text..": "..(state and "ON" or "OFF")
			Toggle.MouseButton1Click:Connect(function()
				state = not state
				Toggle.Text = text..": "..(state and "ON" or "OFF")
				if callback then callback(state) end
			end)
		end

		-- Inside the tab creation (inside window:CreateTab) add these functions:

function tab:CreateSlider(text, min, max, default, callback)
    local SliderFrame = Instance.new("Frame", Page)
    SliderFrame.Size = UDim2.new(1, -10, 0, 50)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(60,60,60)
    SliderFrame.BorderSizePixel = 0

    local Label = Instance.new("TextLabel", SliderFrame)
    Label.Size = UDim2.new(1, -10, 0, 20)
    Label.Position = UDim2.new(0,5,0,0)
    Label.BackgroundTransparency = 1
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 16
    Label.TextColor3 = Color3.fromRGB(255,255,255)
    Label.Text = text.." : "..tostring(default)
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local SliderBar = Instance.new("Frame", SliderFrame)
    SliderBar.Size = UDim2.new(1, -10, 0, 8)
    SliderBar.Position = UDim2.new(0,5,0,30)
    SliderBar.BackgroundColor3 = Color3.fromRGB(100,100,100)
    SliderBar.BorderSizePixel = 0

    local SliderKnob = Instance.new("Frame", SliderBar)
    SliderKnob.Size = UDim2.new((default-min)/(max-min),0,1,0)
    SliderKnob.BackgroundColor3 = Color3.fromRGB(220,60,60)
    SliderKnob.BorderSizePixel = 0

    local dragging = false
    SliderKnob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local relative = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X)/SliderBar.AbsoluteSize.X,0,1)
            SliderKnob.Size = UDim2.new(relative,0,1,0)
            local value = math.floor(min + (max-min)*relative)
            Label.Text = text.." : "..tostring(value)
            if callback then callback(value) end
        end
    end)
end

		function tab:CreateDropdown(text, options, callback)
			local DropFrame = Instance.new("TextButton") -- Changed to TextButton for click
			DropFrame.Size = UDim2.new(1, -10, 0, 35)
			DropFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
			DropFrame.BorderSizePixel = 0
			DropFrame.Text = "" -- No text, we use a Label
			DropFrame.AutoButtonColor = true
			DropFrame.Parent = Page

			local Label = Instance.new("TextLabel", DropFrame)
			Label.Size = UDim2.new(1, -10, 1, 0)
			Label.Position = UDim2.new(0, 5, 0, 0)
			Label.BackgroundTransparency = 1
			Label.Font = Enum.Font.GothamBold
			Label.TextSize = 16
			Label.TextColor3 = Color3.fromRGB(255, 255, 255)
			Label.Text = text .. " : " .. options[1]
			Label.TextXAlignment = Enum.TextXAlignment.Left

			local DropdownOpen = false
			local DropdownList = Instance.new("Frame", DropFrame)
			DropdownList.Size = UDim2.new(1, 0, 0, #options * 30)
			DropdownList.Position = UDim2.new(0, 0, 1, 0)
			DropdownList.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			DropdownList.Visible = false
			DropdownList.ClipsDescendants = true

			for i, opt in ipairs(options) do
				local btn = Instance.new("TextButton", DropdownList)
				btn.Size = UDim2.new(1, 0, 0, 30)
				btn.Position = UDim2.new(0, 0, 0, (i - 1) * 30)
				btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
				btn.TextColor3 = Color3.fromRGB(255, 255, 255)
				btn.Font = Enum.Font.Gotham
				btn.TextSize = 14
				btn.Text = opt
				btn.BorderSizePixel = 0

				btn.MouseButton1Click:Connect(function()
					Label.Text = text .. " : " .. opt
					DropdownList.Visible = false
					DropdownOpen = false
					if callback then callback(opt) end
				end)
			end

			DropFrame.MouseButton1Click:Connect(function()
				DropdownOpen = not DropdownOpen
				DropdownList.Visible = DropdownOpen
			end)
		end


function tab:CreateTextbox(text, placeholder, callback)
    local BoxFrame = Instance.new("Frame", Page)
    BoxFrame.Size = UDim2.new(1, -10, 0, 35)
    BoxFrame.BackgroundColor3 = Color3.fromRGB(60,60,60)
    BoxFrame.BorderSizePixel = 0

    local TextBox = Instance.new("TextBox", BoxFrame)
    TextBox.Size = UDim2.new(1, -10, 1, 0)
    TextBox.Position = UDim2.new(0,5,0,0)
    TextBox.BackgroundColor3 = Color3.fromRGB(70,70,70)
    TextBox.TextColor3 = Color3.fromRGB(255,255,255)
    TextBox.PlaceholderText = placeholder
    TextBox.Font = Enum.Font.Gotham
    TextBox.TextSize = 14
    TextBox.BorderSizePixel = 0

    TextBox.FocusLost:Connect(function(enterPressed)
        if enterPressed and callback then
            callback(TextBox.Text)
        end
    end)
end


		return tab
	end

	-- Notifications (stackable)
	function window:Notify(title, msg, duration)
		duration = duration or 3
		local Note = Instance.new("Frame", ScreenGui)
		Note.Size = UDim2.new(0,250,0,60)
		Note.BackgroundColor3 = Color3.fromRGB(40,40,40)
		Note.BorderSizePixel = 0
		Note.ClipsDescendants = true

		local TitleLabel = Instance.new("TextLabel", Note)
		TitleLabel.BackgroundTransparency = 1
		TitleLabel.Size = UDim2.new(1,-10,0,25)
		TitleLabel.Position = UDim2.new(0,5,0,5)
		TitleLabel.Text = title
		TitleLabel.Font = Enum.Font.GothamBold
		TitleLabel.TextSize = 16
		TitleLabel.TextColor3 = Color3.fromRGB(255,255,255)
		TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

		local MsgLabel = Instance.new("TextLabel", Note)
		MsgLabel.BackgroundTransparency = 1
		MsgLabel.Size = UDim2.new(1,-10,0,25)
		MsgLabel.Position = UDim2.new(0,5,0,30)
		MsgLabel.Text = msg
		MsgLabel.Font = Enum.Font.Gotham
		MsgLabel.TextSize = 14
		MsgLabel.TextColor3 = Color3.fromRGB(200,200,200)
		MsgLabel.TextXAlignment = Enum.TextXAlignment.Left

		-- Determine position
		local offsetY = -80
		for _, n in ipairs(activeNotifications) do
			offsetY = offsetY - (n.AbsoluteSize.Y + 10)
		end
		Note.Position = UDim2.new(1,0,1,offsetY)
		table.insert(activeNotifications, Note)

		TweenService:Create(Note, TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
			{Position=UDim2.new(1,-270,1,offsetY)}):Play()

		task.delay(duration,function()
			TweenService:Create(Note, TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.In),
				{Position=UDim2.new(1,0,1,offsetY)}):Play()
			task.wait(0.3)
			Note:Destroy()
			for i,n in ipairs(activeNotifications) do
				if n==Note then table.remove(activeNotifications,i) break end
			end
			local newOffset = -80
			for _,n in ipairs(activeNotifications) do
				TweenService:Create(n, TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
					{Position=UDim2.new(1,-270,1,newOffset)}):Play()
				newOffset = newOffset - (n.AbsoluteSize.Y + 10)
			end
		end)
	end

	return window
end

return UILib

-- AdvancedScripter UI Library v7.1 (All Components + Animated)
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
	ScreenGui.Name = "AdvancedScripterUI"
	ScreenGui.Parent = player:WaitForChild("PlayerGui")

	-- Main Window
	local MainFrame = Instance.new("Frame")
	MainFrame.Size = size
	MainFrame.Position = UDim2.new(0.5, -size.X.Offset/2, 0.5, -size.Y.Offset/2)
	MainFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
	MainFrame.BorderSizePixel = 0
	MainFrame.Active = true
	MainFrame.Draggable = true
	MainFrame.Parent = ScreenGui
	MainFrame.ClipsDescendants = true
	MainFrame.AnchorPoint = Vector2.new(0.5,0.5)
	MainFrame.BackgroundTransparency = 1
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0,8)
	corner.Parent = MainFrame
	TweenService:Create(MainFrame, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()

	-- Title Bar
	local TitleBar = Instance.new("Frame")
	TitleBar.Size = UDim2.new(1,0,0,30)
	TitleBar.BackgroundColor3 = Color3.fromRGB(40,40,40)
	TitleBar.Parent = MainFrame

	local TitleLabel = Instance.new("TextLabel")
	TitleLabel.Size = UDim2.new(1,-60,1,0)
	TitleLabel.Position = UDim2.new(0,10,0,0)
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.Text = title
	TitleLabel.Font = Enum.Font.SourceSansBold
	TitleLabel.TextSize = 18
	TitleLabel.TextColor3 = Color3.fromRGB(255,255,255)
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	TitleLabel.Parent = TitleBar

	local CloseButton = Instance.new("TextButton")
	CloseButton.Size = UDim2.new(0,30,1,0)
	CloseButton.Position = UDim2.new(1,-30,0,0)
	CloseButton.BackgroundColor3 = Color3.fromRGB(200,50,50)
	CloseButton.Text = "X"
	CloseButton.TextColor3 = Color3.new(1,1,1)
	CloseButton.AutoButtonColor = false
	CloseButton.Parent = TitleBar
	local closeCorner = Instance.new("UICorner")
	closeCorner.CornerRadius = UDim.new(0,4)
	closeCorner.Parent = CloseButton
	CloseButton.MouseEnter:Connect(function()
		TweenService:Create(CloseButton,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(255,80,80)}):Play()
	end)
	CloseButton.MouseLeave:Connect(function()
		TweenService:Create(CloseButton,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(200,50,50)}):Play()
	end)

	-- Tab Container
	local TabContainer = Instance.new("Frame")
	TabContainer.Size = UDim2.new(0,140,1,-30)
	TabContainer.Position = UDim2.new(0,0,0,30)
	TabContainer.BackgroundColor3 = Color3.fromRGB(35,35,35)
	TabContainer.Parent = MainFrame
	local TabLayout = Instance.new("UIListLayout")
	TabLayout.FillDirection = Enum.FillDirection.Vertical
	TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
	TabLayout.Padding = UDim.new(0,2)
	TabLayout.Parent = TabContainer

	local ContentContainer = Instance.new("Frame")
	ContentContainer.Size = UDim2.new(1,-140,1,-30)
	ContentContainer.Position = UDim2.new(0,140,0,30)
	ContentContainer.BackgroundTransparency = 1
	ContentContainer.Parent = MainFrame

	local activePage, activeButton

	local function showUnloadConfirm()
		local ConfirmFrame = Instance.new("Frame")
		ConfirmFrame.Size = UDim2.new(0,0,0,0)
		ConfirmFrame.Position = UDim2.new(0.5,0.5,0.5,0.5)
		ConfirmFrame.AnchorPoint = Vector2.new(0.5,0.5)
		ConfirmFrame.BackgroundColor3 = Color3.fromRGB(35,35,35)
		ConfirmFrame.Parent = MainFrame
		ConfirmFrame.ClipsDescendants = true
		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0,8)
		corner.Parent = ConfirmFrame
		TweenService:Create(ConfirmFrame, TweenInfo.new(0.3,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Size=UDim2.new(0,250,0,120)}):Play()

		local ConfirmLabel = Instance.new("TextLabel")
		ConfirmLabel.Size = UDim2.new(1,-20,0,60)
		ConfirmLabel.Position = UDim2.new(0,10,0,10)
		ConfirmLabel.Text = "Do you really want to unload?"
		ConfirmLabel.BackgroundTransparency = 1
		ConfirmLabel.Font = Enum.Font.SourceSansBold
		ConfirmLabel.TextSize = 18
		ConfirmLabel.TextColor3 = Color3.new(1,1,1)
		ConfirmLabel.Parent = ConfirmFrame

		local YesButton = Instance.new("TextButton")
		YesButton.Size = UDim2.new(0.5,-15,0,30)
		YesButton.Position = UDim2.new(0,10,1,-40)
		YesButton.Text = "Yes"
		YesButton.BackgroundColor3 = Color3.fromRGB(50,200,50)
		YesButton.TextColor3 = Color3.new(1,1,1)
		YesButton.Parent = ConfirmFrame
		local NoButton = Instance.new("TextButton")
		NoButton.Size = UDim2.new(0.5,-15,0,30)
		NoButton.Position = UDim2.new(0.5,5,1,-40)
		NoButton.Text = "No"
		NoButton.BackgroundColor3 = Color3.fromRGB(200,50,50)
		NoButton.TextColor3 = Color3.new(1,1,1)
		NoButton.Parent = ConfirmFrame

		YesButton.MouseButton1Click:Connect(function()
			TweenService:Create(MainFrame,TweenInfo.new(0.3),{BackgroundTransparency=1}):Play()
			task.delay(0.3,function()
				ScreenGui:Destroy()
			end)
		end)
		NoButton.MouseButton1Click:Connect(function()
			TweenService:Create(ConfirmFrame,TweenInfo.new(0.2),{Size=UDim2.new(0,0,0,0)}):Play()
			task.delay(0.2,function() ConfirmFrame:Destroy() end)
		end)
	end

	CloseButton.MouseButton1Click:Connect(showUnloadConfirm)

	function window:CreateTab(arg)
		local tabName = typeof(arg)=="table" and arg.Name or arg
		local tab = {}
		local Button = Instance.new("TextButton")
		Button.Size = UDim2.new(1,-4,0,30)
		Button.Text = tabName
		Button.BackgroundColor3 = Color3.fromRGB(60,60,60)
		Button.TextColor3 = Color3.fromRGB(255,255,255)
		Button.AutoButtonColor = false
		Button.Parent = TabContainer
		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0,6)
		corner.Parent = Button

		local Page = Instance.new("ScrollingFrame")
		Page.Size = UDim2.new(1,0,1,0)
		Page.Visible = false
		Page.BackgroundTransparency = 1
		Page.ScrollBarThickness = 6
		Page.Parent = ContentContainer
		local Layout = Instance.new("UIListLayout")
		Layout.SortOrder = Enum.SortOrder.LayoutOrder
		Layout.Padding = UDim.new(0,5)
		Layout.Parent = Page

		Button.MouseButton1Click:Connect(function()
			if activePage then
				activePage.Visible = false
				TweenService:Create(activeButton,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(60,60,60)}):Play()
			end
			Page.Visible = true
			TweenService:Create(Button,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(100,100,100)}):Play()
			activePage = Page
			activeButton = Button
		end)
		if not activePage then
			Page.Visible = true
			Button.BackgroundColor3 = Color3.fromRGB(100,100,100)
			activePage = Page
			activeButton = Button
		end

		-- Components
		function tab:CreateButton(arg,callback)
			local text = typeof(arg)=="table" and arg.Text or arg
			local Btn = Instance.new("TextButton")
			Btn.Size = UDim2.new(0,200,0,30)
			Btn.Text = text
			Btn.BackgroundColor3 = Color3.fromRGB(70,70,70)
			Btn.TextColor3 = Color3.new(1,1,1)
			Btn.Parent = Page
			Btn.LayoutOrder = #Page:GetChildren()
			local corner = Instance.new("UICorner")
			corner.CornerRadius = UDim.new(0,6)
			corner.Parent = Btn
			Btn.MouseEnter:Connect(function()
				TweenService:Create(Btn,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(90,90,90)}):Play()
			end)
			Btn.MouseLeave:Connect(function()
				TweenService:Create(Btn,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(70,70,70)}):Play()
			end)
			Btn.MouseButton1Click:Connect(function()
				if callback then callback() end
			end)
		end

		function tab:CreateToggle(arg,default,callback)
			local text = typeof(arg)=="table" and arg.Text or arg
			local Toggle = Instance.new("TextButton")
			Toggle.Size = UDim2.new(0,200,0,30)
			Toggle.Text = text..": "..(default and "ON" or "OFF")
			Toggle.BackgroundColor3 = Color3.fromRGB(70,70,70)
			Toggle.TextColor3 = Color3.new(1,1,1)
			Toggle.Parent = Page
			Toggle.LayoutOrder = #Page:GetChildren()
			local corner = Instance.new("UICorner")
			corner.CornerRadius = UDim.new(0,6)
			corner.Parent = Toggle
			local state = default
			Toggle.MouseButton1Click:Connect(function()
				state = not state
				local newColor = state and Color3.fromRGB(50,200,50) or Color3.fromRGB(70,70,70)
				TweenService:Create(Toggle,TweenInfo.new(0.2),{BackgroundColor3=newColor}):Play()
				Toggle.Text = text..": "..(state and "ON" or "OFF")
				if callback then callback(state) end
			end)
		end

		function tab:CreateSlider(arg,min,max,default,callback)
			local text = typeof(arg)=="table" and arg.Text or arg
			local Container = Instance.new("Frame")
			Container.Size = UDim2.new(0,200,0,30)
			Container.BackgroundColor3 = Color3.fromRGB(70,70,70)
			Container.Parent = Page
			Container.LayoutOrder = #Page:GetChildren()
			local corner = Instance.new("UICorner")
			corner.CornerRadius = UDim.new(0,6)
			corner.Parent = Container

			local SliderValue = default
			local Label = Instance.new("TextLabel")
			Label.Size = UDim2.new(1,0,1,0)
			Label.BackgroundTransparency = 1
			Label.Text = text..": "..SliderValue
			Label.TextColor3 = Color3.new(1,1,1)
			Label.TextXAlignment = Enum.TextXAlignment.Left
			Label.Parent = Container

			local SliderBar = Instance.new("Frame")
			SliderBar.Size = UDim2.new((SliderValue-min)/(max-min),0,1,0)
			SliderBar.Position = UDim2.new(0,0,0,0)
			SliderBar.BackgroundColor3 = Color3.fromRGB(50,200,50)
			SliderBar.Parent = Container

			Container.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					local function moveSlider()
						local mouse = game.Players.LocalPlayer:GetMouse()
						local pos = math.clamp(mouse.X - Container.AbsolutePosition.X,0,Container.AbsoluteSize.X)
						SliderValue = math.floor(min + (pos/Container.AbsoluteSize.X)*(max-min))
						Label.Text = text..": "..SliderValue
						TweenService:Create(SliderBar,TweenInfo.new(0.1),{Size=UDim2.new(pos/Container.AbsoluteSize.X,0,1,0)}):Play()
						if callback then callback(SliderValue) end
					end
					local conn
					conn = UIS.InputChanged:Connect(function(input2)
						if input2.UserInputType == Enum.UserInputType.MouseMovement then moveSlider() end
					end)
					input.Changed:Connect(function()
						if input.UserInputState==Enum.UserInputState.End then conn:Disconnect() end
					end)
				end
			end)
		end

		function tab:CreateDropdown(arg,options,callback)
			local text = typeof(arg)=="table" and arg.Text or arg
			local Dropdown = Instance.new("TextButton")
			Dropdown.Size = UDim2.new(0,200,0,30)
			Dropdown.Text = text.." ▼"
			Dropdown.BackgroundColor3 = Color3.fromRGB(70,70,70)
			Dropdown.TextColor3 = Color3.new(1,1,1)
			Dropdown.Parent = Page
			Dropdown.LayoutOrder = #Page:GetChildren()
			local corner = Instance.new("UICorner")
			corner.CornerRadius = UDim.new(0,6)
			corner.Parent = Dropdown

			local Expanded = false
			local OptionContainer = Instance.new("Frame")
			OptionContainer.Size = UDim2.new(1,0,0,0)
			OptionContainer.Position = UDim2.new(0,0,1,0)
			OptionContainer.BackgroundColor3 = Color3.fromRGB(60,60,60)
			OptionContainer.ClipsDescendants = true
			OptionContainer.Parent = Dropdown

			local OptionLayout = Instance.new("UIListLayout")
			OptionLayout.SortOrder = Enum.SortOrder.LayoutOrder
			OptionLayout.Padding = UDim.new(0,2)
			OptionLayout.Parent = OptionContainer

			for i,opt in ipairs(options) do
				local OptionButton = Instance.new("TextButton")
				OptionButton.Size = UDim2.new(1,0,0,25)
				OptionButton.Text = opt
				OptionButton.BackgroundColor3 = Color3.fromRGB(80,80,80)
				OptionButton.TextColor3 = Color3.new(1,1,1)
				OptionButton.Parent = OptionContainer
				local corner = Instance.new("UICorner")
				corner.CornerRadius = UDim.new(0,4)
				corner.Parent = OptionButton
				OptionButton.MouseButton1Click:Connect(function()
					Dropdown.Text = text..": "..opt.." ▼"
					callback(opt)
					Expanded=false
					TweenService:Create(OptionContainer,TweenInfo.new(0.2),{Size=UDim2.new(1,0,0,0)}):Play()
				end)
			end

			Dropdown.MouseButton1Click:Connect(function()
				Expanded = not Expanded
				local newSize = Expanded and UDim2.new(1,0,#options*25,0) or UDim2.new(1,0,0,0)
				TweenService:Create(OptionContainer,TweenInfo.new(0.2),{Size=newSize}):Play()
			end)
		end

		function tab:CreateTextbox(arg,placeholder,callback)
			local text = typeof(arg)=="table" and arg.Text or arg
			local Box = Instance.new("TextBox")
			Box.Size = UDim2.new(0,200,0,30)
			Box.PlaceholderText = placeholder or ""
			Box.Text = ""
			Box.BackgroundColor3 = Color3.fromRGB(80,80,80)
			Box.TextColor3 = Color3.new(1,1,1)
			Box.Parent = Page
			Box.LayoutOrder = #Page:GetChildren()
			local corner = Instance.new("UICorner")
			corner.CornerRadius = UDim.new(0,6)
			corner.Parent = Box
			Box.FocusLost:Connect(function()
				if callback then callback(Box.Text) end
			end)
		end

		return tab
	end

	function window:Notify(title,msg,duration)
		local Notification = Instance.new("Frame")
		Notification.Size = UDim2.new(0,250,0,80)
		Notification.Position = UDim2.new(1,-260,1,-(#activeNotifications*90)-90)
		Notification.BackgroundColor3 = Color3.fromRGB(35,35,35)
		Notification.Parent = ScreenGui
		Notification.ZIndex = 1
		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0,8)
		corner.Parent = Notification
		Notification.BackgroundTransparency = 1
		TweenService:Create(Notification,TweenInfo.new(0.3),{BackgroundTransparency=0}):Play()

		local Title = Instance.new("TextLabel")
		Title.Size = UDim2.new(1,-10,0,20)
		Title.Position = UDim2.new(0,5,0,5)
		Title.BackgroundTransparency = 1
		Title.Text = title
		Title.TextColor3 = Color3.new(1,1,1)
		Title.Font = Enum.Font.SourceSansBold
		Title.TextSize = 16
		Title.Parent = Notification

		local Msg = Instance.new("TextLabel")
		Msg.Size = UDim2.new(1,-10,1,-30)
		Msg.Position = UDim2.new(0,5,0,25)
		Msg.BackgroundTransparency = 1
		Msg.Text = msg
		Msg.TextColor3 = Color3.new(1,1,1)
		Msg.Font = Enum.Font.SourceSans
		Msg.TextSize = 14
		Msg.TextWrapped = true
		Msg.Parent = Notification

		table.insert(activeNotifications,Notification)
		task.delay(duration or 3,function()
			TweenService:Create(Notification,TweenInfo.new(0.3),{BackgroundTransparency=1}):Play()
			task.delay(0.3,function()
				Notification:Destroy()
				table.remove(activeNotifications,1)
			end)
		end)
	end

	return window
end

return UILib

-- AdvancedScripter UI Library (Auto-Size + Animated + Modern)
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local TextService = game:GetService("TextService")

local UILib = {}
local activeNotifications = {}

function UILib:CreateWindow(arg1, arg2)
    local title = typeof(arg1) == "table" and arg1.Title or arg1 or "Window"
    local defaultSize = typeof(arg1) == "table" and arg1.Size or arg2 or UDim2.new(0, 400, 0, 300)

    local window = {}
    local player = game.Players.LocalPlayer
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = player:WaitForChild("PlayerGui")

    -- Main Window
    local MainFrame = Instance.new("Frame")
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, -defaultSize.X.Offset/2, 0.5, -defaultSize.Y.Offset/2)
    MainFrame.Size = defaultSize
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 10)
    MainCorner.Parent = MainFrame

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

    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 30, 1, 0)
    CloseButton.Position = UDim2.new(1, -30, 0, 0)
    CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.new(1, 1, 1)
    CloseButton.Parent = TitleBar
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 5)
    CloseCorner.Parent = CloseButton

    -- Tab Container
    local TabContainer = Instance.new("Frame")
    TabContainer.Size = UDim2.new(0, 120, 1, -30)
    TabContainer.Position = UDim2.new(0, 0, 0, 30)
    TabContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabContainer.Parent = MainFrame
    local TabLayout = Instance.new("UIListLayout")
    TabLayout.FillDirection = Enum.FillDirection.Vertical
    TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabLayout.Padding = UDim.new(0, 2)
    TabLayout.Parent = TabContainer

    -- Content Container
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Size = UDim2.new(1, -120, 1, -30)
    ContentContainer.Position = UDim2.new(0, 120, 0, 30)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Parent = MainFrame
    local ContentLayout = Instance.new("UIListLayout")
    ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ContentLayout.Padding = UDim.new(0, 5)
    ContentLayout.Parent = ContentContainer

    -- Auto-resize window based on content
    ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        local contentSize = ContentLayout.AbsoluteContentSize
        MainFrame.Size = UDim2.new(0, math.max(400, contentSize.X + 140), 0, math.max(300, contentSize.Y + 30))
    end)

    -- Unload Confirmation Popup
    local function showUnloadConfirm()
        local ConfirmFrame = Instance.new("Frame")
        ConfirmFrame.Size = UDim2.new(0, 250, 0, 120)
        ConfirmFrame.Position = UDim2.new(0.5, -125, 0.5, -60)
        ConfirmFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        ConfirmFrame.Parent = MainFrame
        ConfirmFrame.ZIndex = 10
        local ConfirmCorner = Instance.new("UICorner")
        ConfirmCorner.CornerRadius = UDim.new(0,8)
        ConfirmCorner.Parent = ConfirmFrame

        local ConfirmLabel = Instance.new("TextLabel")
        ConfirmLabel.Size = UDim2.new(1, -20, 0, 60)
        ConfirmLabel.Position = UDim2.new(0, 10, 0, 10)
        ConfirmLabel.BackgroundTransparency = 1
        ConfirmLabel.Text = "Do you really want to unload?"
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
        local YesCorner = Instance.new("UICorner")
        YesCorner.CornerRadius = UDim.new(0,5)
        YesCorner.Parent = YesButton

        local NoButton = Instance.new("TextButton")
        NoButton.Size = UDim2.new(0.5, -15, 0, 30)
        NoButton.Position = UDim2.new(0.5, 5, 1, -40)
        NoButton.Text = "No"
        NoButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        NoButton.TextColor3 = Color3.new(1,1,1)
        NoButton.ZIndex = 10
        NoButton.Parent = ConfirmFrame
        local NoCorner = Instance.new("UICorner")
        NoCorner.CornerRadius = UDim.new(0,5)
        NoCorner.Parent = NoButton

        YesButton.MouseButton1Click:Connect(function()
            ScreenGui:Destroy()
        end)

        NoButton.MouseButton1Click:Connect(function()
            TweenService:Create(ConfirmFrame, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
            task.delay(0.2, function()
                ConfirmFrame:Destroy()
            end)
        end)
    end

    CloseButton.MouseButton1Click:Connect(showUnloadConfirm)

    -- Tab System
    local activePage, activeButton
    function window:CreateTab(arg)
        local tabName = typeof(arg) == "table" and arg.Name or arg
        local tab = {}

        local Button = Instance.new("TextButton")
        local size = TextService:GetTextSize(tabName, 18, Enum.Font.SourceSansBold, Vector2.new(1000,30))
        Button.Size = UDim2.new(0, size.X + 20, 0, 30)
        Button.Text = tabName
        Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        Button.TextColor3 = Color3.new(1,1,1)
        Button.Parent = TabContainer
        local BtnCorner = Instance.new("UICorner")
        BtnCorner.CornerRadius = UDim.new(0,5)
        BtnCorner.Parent = Button

        local Page = Instance.new("ScrollingFrame")
        Page.Size = UDim2.new(1,0,1,0)
        Page.Visible = false
        Page.BackgroundTransparency = 1
        Page.ScrollBarThickness = 6
        Page.Parent = ContentContainer
        local PageLayout = Instance.new("UIListLayout")
        PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        PageLayout.Padding = UDim.new(0,5)
        PageLayout.Parent = Page

        Button.MouseButton1Click:Connect(function()
            if activePage then
                activePage.Visible = false
                activeButton.BackgroundColor3 = Color3.fromRGB(60,60,60)
            end
            Page.Visible = true
            Button.BackgroundColor3 = Color3.fromRGB(100,100,100)
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
        function tab:CreateButton(text, callback)
            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(1, -10, 0, 30)
            Btn.Text = text
            Btn.BackgroundColor3 = Color3.fromRGB(70,70,70)
            Btn.TextColor3 = Color3.new(1,1,1)
            Btn.Parent = Page
            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0,5)
            Corner.Parent = Btn
            Btn.MouseButton1Click:Connect(function()
                if callback then callback() end
            end)
        end

        function tab:CreateToggle(text, default, callback)
            local state = default
            local Toggle = Instance.new("TextButton")
            Toggle.Size = UDim2.new(1,-10,0,30)
            Toggle.Text = text..": "..(state and "ON" or "OFF")
            Toggle.BackgroundColor3 = Color3.fromRGB(70,70,70)
            Toggle.TextColor3 = Color3.new(1,1,1)
            Toggle.Parent = Page
            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0,5)
            Corner.Parent = Toggle
            Toggle.MouseButton1Click:Connect(function()
                state = not state
                Toggle.Text = text..": "..(state and "ON" or "OFF")
                if callback then callback(state) end
            end)
        end

        function tab:CreateSlider(text,min,max,default,callback)
            local value = default
            local SliderLabel = Instance.new("TextLabel")
            SliderLabel.Size = UDim2.new(1,-10,0,30)
            SliderLabel.BackgroundTransparency = 1
            SliderLabel.Text = text..": "..value
            SliderLabel.TextColor3 = Color3.new(1,1,1)
            SliderLabel.Font = Enum.Font.SourceSans
            SliderLabel.TextSize = 14
            SliderLabel.Parent = Page
            if callback then callback(value) end
        end

        function tab:CreateDropdown(text,options,callback)
            local Dropdown = Instance.new("TextButton")
            Dropdown.Size = UDim2.new(1,-10,0,30)
            Dropdown.Text = text.." ▼"
            Dropdown.BackgroundColor3 = Color3.fromRGB(70,70,70)
            Dropdown.TextColor3 = Color3.new(1,1,1)
            Dropdown.Parent = Page
            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0,5)
            Corner.Parent = Dropdown
            Dropdown.MouseButton1Click:Connect(function()
                if callback then callback(options[1]) end
            end)
        end

        function tab:CreateTextbox(text,placeholder,callback)
            local Box = Instance.new("TextBox")
            Box.Size = UDim2.new(1,-10,0,30)
            Box.PlaceholderText = placeholder or ""
            Box.BackgroundColor3 = Color3.fromRGB(80,80,80)
            Box.TextColor3 = Color3.new(1,1,1)
            Box.Parent = Page
            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0,5)
            Corner.Parent = Box
            Box.FocusLost:Connect(function()
                if callback then callback(Box.Text) end
            end)
        end

        return tab
    end

    function window:Notify(title,msg,duration)
        local Notification = Instance.new("Frame")
        Notification.BackgroundColor3 = Color3.fromRGB(35,35,35)
        Notification.Size = UDim2.new(0, 250,0,50)
        Notification.Position = UDim2.new(1,-260,1,-(#activeNotifications*90)-90)
        Notification.Parent = ScreenGui
        Notification.ZIndex = 10
        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0,8)
        Corner.Parent = Notification

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
        TweenService:Create(Notification,TweenInfo.new(0.3),{BackgroundTransparency=0}):Play()
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

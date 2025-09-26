# AdvancedScripter UI Library v6.0

**Description:**  
A Roblox UI library with old-school style, including tabs, animations, minimize functionality, stackable notifications, and unload confirmation. Version 6.0.

---

## Features

Load the library:

```lua
local UILib = loadstring(game:HttpGet("[https://example.com/](https://raw.githubusercontent.com/HacksCreator102/UILIB/refs/heads/main/source.lua)"))()
```

- **Window Creation**

```lua
local Window = UILib:CreateWindow({Title = "My Script", Size = UDim2.new(0, 500, 0, 350)})
```

- **Tabs**

```lua
local Tab = Window:CreateTab("Main")
```

- **Buttons**

```lua
Tab:CreateButton("Click Me", function()
    print("Button clicked!")
end)
```

- **Toggles**

```lua
Tab:CreateToggle("Toggle Option", true, function(state)
    print("Toggle is now", state)
end)
```

- **Sliders**

```lua
Tab:CreateSlider("Volume", 0, 100, 50, function(value)
    print("Slider value:", value)
end)
```

- **Dropdowns**

```lua
Tab:CreateDropdown("Choose Option", {"Option1", "Option2"}, function(selected)
    print("Selected:", selected)
end)
```

- **Textboxes**

```lua
Tab:CreateTextbox("Enter Text", "Placeholder...", function(text)
    print("Text entered:", text)
end)
```

- **Notifications**

```lua
Window:Notify("Title", "Message", 3) -- Duration optional, default 3 seconds
```

---

## Installation

1. Place `README.md` or `UILib.lua` in your project directory.
2. Require the library in a LocalScript:

```lua
local UILib = require(path.to.UILib)
local Window = UILib:CreateWindow({Title="My Script"})
```

---

## Notes

- Fully draggable windows with mini-button for minimized state.  
- Tabs support scrollable layouts and multiple UI components.  
- Notifications automatically stack at the bottom-right of the screen.  
- Compatible with Roblox LocalScripts and designed for ease of use.

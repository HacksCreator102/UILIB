# AdvancedScripter UI Library v7.1

**Description:**
A modern Roblox UI library with auto-sizing windows, animated tabs, draggable functionality, stackable notifications, and a sleek dark theme. All UI components auto-adjust their size based on content.

---

## Features

Load the library:

```lua
local UILib = loadstring(game:HttpGet("https://raw.githubusercontent.com/HacksCreator102/UILIB/refs/heads/main/source.lua"))()
```

* **Window Creation**

```lua
local Window = UILib:CreateWindow({Title = "My Script"})
```

* **Tabs**

```lua
local Tab = Window:CreateTab("Main")
```

* **Buttons**

```lua
Tab:CreateButton("Click Me", function()
    print("Button clicked!")
end)
```

* **Toggles**

```lua
Tab:CreateToggle("Toggle Option", true, function(state)
    print("Toggle is now", state)
end)
```

* **Sliders**

```lua
Tab:CreateSlider("Volume", 0, 100, 50, function(value)
    print("Slider value:", value)
end)
```

* **Dropdowns**

```lua
Tab:CreateDropdown("Choose Option", {"Option1", "Option2"}, function(selected)
    print("Selected:", selected)
end)
```

* **Textboxes**

```lua
Tab:CreateTextbox("Enter Text", "Type here...", function(text)
    print("Text entered:", text)
end)
```

* **Notifications (Auto-Size)**

```lua
Window:Notify("Title", "Message", 3) -- Duration optional, default 3 seconds
```

---

## Advanced Features

* **Auto-sizing Window**: Resizes dynamically based on content inside tabs.
* **Animated Tab Switching**: Only one tab visible at a time; smooth color transition.
* **Auto-sizing Tabs and Components**: Buttons, toggles, sliders, dropdowns, textboxes fit content width.
* **Stackable Notifications**: Auto-size based on text length and wrap if needed; fade in/out.
* **Unload Confirmation Popup**: Animated and interactive.
* **Draggable Window** with Rounded Corners and Modern Dark Theme.

---

## Installation

1. Place `UILib.lua` in your project directory or use the raw GitHub link.
2. Require the library in a LocalScript:

```lua
local UILib = loadstring(game:HttpGet("https://raw.githubusercontent.com/HacksCreator102/UILIB/refs/heads/main/source.lua"))()
local Window = UILib:CreateWindow({Title = "My Script"})
```

---

## Notes

* Fully animated and responsive UI.
* Components and notifications automatically size to fit content.
* Designed for **ease of use** in Roblox LocalScripts.
* Compatible with **modern dark-themed projects**.

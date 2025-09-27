# AdvancedScripter UI Library

A **modern, animated, auto-sizing UI library** for Roblox, featuring full executor settings management, notifications, tabs, and interactive UI components.

---

## Features

* **Executor Settings Manager**

  * Load and save persistent settings (`keybind`, `antiafk`, etc.) across sessions.
  * Automatically creates a `Creator.txt` with script credits.
* **Window & Tabs**

  * Draggable, animated main window.
  * Multi-tab system with automatic active tab highlighting.
* **Auto-Resizing**

  * Window automatically adjusts to content size.
* **UI Components**

  * **Buttons**
  * **Toggles**
  * **Sliders**
  * **Dropdowns**
  * **Textboxes**
* **Notifications**

  * Stackable notifications with smooth animations.

---

## Installation

1. Place `UILib.lua` in your Roblox executor scripts folder.
2. Load it via:

```lua
local UILib = loadstring(game:HttpGet("https://raw.githubusercontent.com/HacksCreator102/UILIB/refs/heads/main/source.lua"))()
```

---

## Example Usage

```lua
local UILib = require(path_to_UILib)

local Window = UILib:CreateWindow({Title = "My Script"})

-- Create tabs
local HomeTab = Window:CreateTab("Home")
local AutoTab = Window:CreateTab("Auto")

-- Add components
HomeTab:CreateButton("Click Me", function()
    print("Button clicked!")
end)

HomeTab:CreateToggle("Anti-AFK", Window.Settings.antiafk, function(state)
    Window.Settings.antiafk = state
    Window.SaveSettings(Window.Settings)
end)

HomeTab:CreateSlider("Speed", 1, 500, 100, function(value)
    print("Slider value:", value)
end)

AutoTab:CreateDropdown("Select Option", {"A","B","C"}, function(option)
    print("Selected:", option)
end)

AutoTab:CreateTextbox("Enter Name", "Player Name", function(text)
    print("Textbox:", text)
end)

-- Notifications
Window:Notify("Hello!", "This is a test notification.", 5)
```

---

## Settings Persistence

All toggles, sliders, and keybinds automatically save and load between sessions via the Executor Settings Manager.

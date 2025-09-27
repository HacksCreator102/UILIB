# AdvancedScripter UI Library v7.1

**Description:**
A modern Roblox UI library with animated tabs, draggable windows, stackable notifications, and a sleek dark theme. Includes all common UI components: buttons, toggles, sliders, dropdowns, textboxes, and unload confirmation.

---

## Features

Load the library:

```lua
local UILib = loadstring(game:HttpGet("https://raw.githubusercontent.com/HacksCreator102/UILIB/refs/heads/main/source.lua"))()
```

* **Window Creation**

```lua
local Window = UILib:CreateWindow({
    Title = "My Script",
    Size = UDim2.new(0, 500, 0, 350)
})
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

* **Notifications**

```lua
Window:Notify("Title", "Message", 3) -- Duration optional, default 3 seconds
```

---

## Advanced Features

* **Modern Dark Theme** with rounded corners and smooth animations.
* **Animated Tab Switching**: only one tab visible at a time, buttons animate color on hover.
* **Animated Dropdowns and Sliders**: sliders update in real-time, dropdowns expand/collapse smoothly.
* **Draggable Window** with **Unload Confirmation Popup** that animates in/out.
* **Stackable Notifications**: multiple notifications appear without overlap, fade in/out automatically.

---

## Installation

1. Place `UILib.lua` in your project directory (or use the raw GitHub link).
2. Require the library in a LocalScript:

```lua
local UILib = loadstring(game:HttpGet("https://raw.githubusercontent.com/HacksCreator102/UILIB/refs/heads/main/source.lua"))()
local Window = UILib:CreateWindow({Title = "My Script"})
```

---

## Notes

* Fully animated and responsive for a polished UI experience.
* Tabs, sliders, toggles, and dropdowns are all **interactive with smooth animations**.
* Notifications fade in/out and stack at the bottom-right corner.
* Designed for **ease of use** in Roblox LocalScripts.

-- Custom Roblox Script GUI
-- Modified from Linoria Library example
local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Options = Library.Options
local Toggles = Library.Toggles

Library.ForceCheckbox = false
Library.ShowToggleFrameInKeybinds = true

local Window = Library:CreateWindow({
	Title = "Custom Script",
	Footer = "version: 1.0",
	Icon = 95816097006870,
	NotifySide = "Right",
	ShowCustomCursor = true,
})

-- Create tabs
local Tabs = {
	Combat = Window:AddTab("Combat", "sword"),
	Visual = Window:AddTab("Visual", "eye"),
	["UI Settings"] = Window:AddTab("UI Settings", "settings"),
}

-- Combat Tab
local CombatGroupBox = Tabs.Combat:AddLeftGroupbox("Combat Features", "sword")
CombatGroupBox:AddLabel("Combat features will be added here")

-- Visual Tab
local VisualGroupBox = Tabs.Visual:AddLeftGroupbox("Visual Features", "eye")

-- Show Health Bar Button
VisualGroupBox:AddButton({
	Text = "Show Health Bar",
	Tooltip = "Loads ESP script to show player health bars",
	
	Func = function()
		-- Load the ESP script from GitHub
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Eazvy/UILibs/refs/heads/main/ESP/XCT/Example"))()
		
		-- Show notification
		Library:Notify({
			Title = "ESP Loaded",
			Description = "Health Bar ESP has been loaded successfully!",
			Time = 3,
		})
	end,
})

-- UI Settings
local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("Menu", "wrench")

MenuGroup:AddToggle("KeybindMenuOpen", {
	Default = Library.KeybindFrame.Visible,
	Text = "Open Keybind Menu",
	Callback = function(value)
		Library.KeybindFrame.Visible = value
	end,
})

MenuGroup:AddToggle("ShowCustomCursor", {
	Text = "Custom Cursor",
	Default = true,
	Callback = function(Value)
		Library.ShowCustomCursor = Value
	end,
})

MenuGroup:AddDropdown("NotificationSide", {
	Values = { "Left", "Right" },
	Default = "Right",
	Text = "Notification Side",
	Callback = function(Value)
		Library:SetNotifySide(Value)
	end,
})

MenuGroup:AddDropdown("DPIDropdown", {
	Values = { "50%", "75%", "100%", "125%", "150%", "175%", "200%" },
	Default = "100%",
	Text = "DPI Scale",
	Callback = function(Value)
		Value = Value:gsub("%%", "")
		local DPI = tonumber(Value)
		Library:SetDPIScale(DPI)
	end,
})

MenuGroup:AddDivider()
MenuGroup:AddLabel("Menu bind")
	:AddKeyPicker("MenuKeybind", { Default = "RightShift", NoUI = true, Text = "Menu keybind" })

MenuGroup:AddButton("Unload", function()
	Library:Unload()
end)

-- ВАЖНО: Эта строка связывает кейбинд с библиотекой
Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu

-- Library cleanup
Library:OnUnload(function()
	print("Script unloaded!")
end)

-- Setup managers
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- Adds our MenuKeybind to the ignore list
-- (do you want each config to have a different menu key? probably not.)
SaveManager:SetIgnoreIndexes({ "MenuKeybind" })

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
ThemeManager:SetFolder("CustomScript")
SaveManager:SetFolder("CustomScript/settings")

-- Builds our config menu on the right side of our tab
SaveManager:BuildConfigSection(Tabs["UI Settings"])

-- Builds our theme menu (with plenty of built in themes) on the left side
-- NOTE: you can also call ThemeManager:ApplyToGroupbox to add it to a specific groupbox
ThemeManager:ApplyToTab(Tabs["UI Settings"])

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()

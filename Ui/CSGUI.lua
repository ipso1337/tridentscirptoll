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

-- Variables to track loaded scripts
local currentESP = nil

-- Add the dropdown with none, corner, 3d options
VisualGroupBox:AddDropdown("ViewModeDropdown", {
	Values = { "none", "corner", "3d" },
	Default = 1, -- defaults to "none"
	Multi = false,
	
	Text = "View Mode",
	Tooltip = "Select the view mode for visual features",
	
	Callback = function(Value)
		print("[cb] View Mode changed to:", Value)
		
		-- Handle different modes
		if Value == "none" then
			-- Disable any active ESP
			if _G.DisableBoxESP then
				_G.DisableBoxESP()
			end
			if _G.DisableCornerESP then
				_G.DisableCornerESP()
			end
			currentESP = nil
			Library:Notify({
				Title = "View Mode",
				Description = "ESP disabled - None mode active",
				Time = 2,
			})
			
		elseif Value == "corner" then
			-- Disable 3D ESP first
			if _G.DisableBoxESP then
				_G.DisableBoxESP()
			end
			-- Load corner ESP script
			pcall(function()
				loadstring(game:HttpGet("https://raw.githubusercontent.com/ipso1337/tridentscirptoll/refs/heads/main/function/visual/Corner"))()
				-- Enable corner ESP after loading
				if _G.EnableCornerESP then
					_G.EnableCornerESP()
				end
				currentESP = "corner"
			end)
			Library:Notify({
				Title = "View Mode",
				Description = "Corner ESP loaded successfully!",
				Time = 2,
			})
			
		elseif Value == "3d" then
			-- Disable corner ESP first
			if _G.DisableCornerESP then
				_G.DisableCornerESP()
			end
			-- Load 3D ESP script
			pcall(function()
				loadstring(game:HttpGet("https://raw.githubusercontent.com/ipso1337/tridentscirptoll/refs/heads/main/function/visual/3D"))()
				-- Enable the ESP after loading
				if _G.EnableBoxESP then
					_G.EnableBoxESP()
				end
				currentESP = "3d"
			end)
			Library:Notify({
				Title = "View Mode",
				Description = "3D ESP loaded successfully!",
				Time = 2,
			})
		end
	end,
})

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

-- You can access the dropdown value later with:
-- Options.ViewModeDropdown.Value

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

MenuGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", { 
	Default = "RightShift", 
	NoUI = true, 
	Text = "Menu keybind" 
})

MenuGroup:AddButton("Unload", function()
	-- Clean up any active ESP before unloading
	if _G.CleanupBoxESP then
		_G.CleanupBoxESP()
	end
	if _G.CleanupCornerESP then
		_G.CleanupCornerESP()
	end
	Library:Unload()
end)

Library.ToggleKeybind = Options.MenuKeybind

-- Library cleanup
Library:OnUnload(function()
	-- Clean up any active ESP
	if _G.CleanupBoxESP then
		_G.CleanupBoxESP()
	end
	if _G.CleanupCornerESP then
		_G.CleanupCornerESP()
	end
	print("Script unloaded!")
end)

-- Setup managers
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ "MenuKeybind" })

ThemeManager:SetFolder("CustomScript")
SaveManager:SetFolder("CustomScript/settings")

SaveManager:BuildConfigSection(Tabs["UI Settings"])
ThemeManager:ApplyToTab(Tabs["UI Settings"])

SaveManager:LoadAutoloadConfig()

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

local Tabs = {
	Combat = Window:AddTab("Combat", "sword"),
	Visual = Window:AddTab("Visual", "eye"),
	["UI Settings"] = Window:AddTab("UI Settings", "settings"),
}

local CombatGroupBox = Tabs.Combat:AddLeftGroupbox("Combat Features", "sword")

local currentESP = nil
local currentWatermark = nil
local currentSpinbot = nil

CombatGroupBox:AddToggle("VisualSpinbotToggle", {
	Default = false,
	Text = "Visual Spinbot",
	Tooltip = "Toggle visual spinbot on/off",
	
	Callback = function(Value)
		print("[cb] Visual Spinbot toggled:", Value)
		
		if Value then
			if not currentSpinbot then
				pcall(function()
					loadstring(game:HttpGet("https://raw.githubusercontent.com/ipso1337/tridentscirptoll/refs/heads/main/function/combat/visualSpinbot"))()
					currentSpinbot = "loaded"
				end)
			end
			
			if _G.EnableVisualSpinbot then
				_G.EnableVisualSpinbot()
			end
			
			Library:Notify({
				Title = "Visual Spinbot",
				Description = "Visual Spinbot enabled successfully!",
				Time = 2,
			})
		else
			if _G.DisableVisualSpinbot then
				_G.DisableVisualSpinbot()
			end
			
			Library:Notify({
				Title = "Visual Spinbot",
				Description = "Visual Spinbot disabled",
				Time = 2,
			})
		end
	end,
})

CombatGroupBox:AddSlider("CombatSpeed", {
	Text = "Combat Speed",
	Default = 50,
	Min = 1,
	Max = 100,
	Rounding = 0,
	Compact = false,

	Callback = function(Value)
		print("[cb] Combat Speed changed to:", Value)
	end,

	Tooltip = "Adjust combat speed (placeholder)",
})

CombatGroupBox:AddSlider("DamageMultiplier", {
	Text = "Damage Multiplier",
	Default = 1.0,
	Min = 0.1,
	Max = 5.0,
	Rounding = 1,
	Compact = false,

	Callback = function(Value)
		print("[cb] Damage Multiplier changed to:", Value)
	end,

	Tooltip = "Adjust damage multiplier (placeholder)",
})

CombatGroupBox:AddSlider("AttackRange", {
	Text = "Attack Range",
	Default = 10,
	Min = 5,
	Max = 50,
	Rounding = 0,
	Compact = false,

	Callback = function(Value)
		print("[cb] Attack Range changed to:", Value)
	end,

	Tooltip = "Adjust attack range (placeholder)",
})

CombatGroupBox:AddDropdown("CombatModeDropdown", {
	Values = { "Aggressive", "Defensive", "Balanced", "Stealth" },
	Default = 3,
	Multi = false,
	
	Text = "Combat Mode",
	Tooltip = "Select combat behavior mode (placeholder)",
	
	Callback = function(Value)
		print("[cb] Combat Mode changed to:", Value)
	end,
})

CombatGroupBox:AddLabel("Combat Hotkey"):AddKeyPicker("CombatKeybind", {
	Default = "F",
	Mode = "Toggle",
	Text = "Combat Toggle",
	NoUI = false,

	Callback = function(Value)
		print("[cb] Combat keybind pressed:", Value)
	end,

	ChangedCallback = function(New)
		print("[cb] Combat keybind changed to:", New)
	end,

	Tooltip = "Keybind for combat features (placeholder)",
})

local VisualGroupBox = Tabs.Visual:AddLeftGroupbox("Visual Features", "eye")

VisualGroupBox:AddDropdown("ViewModeDropdown", {
	Values = { "none", "corner", "3d" },
	Default = 1,
	Multi = false,
	
	Text = "View Mode",
	Tooltip = "Select the view mode for visual features",
	
	Callback = function(Value)
		print("[cb] View Mode changed to:", Value)
		
		if Value == "none" then
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
			if _G.DisableBoxESP then
				_G.DisableBoxESP()
			end
			pcall(function()
				loadstring(game:HttpGet("https://raw.githubusercontent.com/ipso1337/tridentscirptoll/refs/heads/main/function/visual/Corner"))()
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
			if _G.DisableCornerESP then
				_G.DisableCornerESP()
			end
			pcall(function()
				loadstring(game:HttpGet("https://raw.githubusercontent.com/ipso1337/tridentscirptoll/refs/heads/main/function/visual/3D"))()
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

VisualGroupBox:AddToggle("WatermarkToggle", {
	Default = false,
	Text = "Show Watermark",
	Tooltip = "Toggle watermark visibility",
	
	Callback = function(Value)
		print("[cb] Watermark toggled:", Value)
		
		if Value then
			if not currentWatermark then
				pcall(function()
					loadstring(game:HttpGet("https://raw.githubusercontent.com/ipso1337/tridentscirptoll/refs/heads/main/function/visual/Watermark"))()
					currentWatermark = "loaded"
				end)
			end
			
			if _G.EnableWatermark then
				_G.EnableWatermark()
			end
			
			Library:Notify({
				Title = "Watermark",
				Description = "Watermark enabled successfully!",
				Time = 2,
			})
		else
			if _G.DisableWatermark then
				_G.DisableWatermark()
			end
			
			Library:Notify({
				Title = "Watermark",
				Description = "Watermark disabled",
				Time = 2,
			})
		end
	end,
})

VisualGroupBox:AddButton({
	Text = "Show Health Bar",
	Tooltip = "Loads ESP script to show player health bars",
	
	Func = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Eazvy/UILibs/refs/heads/main/ESP/XCT/Example"))()
		
		Library:Notify({
			Title = "ESP Loaded",
			Description = "Health Bar ESP has been loaded successfully!",
			Time = 3,
		})
	end,
})

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
	if _G.CleanupBoxESP then
		_G.CleanupBoxESP()
	end
	if _G.CleanupCornerESP then
		_G.CleanupCornerESP()
	end
	if _G.CleanupWatermark then
		_G.CleanupWatermark()
	end
	if _G.CleanupVisualSpinbot then
		_G.CleanupVisualSpinbot()
	end
	Library:Unload()
end)

Library.ToggleKeybind = Options.MenuKeybind

Library:OnUnload(function()
	if _G.CleanupBoxESP then
		_G.CleanupBoxESP()
	end
	if _G.CleanupCornerESP then
		_G.CleanupCornerESP()
	end
	if _G.CleanupWatermark then
		_G.CleanupWatermark()
	end
	if _G.CleanupVisualSpinbot then
		_G.CleanupVisualSpinbot()
	end
	print("Script unloaded!")
end)

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ "MenuKeybind" })

ThemeManager:SetFolder("CustomScript")
SaveManager:SetFolder("CustomScript/settings")

SaveManager:BuildConfigSection(Tabs["UI Settings"])
ThemeManager:ApplyToTab(Tabs["UI Settings"])

SaveManager:LoadAutoloadConfig()

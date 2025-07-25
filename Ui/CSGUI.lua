local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()
local Options = Library.Options
local Toggles = Library.Toggles

Library.ForceCheckbox = false
Library.ShowToggleFrameInKeybinds = true

-- Global sleep check setting that affects all features
_G.GlobalSleepCheck = true

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
	Misc = Window:AddTab("Misc", "tool"),
	["UI Settings"] = Window:AddTab("UI Settings", "settings"),
}

local CombatGroupBox = Tabs.Combat:AddLeftGroupbox("Combat Features", "sword")

CombatGroupBox:AddLabel("Hitbox Expander")

CombatGroupBox:AddToggle("HitboxToggle", {
	Default = false,
	Text = "Enable Hitbox Expander",
	Tooltip = "Expands player hitboxes for easier targeting",

	Callback = function(Value)
		if Value then
			local success, err = pcall(function()
				loadstring(game:HttpGet("https://raw.githubusercontent.com/ipso1337/tridentscirptoll/refs/heads/main/function/combat/hitbox"))()
				if _G.EnableHitboxExpander then 
					_G.EnableHitboxExpander() 
				end
				-- Apply global sleep check setting
				if _G.SetHitboxSleepCheck then 
					_G.SetHitboxSleepCheck(_G.GlobalSleepCheck) 
				end
			end)
			if success then
				Library:Notify({ Title = "Hitbox Expander", Description = "Hitbox Expander enabled!", Time = 2 })
			else
				Library:Notify({ Title = "Hitbox Expander", Description = "Failed to load Hitbox Expander: " .. tostring(err), Time = 3 })
			end
		else
			if _G.DisableHitboxExpander then 
				_G.DisableHitboxExpander() 
			end
			Library:Notify({ Title = "Hitbox Expander", Description = "Hitbox Expander disabled", Time = 2 })
		end
	end,
})

CombatGroupBox:AddSlider("HitboxSize", {
	Text = "Hitbox Size",
	Default = 10,
	Min = 1,
	Max = 20,
	Rounding = 1,
	Callback = function(Value)
		if _G.SetHitboxSize then 
			_G.SetHitboxSize(Value) 
		end
	end,
})

CombatGroupBox:AddSlider("HitboxTransparency", {
	Text = "Transparency",
	Default = 50,
	Min = 0,
	Max = 100,
	Rounding = 0,
	Callback = function(Value)
		if _G.SetHitboxTransparency then 
			_G.SetHitboxTransparency(Value / 100) 
		end
	end,
})

CombatGroupBox:AddToggle("HitboxCanCollide", {
	Default = false,
	Text = "Can Collide",
	Tooltip = "Whether hitboxes can be collided with",

	Callback = function(Value)
		if _G.SetHitboxCanCollide then 
			_G.SetHitboxCanCollide(Value) 
		end
	end,
})

CombatGroupBox:AddDropdown("HitboxPart", {
	Values = { "Head", "Torso", "LowerTorso", "UpperTorso", "HumanoidRootPart", "LeftUpperArm", "RightUpperArm", "LeftLowerArm", "RightLowerArm", "LeftHand", "RightHand", "LeftUpperLeg", "RightUpperLeg", "LeftLowerLeg", "RightLowerLeg", "LeftFoot", "RightFoot" },
	Default = 1,
	Multi = false,
	Text = "Target Part",
	Callback = function(Value)
		if _G.SetHitboxTargetPart then 
			_G.SetHitboxTargetPart(Value) 
		end
	end,
})

CombatGroupBox:AddLabel("Long Neck")

local LongNeckToggle = CombatGroupBox:AddToggle("LongNeckToggle", {
	Default = false,
	Text = "Enable Long Neck",
	Tooltip = "Extends neck reach for better targeting",

	Callback = function(Value)
		if Value then
			local success, err = pcall(function()
				loadstring(game:HttpGet("https://raw.githubusercontent.com/ipso1337/tridentscirptoll/refs/heads/main/function/combat/longneck"))()
				if _G.EnableLongNeck then 
					_G.EnableLongNeck() 
				end
				-- Apply global sleep check setting
				if _G.SetLongNeckSleepCheck then 
					_G.SetLongNeckSleepCheck(_G.GlobalSleepCheck) 
				end
			end)
			if success then
				Library:Notify({ Title = "Long Neck", Description = "Long Neck enabled!", Time = 2 })
			else
				Library:Notify({ Title = "Long Neck", Description = "Failed to load Long Neck: " .. tostring(err), Time = 3 })
			end
		else
			if _G.DisableLongNeck then 
				_G.DisableLongNeck() 
			end
			Library:Notify({ Title = "Long Neck", Description = "Long Neck disabled", Time = 2 })
		end
	end,
})

local LongNeckKeybind = LongNeckToggle:AddKeyPicker("LongNeckKeybind", {
	Default = "F",
	Text = "Long Neck Keybind",
	Mode = "Toggle",
	SyncToggleState = true,
	Callback = function(Value)
		print("Long Neck keybind pressed, value:", Value)
	end
})

local VisualGroupBox = Tabs.Visual:AddLeftGroupbox("Visual Features", "eye")

VisualGroupBox:AddDropdown("ViewModeDropdown", {
	Values = { "none", "corner", "3d" },
	Default = 1,
	Multi = false,
	Text = "View Mode",
	Tooltip = "Select the view mode for visual features",

	Callback = function(Value)
		if Value == "none" then
			if _G.DisableBoxESP then 
				_G.DisableBoxESP() 
			end
			if _G.DisableCornerESP then 
				_G.DisableCornerESP() 
			end
			Library:Notify({ Title = "View Mode", Description = "ESP disabled - None mode", Time = 2 })
		elseif Value == "corner" then
			if _G.DisableBoxESP then 
				_G.DisableBoxESP() 
			end
			local success, err = pcall(function()
				loadstring(game:HttpGet("https://raw.githubusercontent.com/ipso1337/tridentscirptoll/refs/heads/main/function/visual/Corner"))()
				if _G.EnableCornerESP then 
					_G.EnableCornerESP() 
				end
				-- Apply global sleep check setting
				if _G.SetCornerESPSleepCheck then 
					_G.SetCornerESPSleepCheck(_G.GlobalSleepCheck) 
				end
			end)
			if success then
				Library:Notify({ Title = "View Mode", Description = "Corner ESP loaded", Time = 2 })
			else
				Library:Notify({ Title = "View Mode", Description = "Failed to load Corner ESP: " .. tostring(err), Time = 3 })
			end
		elseif Value == "3d" then
			if _G.DisableCornerESP then 
				_G.DisableCornerESP() 
			end
			local success, err = pcall(function()
				loadstring(game:HttpGet("https://raw.githubusercontent.com/ipso1337/tridentscirptoll/refs/heads/main/function/visual/3D"))()
				if _G.EnableBoxESP then 
					_G.EnableBoxESP() 
				end
				-- Apply global sleep check setting
				if _G.SetBoxESPSleepCheck then 
					_G.SetBoxESPSleepCheck(_G.GlobalSleepCheck) 
				end
			end)
			if success then
				Library:Notify({ Title = "View Mode", Description = "3D ESP loaded", Time = 2 })
			else
				Library:Notify({ Title = "View Mode", Description = "Failed to load 3D ESP: " .. tostring(err), Time = 3 })
			end
		end
	end,
})

VisualGroupBox:AddToggle("NametagToggle", {
	Default = false,
	Text = "Enable Nametag",
	Tooltip = "Show player nametags with health bars",

	Callback = function(Value)
		if Value then
			local success, err = pcall(function()
				loadstring(game:HttpGet("https://raw.githubusercontent.com/ipso1337/tridentscirptoll/refs/heads/main/function/visual/nametag"))()
				if _G.EnableNametags then 
					_G.EnableNametags() 
				end
				-- Apply global sleep check setting
				if _G.SetNametagsSleepCheck then 
					_G.SetNametagsSleepCheck(_G.GlobalSleepCheck) 
				end
			end)
			if success then
				Library:Notify({ Title = "Nametag", Description = "Nametag enabled!", Time = 2 })
			else
				Library:Notify({ Title = "Nametag", Description = "Failed to load Nametag: " .. tostring(err), Time = 3 })
			end
		else
			if _G.DisableNametags then 
				_G.DisableNametags() 
			end
			Library:Notify({ Title = "Nametag", Description = "Nametag disabled", Time = 2 })
		end
	end,
})

VisualGroupBox:AddToggle("SleepCheckToggle", {
	Default = true,
	Text = "Show Sleepers",
	Tooltip = "Show ESP and features for sleeping players (affects ALL features including combat)",

	Callback = function(Value)
		_G.GlobalSleepCheck = not Value -- Inverted logic: Show Sleepers = true means don't hide sleepers
		
		-- Update all individual feature sleep checks
		if _G.SetNametagsSleepCheck then 
			_G.SetNametagsSleepCheck(not Value) 
		end
		if _G.SetCornerESPSleepCheck then 
			_G.SetCornerESPSleepCheck(not Value) 
		end
		if _G.SetBoxESPSleepCheck then 
			_G.SetBoxESPSleepCheck(not Value) 
		end
		
		Library:Notify({ 
			Title = "Show Sleepers", 
			Description = Value and "Sleepers will be shown in ALL features" or "Sleepers will be hidden in ALL features", 
			Time = 2 
		})
	end,
})

VisualGroupBox:AddToggle("ShowWeaponsToggle", {
	Default = false,
	Text = "Show Weapons",
	Tooltip = "Display equipped weapons in nametags",

	Callback = function(Value)
		if _G.SetNametagsShowWeapons then 
			_G.SetNametagsShowWeapons(Value) 
		end
		Library:Notify({ 
			Title = "Show Weapons", 
			Description = Value and "Show Weapons enabled" or "Show Weapons disabled", 
			Time = 2 
		})
	end,
})

VisualGroupBox:AddToggle("WatermarkToggle", {
	Default = false,
	Text = "Show Watermark",
	Tooltip = "Toggle watermark visibility",

	Callback = function(Value)
		if Value then
			if not _G.WatermarkLoaded then
				local success, err = pcall(function()
					loadstring(game:HttpGet("https://raw.githubusercontent.com/ipso1337/tridentscirptoll/refs/heads/main/function/visual/Watermark"))()
					_G.WatermarkLoaded = true
				end)
				if not success then
					Library:Notify({ Title = "Watermark", Description = "Failed to load Watermark: " .. tostring(err), Time = 3 })
					return
				end
			end
			if _G.EnableWatermark then 
				_G.EnableWatermark() 
			end
			-- Apply global sleep check setting
			if _G.SetWatermarkSleepCheck then 
				_G.SetWatermarkSleepCheck(_G.GlobalSleepCheck) 
			end
			Library:Notify({ Title = "Watermark", Description = "Watermark enabled!", Time = 2 })
		else
			if _G.DisableWatermark then 
				_G.DisableWatermark() 
			end
			Library:Notify({ Title = "Watermark", Description = "Watermark disabled", Time = 2 })
		end
	end,
})

local MiscGroupBox = Tabs.Misc:AddLeftGroupbox("Misc Features", "tool")

MiscGroupBox:AddLabel("BeterSlide System")

MiscGroupBox:AddToggle("BeterSlideToggle", {
	Default = false,
	Text = "Enable BeterSlide",
	Tooltip = "Enable better sliding mechanics (Hold C + LeftShift to slide)",

	Callback = function(Value)
		if Value then
			local success, err = pcall(function()
				loadstring(game:HttpGet("https://raw.githubusercontent.com/ipso1337/tridentscirptoll/refs/heads/main/function/misc/beterslide"))()
				if _G.EnableBeterSlide then 
					_G.EnableBeterSlide() 
				end
				-- Apply global sleep check setting
				if _G.SetBeterSlideSleepCheck then 
					_G.SetBeterSlideSleepCheck(_G.GlobalSleepCheck) 
				end
			end)
			if success then
				Library:Notify({ Title = "BeterSlide", Description = "BeterSlide enabled! Use C + LeftShift to slide", Time = 3 })
			else
				Library:Notify({ Title = "BeterSlide", Description = "Failed to load BeterSlide: " .. tostring(err), Time = 3 })
			end
		else
			if _G.DisableBeterSlide then 
				_G.DisableBeterSlide() 
			end
			Library:Notify({ Title = "BeterSlide", Description = "BeterSlide disabled", Time = 2 })
		end
	end,
})

MiscGroupBox:AddSlider("SlideSpeed", {
	Text = "Slide Speed",
	Default = 55,
	Min = 55,
	Max = 70,
	Rounding = 0,
	Suffix = " sps",
	Callback = function(Value)
		if _G.SetSlideSpeed then 
			_G.SetSlideSpeed(Value) 
		end
	end,
})

MiscGroupBox:AddToggle("ForcesprintToggle", {
	Default = false,
	Text = "Forcesprint",
	Tooltip = "Enable forced sprinting when not sliding",

	Callback = function(Value)
		if _G.SetForcesprint then 
			_G.SetForcesprint(Value) 
		end
		Library:Notify({ 
			Title = "Forcesprint", 
			Description = Value and "Forcesprint enabled" or "Forcesprint disabled", 
			Time = 2 
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
		local DPI = tonumber(Value:gsub("%%", ""))
		if DPI then
			Library:SetDPIScale(DPI)
		end
	end,
})

MenuGroup:AddDivider()
MenuGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", {
	Default = "RightShift",
	NoUI = true,
	Text = "Menu keybind"
})

MenuGroup:AddButton({
	Text = "Unload",
	Func = function()
		local cleanupFunctions = {
			"CleanupBoxESP",
			"CleanupCornerESP", 
			"CleanupWatermark",
			"CleanupVisualSpinbot",
			"CleanupHitboxExpander",
			"CleanupBeterSlide",
			"CleanupLongNeck",
			"CleanupNametags"
		}
		
		for _, funcName in ipairs(cleanupFunctions) do
			if _G[funcName] then 
				pcall(_G[funcName])
			end
		end
		
		Library:Unload()
	end,
})

Library.ToggleKeybind = Options.MenuKeybind

Library:OnUnload(function()
	local cleanupFunctions = {
		"CleanupBoxESP",
		"CleanupCornerESP", 
		"CleanupWatermark",
		"CleanupVisualSpinbot",
		"CleanupHitboxExpander",
		"CleanupBeterSlide",
		"CleanupLongNeck",
		"CleanupNametags"
	}
	
	for _, funcName in ipairs(cleanupFunctions) do
		if _G[funcName] then 
			pcall(_G[funcName])
		end
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

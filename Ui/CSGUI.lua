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

-- Aimbot
CombatGroupBox:AddToggle("AimbotToggle", {
	Default = false,
	Text = "Enable Aimbot",
	Tooltip = "Toggle aimbot on or off",

	Callback = function(Value)
		if Value then
			local success, err = pcall(function()
				loadstring(game:HttpGet("https://raw.githubusercontent.com/ipso1337/tridentscirptoll/refs/heads/main/function/combat/aimbot"))()
				if _G.EnableAimbot then 
					_G.EnableAimbot() 
				end
			end)
			if success then
				Library:Notify({ Title = "Aimbot", Description = "Aimbot enabled!", Time = 2 })
			else
				Library:Notify({ Title = "Aimbot", Description = "Failed to load aimbot: " .. tostring(err), Time = 3 })
			end
		else
			if _G.DisableAimbot then 
				_G.DisableAimbot() 
			end
			if _G.CleanupAimbot then
				_G.CleanupAimbot()
			end
			Library:Notify({ Title = "Aimbot", Description = "Aimbot disabled", Time = 2 })
		end
	end,
})

CombatGroupBox:AddSlider("AimbotSmooth", {
	Text = "Smooth",
	Default = 50,
	Min = 1,
	Max = 100,
	Rounding = 0,
	Callback = function(Value)
		if _G.SetAimbotSmooth then 
			_G.SetAimbotSmooth(Value) 
		end
	end,
})

CombatGroupBox:AddSlider("AimbotFOV", {
	Text = "FOV",
	Default = 30,
	Min = 1,
	Max = 150,
	Rounding = 1,
	Callback = function(Value)
		if _G.SetAimbotFOV then 
			_G.SetAimbotFOV(Value) 
		end
	end,
})

CombatGroupBox:AddSlider("AimbotShake", {
	Text = "Shake",
	Default = 5,
	Min = 0,
	Max = 30,
	Rounding = 0,
	Callback = function(Value)
		if _G.SetAimbotShake then 
			_G.SetAimbotShake(Value) 
		end
	end,
})

CombatGroupBox:AddDropdown("AimbotPart", {
	Values = { "Head", "Torso", "LowerTorso", "LeftUpperArm", "RightUpperArm", "LeftLowerArm", "RightLowerArm", "LeftHand", "RightHand", "LeftUpperLeg", "RightUpperLeg", "LeftLowerLeg", "RightLowerLeg", "LeftFoot", "RightFoot", "HumanoidRootPart" },
	Default = 1,
	Multi = false,
	Text = "Hit Part",
	Callback = function(Value)
		if _G.SetAimbotPart then 
			_G.SetAimbotPart(Value) 
		end
	end,
})

CombatGroupBox:AddLabel("Aimbot Keybind"):AddKeyPicker("AimbotKeybind", {
	Default = "C",
	Mode = "Hold",
	Text = "Hold Key",
	NoUI = false,
	Callback = function(Value)
		print("KeyPicker Callback - Value:", Value, "Type:", type(Value))
		if _G.SetAimbotKeybind then 
			_G.SetAimbotKeybind(Value) 
		end
	end,
	ChangedCallback = function(New)
		print("KeyPicker ChangedCallback - New:", New, "Type:", type(New))
		if _G.SetAimbotKeybind then 
			-- Handle the keybind change
			if type(New) == "userdata" and tostring(New):find("KeyCode") then
				_G.SetAimbotKeybind(New)
			elseif type(New) == "string" then
				_G.SetAimbotKeybind(New)
			else
				-- Try to extract the key name
				local keyName = tostring(New):match("KeyCode%.(%w+)")
				if keyName then
					_G.SetAimbotKeybind(keyName)
				else
					_G.SetAimbotKeybind(New)
				end
			end
		end
	end,
})

-- Hitbox Expander
CombatGroupBox:AddDivider()
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

-- Visuals
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
			end)
			if success then
				Library:Notify({ Title = "View Mode", Description = "3D ESP loaded", Time = 2 })
			else
				Library:Notify({ Title = "View Mode", Description = "Failed to load 3D ESP: " .. tostring(err), Time = 3 })
			end
		end
	end,
})

VisualGroupBox:AddToggle("SkeletonToggle", {
	Default = false,
	Text = "Enable Skeleton ESP",
	Tooltip = "Toggle skeleton ESP on or off",

	Callback = function(Value)
		if Value then
			local success, err = pcall(function()
				loadstring(game:HttpGet("https://raw.githubusercontent.com/ipso1337/tridentscirptoll/refs/heads/main/function/visual/skeleton"))()
				if _G.EnableSkeletonESP then 
					_G.EnableSkeletonESP() 
				end
			end)
			if success then
				Library:Notify({ Title = "Skeleton ESP", Description = "Skeleton ESP enabled!", Time = 2 })
			else
				Library:Notify({ Title = "Skeleton ESP", Description = "Failed to load Skeleton ESP: " .. tostring(err), Time = 3 })
			end
		else
			if _G.DisableSkeletonESP then 
				_G.DisableSkeletonESP() 
			end
			Library:Notify({ Title = "Skeleton ESP", Description = "Skeleton ESP disabled", Time = 2 })
		end
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
			Library:Notify({ Title = "Watermark", Description = "Watermark enabled!", Time = 2 })
		else
			if _G.DisableWatermark then 
				_G.DisableWatermark() 
			end
			Library:Notify({ Title = "Watermark", Description = "Watermark disabled", Time = 2 })
		end
	end,
})

VisualGroupBox:AddButton({
	Text = "Show Health Bar",
	Tooltip = "Loads ESP script to show player health bars",

	Func = function()
		local success, err = pcall(function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/Eazvy/UILibs/refs/heads/main/ESP/XCT/Example"))()
		end)
		if success then
			Library:Notify({ Title = "ESP Loaded", Description = "Health Bar ESP loaded!", Time = 3 })
		else
			Library:Notify({ Title = "ESP Error", Description = "Failed to load Health Bar ESP: " .. tostring(err), Time = 3 })
		end
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
		-- Cleanup all functions including hitbox expander
		local cleanupFunctions = {
			"CleanupBoxESP",
			"CleanupCornerESP", 
			"CleanupSkeletonESP",
			"CleanupWatermark",
			"CleanupVisualSpinbot",
			"CleanupAimbot",
			"CleanupHitboxExpander"
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
	-- Cleanup all functions on unload including hitbox expander
	local cleanupFunctions = {
		"CleanupBoxESP",
		"CleanupCornerESP", 
		"CleanupSkeletonESP",
		"CleanupWatermark",
		"CleanupVisualSpinbot",
		"CleanupAimbot",
		"CleanupHitboxExpander"
	}
	
	for _, funcName in ipairs(cleanupFunctions) do
		if _G[funcName] then 
			pcall(_G[funcName])
		end
	end
	
	print("Script unloaded!")
end)

-- Initialize managers
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ "MenuKeybind" })
ThemeManager:SetFolder("CustomScript")
SaveManager:SetFolder("CustomScript/settings")
SaveManager:BuildConfigSection(Tabs["UI Settings"])
ThemeManager:ApplyToTab(Tabs["UI Settings"])
SaveManager:LoadAutoloadConfig()

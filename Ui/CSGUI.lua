-- Script by ipso1337
-- Loader: loadstring(game:HttpGet("https://raw.githubusercontent.com/ipso1337/tridentscirptoll/refs/heads/main/Ui/CSGUI.lua"))()

local repo = 'https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
local Options = Library.Options
local Toggles = Library.Toggles

Library.ShowToggleFrameInKeybinds = true
Library.ShowCustomCursor = true
Library.NotifySide = "Left"

local Window = Library:CreateWindow({
	Title = 'Trident Script',
	Center = true,
	AutoShow = true,
	Resizable = true,
	ShowCustomCursor = true,
	NotifySide = "Left",
	TabPadding = 8,
	MenuFadeTime = 0.2
})

-- Create tabs
local Tabs = {
	Combat = Window:AddTab('Combat'),
	Visual = Window:AddTab('Visual'),
	Misc = Window:AddTab('Misc'),
	Other = Window:AddTab('Other'),
}

-- Combat Tab
local CombatLeftGroupBox = Tabs.Combat:AddLeftGroupbox('Combat Features')
CombatLeftGroupBox:AddToggle('Aimbot', {
	Text = 'Aimbot',
	Tooltip = 'Automatically aims at enemies',
	Default = false,
	Callback = function(Value)
		print('[Combat] Aimbot:', Value)
	end
})

CombatLeftGroupBox:AddToggle('ESP', {
	Text = 'ESP',
	Tooltip = 'Shows enemy locations',
	Default = false,
	Callback = function(Value)
		print('[Combat] ESP:', Value)
	end
})

-- Visual Tab
local VisualLeftGroupBox = Tabs.Visual:AddLeftGroupbox('Visual Features')
VisualLeftGroupBox:AddToggle('Wallhack', {
	Text = 'Wallhack',
	Tooltip = 'See through walls',
	Default = false,
	Callback = function(Value)
		print('[Visual] Wallhack:', Value)
	end
})

VisualLeftGroupBox:AddToggle('Chams', {
	Text = 'Chams',
	Tooltip = 'Highlight players',
	Default = false,
	Callback = function(Value)
		print('[Visual] Chams:', Value)
	end
})

-- Misc Tab
local MiscLeftGroupBox = Tabs.Misc:AddLeftGroupbox('Misc Features')
MiscLeftGroupBox:AddToggle('Speed', {
	Text = 'Speed Hack',
	Tooltip = 'Increases movement speed',
	Default = false,
	Callback = function(Value)
		print('[Misc] Speed:', Value)
	end
})

MiscLeftGroupBox:AddToggle('Fly', {
	Text = 'Fly',
	Tooltip = 'Allows flying',
	Default = false,
	Callback = function(Value)
		print('[Misc] Fly:', Value)
	end
})

-- Other Tab (UI Settings)
local MenuGroup = Tabs.Other:AddLeftGroupbox('Menu')

MenuGroup:AddToggle("KeybindMenuOpen", { 
	Default = Library.KeybindFrame.Visible, 
	Text = "Open Keybind Menu", 
	Callback = function(value) 
		Library.KeybindFrame.Visible = value 
	end
})

MenuGroup:AddToggle("ShowCustomCursor", {
	Text = "Custom Cursor", 
	Default = true, 
	Callback = function(Value) 
		Library.ShowCustomCursor = Value 
	end
})

MenuGroup:AddDivider()

MenuGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", { 
	Default = "RightShift", 
	NoUI = true, 
	Text = "Menu keybind" 
})

MenuGroup:AddButton("Unload", function() 
	Library:Unload() 
end)

Library.ToggleKeybind = Options.MenuKeybind

-- Library functions
Library:SetWatermarkVisibility(true)

-- Watermark with FPS and ping
local FrameTimer = tick()
local FrameCounter = 0;
local FPS = 60;

local WatermarkConnection = game:GetService('RunService').RenderStepped:Connect(function()
	FrameCounter += 1;

	if (tick() - FrameTimer) >= 1 then
		FPS = FrameCounter;
		FrameTimer = tick();
		FrameCounter = 0;
	end;

	Library:SetWatermark(('Trident Script | %s fps | %s ms'):format(
		math.floor(FPS),
		math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
	));
end);

Library:OnUnload(function()
	WatermarkConnection:Disconnect()
	print('Unloaded!')
	Library.Unloaded = true
end)

-- Setup managers
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })

ThemeManager:SetFolder('TridentScript')
SaveManager:SetFolder('TridentScript/configs')

-- Build config and theme sections
SaveManager:BuildConfigSection(Tabs.Other)
ThemeManager:ApplyToTab(Tabs.Other)

SaveManager:LoadAutoloadConfig()

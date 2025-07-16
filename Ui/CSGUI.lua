-- New example script written by wally
-- You can suggest changes with a pull request or something

local repo = 'https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
local Options = Library.Options
local Toggles = Library.Toggles

Library.ShowToggleFrameInKeybinds = true -- Make toggle keybinds work inside the keybinds UI (aka adds a toggle to the UI). Good for mobile users (Default value = true)
Library.ShowCustomCursor = true -- Toggles the Linoria cursor globally (Default value = true)
Library.NotifySide = "Left" -- Changes the side of the notifications globally (Left, Right) (Default value = Left)

local Window = Library:CreateWindow({
	Title = 'Example menu',
	Center = true,
	AutoShow = true,
	Resizable = true,
	ShowCustomCursor = true,
	NotifySide = "Left",
	TabPadding = 8,
	MenuFadeTime = 0.2
})

-- You do not have to set your tabs & groups up this way, just a preference.
local Tabs = {
	-- Existing tab
	Main = Window:AddTab('Main'),
	-- New tabs
	Combat = Window:AddTab('Combat'),
	Visual = Window:AddTab('Visual'),
	Misc = Window:AddTab('Misc'),
	-- Renamed UI Settings to Other
	Other = Window:AddTab('Other'),
}

-- Groupbox and Tabbox inherit the same functions
local LeftGroupBox = Tabs.Main:AddLeftGroupbox('Groupbox')

-- Existing Main tab content
LeftGroupBox:AddToggle('MyToggle', {
	Text = 'This is a toggle',
	Tooltip = 'This is a tooltip',
	DisabledTooltip = 'I am disabled!',
	Default = true,
	Disabled = false,
	Visible = true,
	Risky = false,
	Callback = function(Value)
		print('[cb] MyToggle changed to:', Value)
	end
}):AddColorPicker('ColorPicker1', {
	Default = Color3.new(1, 0, 0),
	Title = 'Some color1',
	Transparency = 0,
	Callback = function(Value, Transparency)
		print('[cb] Color changed!', Value, '| Transparency changed to:', Transparency)
	end
}):AddColorPicker('ColorPicker2', {
	Default = Color3.new(0, 1, 0),
	Title = 'Some color2',
	Transparency = 0,
	Callback = function(Value, Transparency)
		print('[cb] Color changed!', Value, '| Transparency changed to:', Transparency)
	end
}):AddColorPicker('ColorPicker3', {
	Default = Color3.new(0, 0, 1),
	Title = 'Some color3',
	Transparency = 0,
	Callback = function(Value, Transparency)
		print('[cb] Color changed!', Value, '| Transparency changed to:', Transparency)
	end
})

Toggles.MyToggle:OnChanged(function()
	print('MyToggle changed to:', Toggles.MyToggle.Value)
end)
Toggles.MyToggle:SetValue(false)

local MyButton = LeftGroupBox:AddButton({
	Text = 'Button',
	Func = function()
		print('You clicked a button!')
		Library:Notify("This is a notification")
	end,
	DoubleClick = false,
	Tooltip = 'This is the main button',
	DisabledTooltip = 'I am disabled!',
	Disabled = false,
	Visible = true
})

local MyButton2 = MyButton:AddButton({
	Text = 'Sub button',
	Func = function()
		print('You clicked a sub button!')
		Library:Notify("This is a notification with sound", nil, 4590657391)
	end,
	DoubleClick = true,
	Tooltip = 'This is the sub button (double click me!)'
})

local MyDisabledButton = LeftGroupBox:AddButton({
	Text = 'Disabled Button',
	Func = function()
		print('You somehow clicked a disabled button!')
	end,
	DoubleClick = false,
	Tooltip = 'This is a disabled button',
	DisabledTooltip = 'I am disabled!',
	Disabled = true
})

LeftGroupBox:AddLabel('This is a label')
LeftGroupBox:AddLabel('This is a label\n\nwhich wraps its text!', true)

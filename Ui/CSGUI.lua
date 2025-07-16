-- New example script written by wally
-- You can suggest changes with a pull request or something

local repo = 'https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
local Options = Library.Options
local Toggles = Library.Toggles

Library.ShowToggleFrameInKeybinds = true -- Make toggle keybinds work inside the keybinds UI (aka adds a toggle to the UI). Good for mobile users (Default value = true)
Library.ShowCustomCursor = true -- Toggles the Linoria cursor globaly (Default value = true)
Library.NotifySide = "Left" -- Changes the side of the notifications globaly (Left, Right) (Default value = Left)

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

-- Existing Main tab content (unchanged)
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
LeftGroupBox:AddLabel('This is a label exposed to Labels', true, 'TestLabel')
LeftGroupBox:AddLabel('SecondTestLabel', {
	Text = 'This is a label made with table options and an index',
	DoesWrap = true
})

LeftGroupBox:AddLabel('SecondTestLabel', {
	Text = 'This is a label that doesn\'t wrap it\'s own text',
	DoesWrap = false
})

LeftGroupBox:AddDivider()

LeftGroupBox:AddSlider('MySlider', {
	Text = 'This is my slider!',
	Default = 0,
	Min = 0,
	Max = 5,
	Rounding = 1,
	Compact = false,
	Callback = function(Value)
		print('[cb] MySlider was changed! New value:', Value)
	end,
	Tooltip = 'I am a slider!',
	DisabledTooltip = 'I am disabled!',
	Disabled = false,
	Visible = true
})

local Number = Options.MySlider.Value
Options.MySlider:OnChanged(function()
	print('MySlider was changed! New value:', Options.MySlider.Value)
end)
Options.MySlider:SetValue(3)

LeftGroupBox:AddInput('MyTextbox', {
	Default = 'My textbox!',
	Numeric = false,
	Finished = false,
	ClearTextOnFocus = true,
	Text = 'This is a textbox',
	Tooltip = 'This is a tooltip',
	Placeholder = 'Placeholder text',
	Callback = function(Value)
		print('[cb] Text updated. New text:', Value)
	end
})

Options.MyTextbox:OnChanged(function()
	print('Text updated. New text:', Options.MyTextbox.Value)
end)

local DropdownGroupBox = Tabs.Main:AddRightGroupbox('Dropdowns')

DropdownGroupBox:AddDropdown('MyDropdown', {
	Values = { 'This', 'is', 'a', 'dropdown' },
	Default = 1,
	Multi = false,
	Text = 'A dropdown',
	Tooltip = 'This is a tooltip',
	DisabledTooltip = 'I am disabled!',
	Searchable = false,
	Callback = function(Value)
		print('[cb] Dropdown got changed. New value:', Value)
	end,
	Disabled = false,
	Visible = true
})

Options.MyDropdown:OnChanged(function()
	print('Dropdown got changed. New value:', Options.MyDropdown.Value)
end)
Options.MyDropdown:SetValue('This')

DropdownGroupBox:AddDropdown('MySearchableDropdown', {
	Values = { 'This', 'is', 'a', 'searchable', 'dropdown' },
	Default = 1,
	Multi = false,
	Text = 'A searchable dropdown',
	Tooltip = 'This is a tooltip',
	DisabledTooltip = 'I am disabled!',
	Searchable = true,
	Callback = function(Value)
		print('[cb] Dropdown got changed. New value:', Value)
	end,
	Disabled = false,
	Visible = true
})

DropdownGroupBox:AddDropdown('MyDisplayFormattedDropdown', {
	Values = { 'This', 'is', 'a', 'formatted', 'dropdown' },
	Default = 1,
	Multi = false,
	Text = 'A display formatted dropdown',
	Tooltip = 'This is a tooltip',
	DisabledTooltip = 'I am disabled!',
	FormatDisplayValue = function(Value)
		if Value == 'formatted' then
			return 'display formatted'
		end
		return Value
	end,
	Searchable = false,
	Callback = function(Value)
		print('[cb] Display formatted dropdown got changed. New value:', Value)
	end,
	Disabled = false,
	Visible = true
})

DropdownGroupBox:AddDropdown('MyMultiDropdown', {
	Values = { 'This', 'is', 'a', 'dropdown' },
	Default = 1,
	Multi = true,
	Text = 'A multi dropdown',
	Tooltip = 'This is a tooltip',
	Callback = function(Value)
		print('[cb] Multi dropdown got changed:')
		for key, value in next, Options.MyMultiDropdown.Value do
			print(key, value)
		end
	end
})

Options.MyMultiDropdown:SetValue({
	This = true,
	is = true,
})

DropdownGroupBox:AddDropdown('MyDisabledDropdown', {
    Values = { 'This', 'is', 'a', 'dropdown' },
    Default = 1,
    Multi = false,
    Text = 'A disabled dropdown',
    Tooltip = 'This is a tooltip',
    DisabledTooltip = 'I am disabled!',
    Callback = function(Value)
        print('[cb] Disabled dropdown got changed. New value:', Value)
    end,
    Disabled = true,
    Visible = true
})

DropdownGroupBox:AddDropdown('MyDisabledValueDropdown', {
    Values = { 'This', 'is', 'a', 'dropdown', 'with', 'disabled', 'value' },
    DisabledValues = { 'disabled' },
    Default = 1,
    Multi = false,
    Text = 'A dropdown with disabled value',
    Tooltip = 'This is a tooltip',
    DisabledTooltip = 'I am disabled!',
    Callback = function(Value)
        print('[cb] Dropdown with disabled value got changed. New value:', Value)
    end,
    Disabled = false,
    Visible = true
})

DropdownGroupBox:AddDropdown('MyVeryLongDropdown', {
	Values = { 'This', 'is', 'a', 'very', 'long', 'dropdown', 'with', 'a', 'lot', 'of', 'values', 'but', 'you', 'can', 'see', 'more', 'than', '8', 'values' },
	Default = 1,
	Multi = false,
	MaxVisibleDropdownItems = 12,
	Text = 'A very long dropdown',
	Tooltip = 'This is a tooltip',
	DisabledTooltip = 'I am disabled!',
	Searchable = false,
	Callback = function(Value)
		print('[cb] Very long dropdown got changed. New value:', Value)
	end,
	Disabled = false,
	Visible = true
})

DropdownGroupBox:AddDropdown('MyPlayerDropdown', {
	SpecialType = 'Player',
	ExcludeLocalPlayer = true,
	Text = 'A player dropdown',
	Tooltip = 'This is a tooltip',
	Callback = function(Value)
		print('[cb] Player dropdown got changed:', Value)
	end
})

DropdownGroupBox:AddDropdown('MyTeamDropdown', {
	SpecialType = 'Team',
	Text = 'A team dropdown',
	Tooltip = 'This is a tooltip',
	Callback = function(Value)
		print('[cb] Team dropdown got changed:', Value)
	end
})

LeftGroupBox:AddLabel('Color'):AddColorPicker('ColorPicker', {
	Default = Color3.new(0, 1, 0),
	Title = 'Some color',
	Transparency = 0,
	Callback = function(Value)
		print('[cb] Color changed!', Value)
	end
})

Options.ColorPicker:OnChanged(function()
	print('Color changed!', Options.ColorPicker.Value)
	print('Transparency changed!', Options.ColorPicker.Transparency)
end)
Options.ColorPicker:SetValueRGB(Color3.fromRGB(0, 255, 140))

LeftGroupBox:AddLabel('Keybind'):AddKeyPicker('KeyPicker', {
	Default = 'MB2',
	SyncToggleState = false,
	Mode = 'Toggle',
	Text = 'Auto lockpick safes',
	NoUI = false,
	Callback = function(Value)
		print('[cb] Keybind clicked!', Value)
	end,
	ChangedCallback = function(New)
		print('[cb] Keybind changed!', New)
	end
})

Options.KeyPicker:OnClick(function()
	print('Keybind clicked!', Options.KeyPicker:GetState

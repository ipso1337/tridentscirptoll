-- Loader (Загрузчик)
local repo = 'https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
local Options = Library.Options

-- Настройка глобальных параметров библиотеки
Library.ShowToggleFrameInKeybinds = true
Library.ShowCustomCursor = true
Library.NotifySide = "Left"

-- Создание окна UI
local Window = Library:CreateWindow({
    Title = 'My Menu',
    Center = true,
    AutoShow = true,
    Resizable = true,
    ShowCustomCursor = true,
    NotifySide = "Left",
    TabPadding = 8,
    MenuFadeTime = 0.2
})

-- Определение вкладок
local Tabs = {
    Combat = Window:AddTab('Combat'),
    Visual = Window:AddTab('Visual'),
    Misc = Window:AddTab('Misc'),
    Other = Window:AddTab('Other'),
}

-- Настройка вкладки Other (ранее UI Settings)
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

-- Настройка горячей клавиши для меню
Library.ToggleKeybind = Options.MenuKeybind

-- Передача библиотеки менеджерам
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

-- Игнорирование настроек темы и горячей клавиши меню для сохранения
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })

-- Настройка папок для сохранения
ThemeManager:SetFolder('MyScriptHub')
SaveManager:SetFolder('MyScriptHub/specific-game')
SaveManager:SetSubFolder('specific-place')

-- Построение секций конфигурации и тем
SaveManager:BuildConfigSection(Tabs.Other)
ThemeManager:ApplyToTab(Tabs.Other)

-- Автозагрузка конфигурации
SaveManager:LoadAutoloadConfig()

-- Пример скрипта, используещего безопасный вызов и установку метода button.OnClick

UI:Initialize()
local button = UI:Button('Button', 125, 29, 51, 95, 'filled_2', 9.0, nil)

local function onClick()
	UI:Message('Test', 'Message')
end

local function onClickProtected()
    if pcall(onClick) then
        UI:Alert('Successfully', 'Success')
     else
        UI:Alert('An error has occurred', 'Error')
     end
end

UI:AddOnClick(button, onClickProtected())

-- Пример скрипта, определяющего UserID пользователя/группы по nickname'у
-- Для использования LUA необходима библиотека json.lua

json = require 'json'

UI:Initialize()
panel = UI:Panel(240, 190, 40, 100, 25)
label = UI:Label('Enter nickname UserID', 12.0, 15, 20, panel)
textbox = UI:TextBox('Nickname', 11.0, 200, 22, 15, 55, 15, panel)
button = UI:Button('Resolve', 125, 30, 17, 105, 'filled_2', 10.0, panel)
labelID = UI:Label('UserID:null Type:null', 10.0, 15, 150, panel)

function onClick()
	text = textbox.Text
	if text == '' then
		UI:Alert('TextBox is empty', 'Error')
	else
		response = VK:SendRequest('utils.resolveScreenName', '5.124', 'screen_name='..text, null)
		data = json.decode(response)
		labelID.Text = 'UserID:'..data['object_id']..' Type:'..data['type']
	end
end

UI:AddOnClick(button, onClick)
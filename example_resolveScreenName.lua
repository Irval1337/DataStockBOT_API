-- Пример скрипта, определяющего UserID пользователя/группы по nickname'у
-- Для использования LUA необходима библиотека json.lua

local json = require 'json'

UI:Initialize()
local panel = UI:Panel(235, 180, 40, 100, 25)
local label = UI:Label('Enter nickname UserID', 11.0, 15, 20, panel)
local textbox = UI:TextBox('Nickname', 10.0, 200, 22, 15, 50, 15, panel)
local button = UI:Button('Resolve', 125, 29, 33 + 17, 95, 'filled_2', 9.0, panel)
local labelID = UI:Label('UserID:null Type:null', 9.5, 15, 145, panel)

local function onClick()
	local text = textbox.Text
	if text == '' then
		UI:Alert('TextBox is empty', 'Error')
	else
		local response = VK:SendRequest('utils.resolveScreenName', '5.124', 'screen_name='..text, nil)
		local data = json.decode(response)
		labelID.Text = 'UserID:'..data['object_id']..' Type:'..data['type']
	end
end

UI:AddOnClick(button, onClick)
-- Пример скрипта, выдающего список последних 1000 учпстников группы в (анти)хронологическом порядке
-- Для использования LUA необходима библиотека json.lua

local json = require 'json'

UI:Initialize()
local panel = UI:Panel(435, 210, 40, 100, 25)
local label = UI:Label('Enter GroupID', 11.0, 15, 20, panel)
local textbox = UI:TextBox('Nickname or GroupID', 10.0, 200, 22, 15, 50, 15, panel)
local checkbox = UI:CheckBox('Use time_desc sorting', 19, 17, 95, panel)
local button = UI:Button('Get users', 125, 29, 17, 126, 'filled_2', 9.0, panel)
local label1= UI:Label('Important: you must be the \nmoderator of the group', 9.0, 15, 170, panel)
local label2 = UI:Label('Users', 11.0, 245, 20, panel)
local richtextbox = UI:RichTextBox('', 9.0, 170, 150, 245, 50, panel)
richtextbox.ReadOnly = true

local function onClick()
	local text = textbox.Text
	if text == '' then
		UI:Alert('TextBox is empty', 'Error')
	else
		local response = VK:SendRequest('utils.resolveScreenName', '5.124', 'screen_name='..text, nil)
		local data = json.decode(response)

		if data['type'] == ('group' or 'page')  then		
			response = VK:SendRequest('groups.getMembers', '5.124', 'group_id='..data['object_id']..'&sort='..(checkbox.Checked and 'time_desc' or 'time_asc')..'&offset=0&count=1000&fields=name&lang=en', nil)
			data = json.decode(response)
			richtextbox.Text = ''
			label2.Text = 'Users ('..data['count']..')'

			for i = 1, data['count'] do
				local info = data['items'][i]
				richtextbox.Text = richtextbox.Text..info['first_name']..' '..info['last_name']..' (id'..info['id']..')\n'
			end
		else
			UI:Alert('Unsupported type', 'Error')
		end
	end
end

local function onClickProtected()
    if pcall(onClick) then
        UI:Alert('Successfully', 'Success')
     else
        UI:Alert('An error has occurred', 'Error')
     end
end

UI:AddOnClick(button, onClickProtected)

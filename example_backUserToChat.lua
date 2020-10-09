-- Пример скрипта, возвращающего вышедшего пользователя назад в беседу
-- Для использования LUA необходима библиотека json.lua

local json = require 'json'

UI:Initialize()
local panel = UI:Panel(240, 200, 40, 100, 25)
local label1 = UI:Label('Enter UserID', 11.0, 15, 20, panel)
local textbox1 = UI:TextBox('Nickname or ID', 10.0, 200, 22, 15, 50, 15, panel)
local label2 = UI:Label('Enter ChatID (digits only)', 11.0, 15, 105, panel)
local textbox2 = UI:TextBox('ChatId', 10.0, 200, 22, 15, 135, 15, panel)
local button = UI:Button('Back user to the chat', 165, 35, 40 + 34, 310, 'filled_2', 9.0, nil)

local function onClick()
    local userid = textbox1.Text;
    local chatid = textbox2.Text;
	if (userid == '' or chatid == '') then
		UI:Alert('TextBox is empty', 'Error')
	else
		local response = VK:SendRequest('utils.resolveScreenName', '5.124', 'screen_name='..userid, nil)
        local data = json.decode(response)
        if data['type'] == 'user' then
            local user = data['object_id']
            VK:SendRequest('messages.removeChatUser', '5.21', 'chat_id='..chatid..'&user_id='..user, nil)
            VK:SendRequest('messages.addChatUser', '5.124', 'chat_id='..chatid..'&user_id='..user, nil)
        else
            UI:Alert('Unsupported user type', 'Error')
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
--- Telegram reply keyboard markup object.
-- This object represents a [custom keyboard](https://core.telegram.org/bots#keyboards) with reply options
-- (see [Introduction to bots](https://core.telegram.org/bots#keyboards) for details and examples).
-- @classmod ReplyKeyboardMarkup

local class = require("middleclass")

local ReplyKeyboardMarkup = class("telegram.structures.ReplyKeyboardMarkup")

--- Create a new ReplyKeyboardMarkup object.
-- A keyboard button can be either a string, which would be the text of the button, and the message sent when the user presses the button.
--
-- Or it can be an array of a string and a number, the string would be the text of the button. And for the number,
--
-- if it was 1, then the user's phone number will be sent as a contact when the button is pressed. Available in private chats only.
--
-- if it was 2, then the current user's location will be sent when the button is pressed. Available in private chats only.
--
-- if it was 3 or 4 or 5, then the user will be asked to create a poll and send it to the bot when the button is pressed. Available in private chats only.
--
-- if it was 3, then the user can create a poll of any type, if it was 4, then the user can only create a regular poll, if it was 5 then the user can only create a quiz poll.
-- @tparam {{string|{string|numbers}}} keyboard Array of keyboard rows, each row is an array of keyboard buttons.
-- @tparam ?boolean resizeKeyboard test.
-- @tparam ?boolean oneTimeKeyboard test.
-- @tparam ?boolean selective test.
-- @treturn ReplyKeyboardMarkup The new created ReplyKeyboardMarkup object.
-- @usage local replyKeyboardMarkup = telegram.structures.ReplyKeyboardMarkup(keyboard, resizeKeyboard, oneTimeKeyboard, selective)
function ReplyKeyboardMarkup:initialize(keyboard, resizeKeyboard, oneTimeKeyboard, selective)

    --- Array of button rows, each represented by an Array of KeyboardButton values.
    self.keyboard = keyboard

    --- Optional fields.
    -- @section optional_fields.

    --- Requests clients to resize the keyboard vertically for optimal fit (e.g., make the keyboard smaller if there are just two rows of buttons). Defaults to false, in which case the custom keyboard is always of the same height as the app's standard keyboard. (boolean).
    self.resizeKeyboard = resizeKeyboard

    --- Requests clients to hide the keyboard as soon as it's been used. The keyboard will still be available, but clients will automatically display the usual letter-keyboard in the chat – the user can press a special button in the input field to see the custom keyboard again. Defaults to false. (boolean).
    self.oneTimeKeyboard = oneTimeKeyboard

    --- Use this parameter if you want to force reply from specific users only.
    -- Targets: 1) users that are `@mentioned` in the text of the Message object;
    -- 2) if the bot's message is a reply (has reply_to_message_id), sender of the original message.
    -- (boolean).
    self.selective = selective

    ---
    -- @section end

end

--- Get the object's data in telegram's API format, to be sent using a method.
-- @treturn table The object's data in telegram's API format.
function ReplyKeyboardMarkup:getData()
    local keyboard = {}

    for i, row in pairs(self.keyboard) do
        keyboard[i] = {}
        for j, button in pairs(row) do
            if type(button) == "string" then
                keyboard[i][j] = {
                    text = button
                }
            elseif type(button) == "table" then
                local value = {
                    text = button[1]
                }

                if button[2] == 1 then
                    value.request_contact = true
                elseif button[2] == 2 then
                    value.request_location = true
                elseif button[2] == 3 then
                    value.request_poll = {}
                elseif button[2] == 4 then
                    value.request_poll = {
                        type = "regular"
                    }
                elseif button[2] == 5 then
                    value.request_poll = {
                        type = "quiz"
                    }
                end

                keyboard[i][j] = value
            end
        end
    end

    return {
        keyboard = keyboard,
        resize_keyboard = self.resizeKeyboard,
        one_time_keyboard = self.oneTimeKeyboard,
        selective = self.selective
    }
end

return ReplyKeyboardMarkup
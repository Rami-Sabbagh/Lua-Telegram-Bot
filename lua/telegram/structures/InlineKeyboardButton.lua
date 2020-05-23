--- Telegram inline keyboard button object.
-- This object represents one button of an inline keyboard. You must use exactly one of the optional fields.
-- @classmod InlineKeyboardButton

local class = require("middleclass")

--TODO: local LoginUrl = require("telegram.structures.LoginUrl")
--TODO: local CallbackGame = require("telegram.structures.CallbackGame")

local InlineKeyboardButton = class("telegram.structures.InlineKeyboardButton")

--- Create a new inline keyboard button object, either *new*, or *using data* returned by Telegram Bot API.
-- @tparam string|table data The label text on the button (string), or the inline keyboard button data returned by Telegram Bot API (table).
-- @treturn InlineKeyboardButton The new created inline keyboard buttoncallback query object.
function InlineKeyboardButton:initialize(data)
    data = type(data) == "string" and {text=data} or data

    --- Label text on the button (string).
    self.text = data.text

    --- Optional fields.
    -- @section optional_fields

    --- HTTP or tg:// url to be opened when button is pressed (string).
    self.url = data.url

    --TODO: login_url

    --- Data to be sent in a callback query to the bot when button is pressed, 1-64 bytes (string).
    self.callbackData = data.callback_data

    --- If set, pressing the button will prompt the user to select one of their chats, open that chat and insert the bot's username and the specified inline query in the input field. Can be empty, in which case just the bot's username will be inserted. (string).
    -- **Note:** This offers an easy way for users to start using your bot in inline mode when they are currently in a private chat with it. Especially useful when combined with switch_pm… actions – in this case the user will be automatically returned to the chat they switched from, skipping the chat selection screen.
    self.switchInlineQuery = data.switch_inline_query

    --- If set, pressing the button will insert the bot's username and the specified inline query in the current chat's input field. Can be empty, in which case only the bot's username will be inserted.
    -- This offers a quick way for the user to open your bot in inline mode in the same chat – good for selecting something from multiple options.
    self.switchInlineQueryCurrentChat = data.switch_inline_query_current_chat

    --TODO: callback_game

    --- Specify True, to send a [Pay button](https://core.telegram.org/bots/api#payments).
    -- **NOTE:** This type of button must always be the first button in the first row.
    self.pay = data.pay

    ---
    -- @section end

end

--- Get the object's data in telegram's API format, to be sent using a method.
-- @treturn table The object's data in telegram's API format.
function InlineKeyboardButton:getData()
    return {
        text = self.text,
        url = self.url,
        login_url = self.loginUrl,
        callback_data = self.callbackData,
        switch_inline_query = self.switchInlineQuery,
        switch_inline_query_current_chat = self.switch_inline_query_current_chat,
        callback_game = self.callbackGame and self.callbackGame:getData(),
        pay = self.pay
    }
end

return InlineKeyboardButton
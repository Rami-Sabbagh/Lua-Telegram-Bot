--- Telegram callback query object.
-- This object represents a callback quary.
--
-- **NOTE:** After the user presses a callback button, Telegram clients will display a progress bar until you call `answerCallbackQuery`. It is, therefore, necessary to react by calling `answerCallbackQuery` even if no notification to the user is needed (e.g., without specifying any of the optional parameters).
-- @classmod CallbackQuery

local class = require("middleclass")

local Message = require("telegram.structures.Message")
local User = require("telegram.structures.User")

local CallbackQuery = class("telegram.structures.CallbackQuery")

--- Create a new callback query object using data returned by Telegram Bot API.
-- @tparam table data The callback query data returned by Telegram Bot API.
-- @treturn CallbackQuery The new created callback query object.
function CallbackQuery:initialize(data)

    --- Unique identifier for this query (string).
    self.id = data.id

    --- Sender (User).
    self.from = User(data.from)

    --- Optional fields.
    -- @section optional_fields

    --- Message with the callback button that originated the query. Note that message content and message date will not be available if the message is too old (Message).
    self.message = data.message and Message(data.message)

    --- Identifier of the message sent via the bot in inline mode, that originated the query. (string).
    self.inlineMessageID = data.inline_message_id

    --- Global identifier, uniquely corresponding to the chat to which the message with the callback button was sent. Useful for high scores in games. (string).
    self.chatInstance = data.chat_instance

    --- Data associated with the callback button. Be aware that a bad client can send arbitrary data in this field. (string).
    self.data = data.data

    --- Short name of a Game to be returned, serves as the unique identifier for the game. (string).
    self.gameShortName = data.game_short_name

    ---
    -- @section end

end

return CallbackQuery
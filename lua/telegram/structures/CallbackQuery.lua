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

--- Call a function passing it's errors to the previous error level.
local function call(func, ...)
    local ok, a,b,c,d,e,f = pcall(require("telegram")[func], ...)
    if not ok then error(tostring(a), 3) end
    return a,b,c,d,e,f
end

--- Use this method to send answers to callback queries sent from [inline keyboards](https://core.telegram.org/bots#inline-keyboards-and-on-the-fly-updating).
-- The answer will be displayed to the user as a notification at the top of the chat screen or as an alert.
-- @tparam ?string text Text of the notification. If not specified, nothing will be shown to the user, 0-200 characters.
-- @tparam ?boolean showAlert If `true`, an alert will be shown by the client instead of a notification at the top of the chat screen. Defaults to `false`.
-- @tparam ?string url URL that will be opened by the user's client. If you have created a Game and accepted the conditions via @Botfather, specify the URL that opens your game — note that this will only work if the query comes from a callback_game button.
-- Otherwise, you may use links like t.me/your_bot?start=XXXX that open your bot with a parameter.
-- @tparam ?number cacheTime The maximum amount of time in seconds that the result of the callback query may be cached client-side. Telegram apps will support caching starting in version 3.14. Defaults to `0`.
-- @treturn boolean `true` on success.
-- @raise Error on failure.
function CallbackQuery:answerCallbackQuery(text, showAlert, url, cacheTime)
    return call("answerCallbackQuery", self, text, showAlert, url, cacheTime)
end

return CallbackQuery
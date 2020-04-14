--- Telegram message entity object.
-- This object represents one special entity in a text message. For example, hashtags, usernames, URLs, etc.
-- @classmod MessageEntity

local class = require("middleclass")

local User = require("telegram.structures.User")

local MessageEntity = class("telegram.structures.MessageEntity")

--- Create a new message entity object using data returned by Telegram Bot API.
-- @tparam table data The message entity data returned by Telegram Bot API.
-- @treturn User The new created message entity data object.
function MessageEntity:initialize(data)

    --- Type of the entity (string).
    -- Can be `mention` (`@username`), `hashtag` (`#hashtag`), `cashtag` (`$USD`), `bot_command` (`/start@jobs_bot`),
    -- `url` (`https://telegram.org`), `email` (`do-not-reply@telegram.org`), `phone_number` (`+1-212-555-0123`),
    -- `bold` (bold text), `italic` (italic text), `underline` (underlined text), `strikethrough` (strikethrough text),
    -- `code` (monowidth string), `pre` (monowidth block), `text_link` (for clickable text URLs),
    -- `text_mention` (for users [without usernames](https://telegram.org/blog/edit#new-mentions)).
    self.type = data.type

    --- Offset in UTF-16 code units to the start of the entity (number).
    self.offset = data.offset

    --- Length of the entity in UTF-16 code units (number).
    self.length = data.length

    --- Optional fields.
    -- @section optional_fields

    --- For `text_link` only, url that will be opened after user taps on the text (string).
    self.url = data.url

    --- For `text_mention` only, the mentioned user (User).
    self.user = data.user and User(data.user)

    --- For `pre` only, the programming language of the entity text (string).
    self.language = data.language

    ---
    -- @section end

end

return MessageEntity
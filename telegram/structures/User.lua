--- Telegram user object.
-- This object represents a Telegram user or bot.
-- @classmod User

local class = require("middleclass")

local User = class("telegram.structures.User")

--- Create a new user object using data returned by Telegram Bot API.
-- @tparam table data The user data returned by Telegram Bot API.
-- @treturn User The new created user object.
function User:initialize(data)

    --- Unique identifier for this user or bot (number).
    self.id = data.id
    --- True, if this user is a bot (boolean).
    self.is_bot = data.is_bot
    --- User's or bot's first name (string).
    self.first_name = data.first_name

    --- Optional fields.
    -- @section optional_fields

    --- [IETF language tag](https://en.wikipedia.org/wiki/IETF_language_tag) of the user's language (string).
    self.language_code = data.language_code
    --- True, if the bot can be invited to groups (boolean).
    -- Returned only in `getMe`.
    -- @see telegram.getMe
    self.can_join_groups = data.can_join_groups
    --- True, if [privacy mode](https://core.telegram.org/bots#privacy-mode) is disabled for the bot (boolean).
    -- Returned only in `getMe`.
    -- @see telegram.getMe
    self.can_read_all_group_messages = data.can_read_all_group_messages
    --- True, if the bot supports inline queries (boolean).
    -- Returned only in `getMe`.
    -- @see telegram.getMe
    self.supports_inline_queries = data.supports_inline_queries

    ---
    -- @section end
end

return User
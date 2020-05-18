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
    self.isBot = data.is_bot

    --- User's or bot's first name (string).
    self.firstName = data.first_name

    --- Optional fields.
    -- @section optional_fields

    --- User‘s or bot’s last name (string).
    self.lastName = data.last_name

    --- User‘s or bot’s username (string).
    self.username = data.username

    --- [IETF language tag](https://en.wikipedia.org/wiki/IETF_language_tag) of the user's language (string).
    self.languageCode = data.language_code

    --- True, if the bot can be invited to groups (boolean).
    -- Returned only in `getMe`.
    -- @see telegram.getMe
    self.canJoinGroups = data.can_join_groups

    --- True, if [privacy mode](https://core.telegram.org/bots#privacy-mode) is disabled for the bot (boolean).
    -- Returned only in `getMe`.
    -- @see telegram.getMe
    self.canReadAllGroupMessages = data.can_read_all_group_messages

    --- True, if the bot supports inline queries (boolean).
    -- Returned only in `getMe`.
    -- @see telegram.getMe
    self.supportsInlineQueries = data.supports_inline_queries

    ---
    -- @section end

end

--- Call a function passing it's errors to the previous error level.
local function call(func, ...)
    local ok, a,b,c,d,e,f = pcall(require("telegram")[func], ...)
    if not ok then error(tostring(a), 3) end
    return a,b,c,d,e,f
end

--- Use this method to upload a .PNG file with a sticker for later use in createNewStickerSet and addStickerToSet methods (can be used multiple times).
-- @tparam InputFile pngSticker **PNG** image with the sticker, must be up to 512 kilobytes in size, dimensions must not exceed 512px, and either width or height must be exactly 512px.
-- @treturn File The uploaded file.
-- @raise Error on failure.
function User:uploadStickerFile(pngSticker)
    return call("uploadStickerFile", self.id, pngSticker)
end

--- Operators overrides.
-- @section operators_overrides

--- Test if the 2 user objects refer to the same chat (by comparing their IDs).
-- @tparam User user The user to compare with.
-- @treturn boolean `true` if they're the same.
function User:__eq(user)
    return self.id == user.id
end

return User
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

--- Stickers Methods.
-- @section stickers

--- Use this method to upload a .PNG file with a sticker for later use in createNewStickerSet and addStickerToSet methods (can be used multiple times).
-- @tparam InputFile pngSticker **PNG** image with the sticker, must be up to 512 kilobytes in size, dimensions must not exceed 512px, and either width or height must be exactly 512px.
-- @treturn File The uploaded file.
-- @raise Error on failure.
function User:uploadStickerFile(pngSticker)
    return call("uploadStickerFile", self.id, pngSticker)
end

--- Use this method to create a new sticker set owned by a user.
-- The bot will be able to edit the sticker set thus created.
-- You **must** use exactly one of the fields `pngSticker` or `tgsSticker`.
-- @tparam string name Short name of sticker set, to be used in t.me/addstickers/ URLs (e.g., animals). Can contain only english letters, digits and underscores. Must begin with a letter, can't contain consecutive underscores and must end in ` by <bot username>`. `<bot_username>` is case insensitive. 1-64 characters.
-- @tparam string title Sticker set title, 1-64 characters.
-- @tparam ?InputFile|string|nil pngSticker **PNG** image with the sticker, must be up to 512 kilobytes in size, dimensions must not exceed 512px, and either width or height must be exactly 512px. Pass a file_id as a String to send a file that already exists on the Telegram servers, pass an HTTP URL as a String for Telegram to get a file from the Internet, or upload a new one using multipart/form-data.
-- @tparam ?InputFile tgsSticker **TGS** animation with the sticker, uploaded using multipart/form-data. See https://core.telegram.org/animated_stickers#technical-requirements for technical requirements.
-- @tparam string emojis One or more emoji corresponding to the sticker.
-- @tparam ?boolean containsMasks Pass True, if a set of mask stickers should be created.
-- @tparam ?MaskPosition maskPosition A MaskPosition object for position where the mask should be placed on faces.
-- @treturn boolean `true` on success.
-- @raise Error on failure.
function User:createNewStickerSet(name, title, pngSticker, tgsSticker, emojis, containsMasks, maskPosition)
    return call("createNewStickerSet", self.id, name, title, pngSticker, tgsSticker, emojis, containsMasks, maskPosition)
end

--- Use this method to add a new sticker to a set created by the bot.
-- You **must** use exactly one of the fields `pngSticker` or `tgsSticker`.
-- Animated stickers can be added to animated sticker sets and only to them.
-- Animated sticker sets can have up to 50 stickers. Static sticker sets can have up to 120 stickers.
-- @tparam string name Sticker set name.
-- @tparam ?InputFile|string|nil pngSticker **PNG** image with the sticker, must be up to 512 kilobytes in size, dimensions must not exceed 512px, and either width or height must be exactly 512px. Pass a file_id as a String to send a file that already exists on the Telegram servers, pass an HTTP URL as a String for Telegram to get a file from the Internet, or upload a new one using multipart/form-data.
-- @tparam ?InputFile tgsSticker **TGS** animation with the sticker, uploaded using multipart/form-data. See https://core.telegram.org/animated_stickers#technical-requirements for technical requirements.
-- @tparam string emojis One or more emoji corresponding to the sticker.
-- @tparam ?MaskPosition maskPosition A MaskPosition object for position where the mask should be placed on faces.
-- @treturn boolean `true` on success.
-- @raise Error on failure.
function User:addStickerToSet(name, pngSticker, tgsSticker, emojis, maskPosition)
    return call("addStickerSet", self.id, name, pngSticker, tgsSticker, emojis, maskPosition)
end

--- Use this method to set the thumbnail of a sticker set. Animated thumbnails can be set for animated sticker sets only.
-- @tparam string name Sticker set name.
-- @tparam ?InputFile|string|nil A PNG image with the thumbnail, must be up to 128 kilobytes in size and have width and height exactly 100px, or a TGS animation with the thumbnail up to 32 kilobytes in size; see https://core.telegram.org/animated_stickers#technical-requirements for animated sticker technical requirements. Pass a file_id as a String to send a file that already exists on the Telegram servers, pass an HTTP URL as a String for Telegram to get a file from the Internet, or upload a new one using multipart/form-data. Animated sticker set thumbnail can't be uploaded via HTTP URL.
-- @treturn boolean `true` on success.
-- @raise Error on failure.
function User:setStickerSetThumb(name, thumb)
    return call("setStickerSetThumb", name, self.id, thumb)
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
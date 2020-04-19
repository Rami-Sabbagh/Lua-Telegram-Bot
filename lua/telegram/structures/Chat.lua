--- Telegram chat object.
-- This object represents a chat.
-- @classmod Chat

local class = require("middleclass")

--local ChatPermissions = require("telegram.structures.ChatPermissions")
--local ChatPhoto = require("telegram.structures.ChatPhoto")
local Message -- Required inside initialize to avoid loading-loop

local Chat = class("telegram.structures.Chat")

--- Create a new chat object using data returned by Telegram Bot API.
-- @tparam table data The chat data returned by Telegram Bot API.
-- @treturn Chat The new created chat object.
function Chat:initialize(data)

    --Load remaining modules
    Message = Message or require("telegram.structures.Message")

    --- Unique identifier for this chat (number).
    self.id = data.id

    --- Type of chat (string).
    -- can be either `private`, `group`, `supergroup` or `channel`.
    self.type = data.type

    --- Optional fields.
    -- @section optional_fields

    --- Username, for private chats, supergroups and channels if available (string).
    self.username = data.username

    --- First name of the other party in a private chat (string).
    self.firstName = data.first_name

    --- Last name of the other party in a private chat (string).
    self.lastName = data.last_name

    --- Chat photo (ChatPhoto).
    -- Returned only in `getChat`.
    -- @see telegram.getChat
    self.photo = data.photo and ChatPhoto(data.photo)

    --- Description, for groups, supergroups and channel chats (string).
    -- Returned only in `getChat`.
    -- @see telegram.getChat
    self.description = data.description

    --- Chat invite link, for groups, supergroups and channel chats (string).
    -- Each administrator in a chat generates their own invite links,
    -- so the bot must first generate the link using `exportChatInviteLink`.
    -- Returned only in `getChat`.
    -- @see telegram.exportChatInviteLink
    -- @see telegram.getChat
    self.inviteLink = data.inviteLink

    --- Pinned message, for groups, supergroups and channels (Message).
    -- Returned only in `getChat`.
    -- @see telegram.getChat
    self.pinnedMessage = data.pinned_message and Message(data.pinned_message)

    --- Default chat member permissions, for groups and supergroups (ChatPermissions).
    -- Returned only in `getChat`.
    -- @see telegram.getChat
    self.permissions = data.permissions and ChatPermissions(data.permissions)

    --- For supergroups, the minimum allowed delay between consecutive messages
    -- sent by each unpriviledged user (number).
    -- Returned only in `getChat`.
    -- @see telegram.getChat
    self.slowModeDelay = data.slow_mode_delay

    --- For supergroups, name of group sticker set (string).
    -- Returned only in `getChat`.
    -- @see telegram.getChat
    self.stickerSetName = data.stickerSetName

    --- True, if the bot can change the group sticker set (boolean).
    -- Returned only in `getChat`.
    -- @see telegram.getChat
    self.canSetStickerSet = data.can_set_sticker_set

    ---
    -- @section end

end

---Call a function passing it's errors to the previous error level.
local function call(func, ...)
    local ok, a,b,c,d,e,f = pcall(require("telegram")[func], ...)
    if not ok then error(tostring(a), 3) end
    return a,b,c,d,e,f
end

--- Use this method to send text messages.
-- @tparam string text Text of the message to be sent, 1-4096 characters after entities parsing.
-- @tparam ?string parseMode `Markdown` or `HTML` if you want some markdown in the bot's messages.
-- @tparam ?boolean disableWebPagePreview Disables link previews for links in this message.
-- @tparam ?boolean disableNotification Sends the message silently. Users will receive a notification with no sound.
-- @tparam ?number replyToMessageID If the message is a reply, ID of the original message.
-- @tparam ?InlineKeyboardMarkup|ReplyKeyboardMarkup|ReplyKeyboardRemove|ForceReply replyMarkup Additional interface options. An object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
-- @treturn Message The sent message.
-- @raise Error on failure.
function Chat:sendMessage(text, parseMode, disableWebPagePreview, disableNotification, replyToMessageID, replyMarkup)
    return call("sendMessage", self.id, text, parseMode, disableWebPagePreview, disableNotification, replyToMessageID, replyMarkup)
end

return Chat
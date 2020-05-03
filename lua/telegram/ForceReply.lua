--- Telegram force reply object.
-- Upon receiving a message with this object,
-- Telegram clients will display a reply interface to the user
-- (act as if the user has selected the bot‘s message and tapped ’Reply').
-- This can be extremely useful if you want to create user-friendly step-by-step interfaces
-- without having to sacrifice [privacy mode](https://core.telegram.org/bots#privacy-mode).
-- @classmod ForceReply

local class = require("middleclass")

local ForceReply = class("telegram.structures.ForceReply")

--- Create a new ForceReply object.
-- @tparam ?boolean selective Use this parameter if you want to force reply from specific users only.
--   Targets: 1) users that are `@mentioned` in the text of the Message object;
--   2) if the bot's message is a reply (has replyToMessageId), sender of the original message.
-- @treturn ForceReply The new created ForceReply object.
-- @usage local ForceReply = telegram.structures.ForceReply(selective)
function ForceReply:initialize(selective)

    --- Shows reply interface to the user, as if they manually selected the bot‘s message and tapped ’Reply' (`true`).
    self.forceReply = true

    --- Optional fields.
    -- @section optional_fields

    --- Optional. Use this parameter if you want to force reply from specific users only.
    -- Targets: 1) users that are `@mentioned` in the text of the Message object;
    -- 2) if the bot's message is a reply (has reply_to_message_id), sender of the original message.
    -- (boolean or nil)
    self.selective = selective

    ---
    -- @section end

end

--- Get the object's data in telegram's API format, to be sent using a method.
-- @treturn table The object's data in telegram's API format.
function ForceReply:getData()
    return {
        force_reply = self.forceReply,
        selective = self.selective
    }
end

return ForceReply
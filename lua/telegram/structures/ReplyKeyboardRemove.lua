--- Telegram reply keyboard remove object.
-- Upon receiving a message with this object,
-- Telegram clients will remove the current custom keyboard and display the default letter-keyboard.
-- By default, custom keyboards are displayed until a new keyboard is sent by a bot.
-- An exception is made for one-time keyboards that are hidden immediately after the user presses a button.
-- @see ReplyKeyboardMarkup
-- @classmod ReplyKeyboardRemove

local class = require("middleclass")

local ReplyKeyboardRemove = class("telegram.structures.ReplyKeyboardRemove")

--- Create a new ReplyKeyboardRemove object.
-- @tparam ?boolean selective Use this parameter if you want to remove the keyboard for specific users only.
--   Targets: 1) users that are `@mentioned` in the text of the Message object;
--   2) if the bot's message is a reply (has replyToMessageId), sender of the original message.
-- @treturn ReplyKeyboardRemove The new created ReplyKeyboardRemove object.
-- @usage local replyKeyboardRemove = telegram.structures.ReplyKeyboardRemove(selective)
function ReplyKeyboardRemove:initialize(selective)

    --- Requests clients to remove the custom keyboard (user will not be able to summon this keyboard; if you want to hide the keyboard from sight but keep it accessible, use oneTimeKeyboard in ReplyKeyboardMarkup) (`true`).
    self.removeKeyboard = true

    --- Optional fields.
    -- @section optional_fields

    --- Use this parameter if you want to remove the keyboard for specific users only.
    -- Targets: 1) users that are `@mentioned` in the text of the Message object;
    -- 2) if the bot's message is a reply (has reply_to_message_id), sender of the original message.
    -- (boolean).
    self.selective = selective

    ---
    -- @section end

end

--- Get the object's data in telegram's API format, to be sent using a method.
-- @treturn table The object's data in telegram's API format.
function ReplyKeyboardRemove:getData()
    return {
        remove_keyboard = self.removeKeyboard,
        selective = self.selective
    }
end

return ReplyKeyboardRemove
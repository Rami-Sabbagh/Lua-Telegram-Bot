--- Telegram inline keyboard markup object.
-- This object represents an [inline keyboard](https://core.telegram.org/bots#inline-keyboards-and-on-the-fly-updating) that appears right next to the message it belongs to.
-- @classmod InlineKeyboardMarkup

local class = require("middleclass")

local InlineKeyboardMarkup = class("telegram.InlineKeyboardMarkup")

--- Create a new InlineKeyboardMarkup object.
-- @tparam {{InlineKeyboardMarkup}} keyboard Array of keyboard rows, each row is an array of InlineKeyboardButton.
-- @treturn InlineKeyboardMarkup The new created InlineKeyboardMarkup object.
-- @usage local InlineKeyboardMarkup = telegram.structures.InlineKeyboardMarkup(keyboard)
function InlineKeyboardMarkup:initialize(keyboard)

    --- Array of button rows, each represented by an Array of `InlineKeyboardButton` objects.
    self.inlineKeyboard = keyboard

end

--- Get the object's data in telegram's API format, to be sent using a method.
-- @treturn table The object's data in telegram's API format.
function InlineKeyboardMarkup:getData()
    local keyboard = {}

    for rid, row in pairs(self.keyboard) do
        local clonedRow = {}
        for bid, button in pairs(row) do
            clonedRow[bid] = button:getData()
        end
        keyboard[rid] = clonedRow
    end

    return {
        inline_keyboard = keyboard
    }
end

return InlineKeyboardMarkup
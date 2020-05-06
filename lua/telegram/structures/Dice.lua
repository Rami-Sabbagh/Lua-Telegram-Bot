--- Telegram dice object.
-- This object represents a dice with random value from 1 to 6. (Yes, we're aware of the “proper” singular of die. But it's awkward, and we decided to help it change. One dice at a time!).
-- @classmod Dice

local class = require("middleclass")

local Dice = class("telegram.structures.Dice")

--- Create a new dice object using data returned by Telegram Bot API.
-- @tparam table data The dice data returned by Telegram Bot API.
-- @treturn Chat The new created dice object.
function Dice:initialize(data)

    --- Emoji on which the dice throw animation is based (string).
    self.emoji = data.emoji

    --- Emoji on which the dice throw animation is based (number).
    self.value = data.value

end

--- Operators overrides.
-- @section operators_overrides

--- Test if the 2 dice objects are equal (same emoji, and same value).
-- @tparam Dice user The dice to compare with.
-- @treturn boolean `true` if they're the same.
function Dice:__eq(dice)
    return (self.emoji == dice.emoji) and (self.value == dice.emoji)
end

return Dice
--- Telegram update object.
-- This object represents an incoming update.
-- At most one of the optional parameters can be present in any given update.
-- @classmod Update

local class = require("middleclass")

local Message = require("telegram.structures.Message")
--InlineQuey
--ChoseInlineResult
--ShippingQuery
--PreCheckoutQuery
--Poll
--PollAnswer

local Update = class("telegram.structures.Update")

--- Create a new update object using data returned by Telegram Bot API.
-- @tparam table data The update data returned by Telegram Bot API.
-- @treturn MessageEntity The new created update data object.
function Update:initialize(data)

end

return Update
--- Telegram poll option object.
-- This object contains information about one answer option in a poll.
-- @classmod PollOption

local class = require("middleclass")

local PollOption = class("telegram.structures.PollOption")

--- Create a new poll option object using data returned by Telegram Bot API.
-- @tparam table data The poll option data returned by Telegram Bot API.
-- @treturn PollOption The new created poll option object.
function PollOption:initialize(data)

    --- Option text, 1-100 characters (string).
    self.text = data.text

    --- Number of users that voted for this option (number).
    self.voterCount = data.voter_count

end

return PollOption
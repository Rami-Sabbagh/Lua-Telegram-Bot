--- Telegram location object.
-- This object represents a point on the map.
-- @classmod Location

local class = require("middleclass")

local Location = class("telegram.structures.Location")

--- Create a new location object using data returned by Telegram Bot API.
-- @tparam table data The location data returned by Telegram Bot API.
-- @treturn Location The new created location object.
function Location:initialize(data)

    --- Longitude as defined by sender (number).
    self.longitude = data.longitude

    --- Latitude as defined by sender (number).
    self.latitude = data.latitude

end

return Location
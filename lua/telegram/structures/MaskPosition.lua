--- Telegram mask position object.
-- This object describes the position on faces where a mask should be placed by default.
-- @classmod MaskPosition

local class = require("middleclass")

local MaskPosition = class("telegram.structures.MaskPosition")

--- Create a new MaskPosition object.
-- @tparam string point The part of the face relative to which the mask should be placed. One of `forehead`, `eyes`, `mouth`, or `chin`.
-- @tparam number xShift Shift by X-axis measured in widths of the mask scaled to the face size, from left to right. For example, choosing -1.0 will place mask just to the left of the default mask position.
-- @tparam number yShift Shift by Y-axis measured in heights of the mask scaled to the face size, from top to bottom. For example, 1.0 will place the mask just below the default mask position.
-- @tparam number scale Mask scaling coefficient. For example, 2.0 means double size.
-- @treturn MaskPosition The new created MaskPosition object.
-- @usage local maskPosition = telegram.structures.MaskPosition(point, xShift, yShift, scale)
function MaskPosition:initialize(point, xShift, yShift, scale)

    --- The part of the face relative to which the mask should be placed. One of `forehead`, `eyes`, `mouth`, or `chin`. (string).
    self.point = point

    --- Shift by X-axis measured in widths of the mask scaled to the face size, from left to right. For example, choosing -1.0 will place mask just to the left of the default mask position. (number).
    self.xShift = xShift

    --- Shift by Y-axis measured in heights of the mask scaled to the face size, from top to bottom. For example, 1.0 will place the mask just below the default mask position. (number).
    self.yShift = yShift

    --- Mask scaling coefficient. For example, 2.0 means double size. (number).
    self.scale = scale

end

--- Get the object's data in telegram's API format, to be sent using a method.
-- @treturn table The object's data in telegram's API format.
function MaskPosition:getData()
    return {
        point = self.point,
        x_shift = self.xShift,
        y_shift = self.yShift,
        scale = self.scale
    }
end

return MaskPosition
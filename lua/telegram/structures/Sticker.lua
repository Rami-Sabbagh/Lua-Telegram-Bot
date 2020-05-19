--- Telegram sticker object.
-- This object represents a sticker.
-- @classmod Sticker

local class = require("middleclass")

local MaskPosition = require("telegram.structures.MaskPosition")
local PhotoSize = require("telegram.structures.PhotoSize")

local Sticker = class("telegram.structures.Sticker")

--- Create a new sticker object using data returned by Telegram Bot API.
-- @tparam table data The sticker data returned by Telegram Bot API.
-- @treturn Sticker The new created sticker object.
function Sticker:initialize(data)

    --- Identifier for this file, which can be used to download or reuse the file (string).
    self.fileID = data.file_id

    --- Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file. (string).
    self.fileUniqueID = data.file_unique_id

    --- Sticker width (number).
    self.width = data.width

    --- Sticker height (number).
    self.height = data.height

    --- True, if the sticker is animated. (boolean).
    self.isAnimated = data.is_animated

    --- Optional fields.
    -- @section optional_fields

    --- Sticker thumbnail in the .WEBP or .JPG format. (PhotoSize).
    self.thumb = data.thumb and PhotoSize(data.thumb)

    --- Emoji associated with the sticker. (string).
    self.emoji = data.emoji

    --- Name of the sticker set to which the sticker belongs. (string).
    self.setName = data.set_name

    --- For mask stickers, the position where the mask should be placed. (MaskPosition).
    self.maskPosition = data.mask_position and MaskPosition(data.mask_position.point, data.mask_position.x_shift, data.mask_position.y_shift, data.mask_position.scale)

    --- File size (number).
    self.fileSize = data.file_size

    ---
    -- @section end

end

--- Call a function passing it's errors to the previous error level.
local function call(func, ...)
    local ok, a,b,c,d,e,f = pcall(require("telegram")[func], ...)
    if not ok then error(tostring(a), 3) end
    return a,b,c,d,e,f
end

--- Use this method to get basic info about a file and prepare it for downloading. For the moment, bots can download files of up to 20MB in size.
-- @treturn File The requested file object.
-- @raise Error on failure.
function Sticker:getFile()
    return call("getFile", self.fileID)
end

return Sticker
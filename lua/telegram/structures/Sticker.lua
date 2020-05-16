--- Telegram sticker object.
-- This object represents a sticker.
-- @classmod Sticker

local class = require("middleclass")

local MaskPosition = require("telegram.structures.MaskPosition")
local PhotoSize = require("telegram.structures.PhotoSize")

local Sticker = class("telegram.structures.Sticker")

--- Create a new sticker object using data returned by Telegram Bot API.
-- @tparam table data The sticker data returned by Telegram Bot API.
-- @treturn Chat The new created sticker object.
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

return Sticker
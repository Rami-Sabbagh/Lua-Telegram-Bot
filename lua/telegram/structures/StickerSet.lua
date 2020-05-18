--- Telegram sticker set object.
-- This object represents a sticker set.
-- @classmod StickerSet

local class = require("middleclass")

local PhotoSize = require("telegram.structures.PhotoSize")
local Sticker = require("telegram.structures.Sticker")

local StickerSet = class("telegram.structures.StickerSet")

--- Create a new sticker set object using data returned by Telegram Bot API.
-- @tparam table data The sticker set data returned by Telegram Bot API.
-- @treturn Chat The new created sticker set object.
function StickerSet:initialize(data)

    --- Sticker set name (string).
    self.name = data.name

    --- Sticker set title (string).
    self.title = data.name

    --- True, if the sticker set contains [animated stickers](https://telegram.org/blog/animated-stickers) (boolean).
    self.isAnimated = data.is_animated

    --- True, if the sticker set contains masks (boolean).
    self.containsMasks = data.contains_masks

    --- List of all set stickers (Array of Sticker).
    self.stickers = {}
    for k,v in pairs(data.stickers) do self.stickers[k] = Sticker(v) end

    --- Optional fields.
    -- @section optional_fields

    --- Sticker set thumbnail in the .WEBP or .TGS format (PhotoSize).
    self.thumb = data.thumb and PhotoSize(data.thumb)

    ---
    -- @section end

end

return StickerSet
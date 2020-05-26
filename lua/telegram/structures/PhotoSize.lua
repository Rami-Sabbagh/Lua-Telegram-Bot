--- Telegram photo size object.
-- This object represents one size of a photo or a file / sticker thumbnail.
-- @classmod PhotoSize

local class = require("middleclass")

local PhotoSize = class("telegram.structures.PhotoSize")

--- Create a new photo size object using data returned by Telegram Bot API.
-- @tparam table data The photo size data returned by Telegram Bot API.
-- @treturn MessageEntity The new created photo size data object.
function PhotoSize:initialize(data)

    --- Identifier for this file, which can be used to download or reuse the file (string).
    self.fileID = data.file_id

    --- Unique identifier for this file, which is supposed to be the same over time and for different bots (string).
    -- Can't be used to download or reuse the file.
    self.fileUniqueID = data.file_unique_id

    --- Photo width (number).
    self.width = data.width

    --- Photo height (number).
    self.height = data.height

    --- Optional fields.
    -- @section optional_fields

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
function PhotoSize:getFile()
    return call("getFile", self.fileID)
end

return PhotoSize
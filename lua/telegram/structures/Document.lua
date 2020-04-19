--- Telegram document object.
-- This object represents a general file (as opposed to photos, voice messages and audio files).
-- @classmod Document

local class = require("middleclass")

local PhotoSize = require("telegram.structures.PhotoSize")

local Document = class("telegram.structures.Document")

--- Create a new document object using data returned by Telegram Bot API.
-- @tparam table data The document data returned by Telegram Bot API.
-- @treturn Chat The new created document object.
function Document:initialize(data)

    --- Identifier for this file, which can be used to download or reuse the file (string).
    self.fileID = data.file_id

    --- Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file (string).
    self.fileUniqueID = data.file_unique_id

    --- Optional fields.
    -- @section optional_fields

    --- Document thumbnail as defined by sender (PhotoSize).
    self.thumb = data.thumb and PhotoSize(data.thumb)

    --- Original filename as defined by sender (string).
    self.fileName = data.file_name

    --- MIME type of the file as defined by sender (string).
    self.mimeType = data.mime_type

    --- File size (number).
    self.fileSize = data.file_size

    ---
    -- @section end

end

---Call a function passing it's errors to the previous error level.
local function call(func, ...)
    local ok, a,b,c,d,e,f = pcall(require("telegram")[func], ...)
    if not ok then error(tostring(a), 3) end
    return a,b,c,d,e,f
end

--- Use this method to get basic info about a file and prepare it for downloading. For the moment, bots can download files of up to 20MB in size.
-- @treturn File The requested file object.
-- @raise Error on failure.
function Document:getFile()
    return call("getFile", self.fileID)
end

return Document
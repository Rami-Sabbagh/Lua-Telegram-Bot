--- Telegram file object.
-- This object represents a file ready to be downloaded. The file can be downloaded via the link https://api.telegram.org/file/bot<token>/<file_path>.
-- It is guaranteed that the link will be valid for at least 1 hour.
-- When the link expires, a new one can be requested by calling getFile.
-- @classmod File

local class = require("middleclass")

local File = class("telegram.structures.File")

--- Create a new file object using data returned by Telegram Bot API.
-- @tparam table data The file data returned by Telegram Bot API.
-- @treturn Chat The new created file object.
function File:initialize(data)

    --- Identifier for this file, which can be used to download or reuse the file (string).
    self.fileID = data.file_id

    --- Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file (string).
    self.fileUniqueId = data.file_unique_id

    --- Optional fields.
    -- @section optional_fields

    --- File size, if known (number).
    self.fileSize = data.file_size

    --- File path. Use https://api.telegram.org/file/bot<token>/<file_path> to get the file (string).
    self.filePath = data.file_path

    ---
    -- @section end
end

--- Get the file download URL (if exists).
-- @treturn ?string The download URL if exists.
function File:getURL()
    if not self.filePath then return end
    return string.format("https://api.telegram.org/file/bot%s/%s", require("telegram").getToken(), self.filePath)
end

return File
--- Telegram voice object.
-- This object represents a voice note.
-- @classmod Voice

local class = require("middleclass")

local Voice = class("telegram.structures.Voice")

--- Create a new voice object using data returned by Telegram Bot API.
-- @tparam table data The voice data returned by Telegram Bot API.
-- @treturn Voice The new created voice object.
function Voice:initialize(data)

    --- Identifier for this file, which can be used to download or reuse the file (string).
    self.fileID = data.fileID

    --- Unique identifier for this file, which is supposed to be the same over time and for different bots. can't be used to download or reuse the file. (string).
    self.fileUniqueID = data.file_unique_id

    --- Duration of the audio in seconds as defined by sender (number).
    self.duration = data.duration

    --- Optional fields.
    -- @section optional_fields

    --- MIME type of the file as defined by sender (string).
    self.mimeType = data.mime_type

    --- File size (number).
    self.fileSize = data.file_size

end

return Voice
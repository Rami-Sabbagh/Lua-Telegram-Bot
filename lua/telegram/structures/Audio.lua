--- Telegram audio object.
-- This object represents an audio file to be treated as music by the Telegram clients.
-- @classmod Audio

local class = require("middleclass")

local PhotoSize = require("telegram.structures.PhotoSize")

local Audio = class("telegram.structures.Audio")

--- Create a new audio object using data returned by Telegram Bot API.
-- @tparam table data The audio data returned by Telegram Bot API.
-- @treturn Audio The new created audio object.
function Audio:initialize(data)

    --- Identifier for this file, which can be used to download or reuse the file (string).
    self.fileID = data.fileID

    --- Unique identifier for this file, which is supposed to be the same over time and for different bots. can't be used to download or reuse the file. (string).
    self.fileUniqueID = data.file_unique_id

    --- Duration of the audio in seconds as defined by sender (number).
    self.duration = data.duration

    --- Optional fields.
    -- @section optional_fields

    --- Performer of the audio as defined by sender or by audio tags (string).
    self.performer = data.performer

    --- Title of the audio as defined by sender or by audio tags (string).
    self.title = data.title

    --- MIME type of the file as defined by sender (string).
    self.mimeType = data.mime_type

    --- File size (number).
    self.fileSize = data.file_size

    --- Thumbnail of the album cover to which the music file belongs (PhotoSize).
    self.thumb = data.thumb and PhotoSize(data.thumb)

    ---
    -- @section end

end

return Audio
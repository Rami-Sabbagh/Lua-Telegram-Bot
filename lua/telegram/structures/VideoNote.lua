--- Telegram video note object.
-- This object represents a video message (available in Telegram apps as of v.4.0).
-- @classmod VideoNote

local class = require("middleclass")

local PhotoSize = require("telegram.structures.PhotoSize")

local VideoNote = class("telegram.structure.VideoNote")

--- Create a new video note object using data returned by Telegram Bot API.
-- @tparam table data The video note data returned by Telegram Bot API.
-- @treturn VideoNote The new created video note object.
function VideoNote:initialize(data)

    --- Identifier for this file, which can be used to download or reuse the file (string).
    self.fileID = data.fileID

    --- Unique identifier for this file, which is supposed to be the same over time and for different bots. can't be used to download or reuse the file. (string).
    self.fileUniqueID = data.file_unique_id

    --- Video width and height (diameter of the video message) as defined by sender (number).
    self.length = data.length

    --- Duration of the video in seconds as defined by sender (number).
    self.duration = data.duration

    --- Optional fields.
    -- @section optional_fields

    --- Video thumbnail (PhotoSize).
    self.thumb = data.thumb and PhotoSize(data.thumb)

    --- File size (number).
    self.fileSize = data.file_size

    ---
    -- @section end

end

return VideoNote
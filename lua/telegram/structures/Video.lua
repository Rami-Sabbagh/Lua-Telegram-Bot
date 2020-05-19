--- Telegram video object.
-- This object represents a video file.
-- @classmod Video

local class = require("middleclass")

local PhotoSize = require("telegram.structures.PhotoSize")

local Video = class("telegram.structures.Video")

--- Create a new video object using data returned by Telegram Bot API.
-- @tparam table data The video data returned by Telegram Bot API.
-- @treturn Video The new created video object.
function Video:initialize(data)

    --- Identifier for this file, which can be used to download or reuse the file (string).
    self.fileID = data.file_id

    --- Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file. (string).
    self.fileUniqueID = data.file_unique_id

    --- Video width as defined by sender (number).
    self.width = data.width

    --- Video height as defined by sender (number).
    self.height = data.height

    --- Duration of the video in seconds as defined by sender (number).
    self.duration = data.duration

    --- Optional fields.
    -- @section optional_fields

    --- Video thumbnail (PhotoSize).
    self.thumb = data.thumb and PhotoSize(data.thumb)

    --- Mime type of a file as defined by sender (string).
    self.mimeType = data.mime_type

    --- File size (number).
    self.fileSize = data.file_size

    ---
    -- @section end

end

return Video
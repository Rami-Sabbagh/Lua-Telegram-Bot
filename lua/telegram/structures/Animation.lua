--- Telegram animation object.
-- This object represents an animation file (GIF or H.264/MPEG-4 AVC video without sound).
-- @classmod Animation

local class = require("middleclass")

local PhotoSize = require("telegram.structures.PhotoSize")

local Animation = class("telegram.structures.Animation")

--- Create a new animation object using data returned by Telegram Bot API.
-- @tparam table data The animation data returned by Telegram Bot API.
-- @treturn Animation The new created animation object.
function Animation:initialize(data)

    --- Identifier for this file, which can be used to download or reuse the file (string).
    self.fileID = data.fileID

    --- Unique identifier for this file, which is supposed to be the same over time and for different bots. can't be used to download or reuse the file. (string).
    self.fileUniqueID = data.file_unique_id

    --- Video width as defined by sender (number).
    self.width = data.width

    --- Video height as defined by sender (number).
    self.height = data.height

    --- Duration of the video in seconds as defined by sender (number).
    self.duration = data.duration

    --- Optional fields.
    -- @section optional_fields

    --- Animation thumbnail as defined by sender (PhotoSize).
    self.thumb = data.thumb and PhotoSize(data.thumb)

    --- Original animation filename as defined by sender (string).
    self.fileName = data.file_name

    --- MIME type of the file as defined by sender (string).
    self.mimeType = data.mime_type

    --- File size (number).
    self.fileSize = data.file_size

    ---
    -- @section end

end

return Animation
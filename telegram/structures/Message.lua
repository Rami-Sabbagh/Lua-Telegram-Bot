--- Telegram message object.
-- This object represents a message.
-- @classmod Message

local class = require("middleclass")

local Animation = require("telegram.structures.Animation")
local Audio = require("telegram.structures.Audio")
local Chat = require("telegram.structures.Chat")
local Contact = require("telegram.structures.Contact")
local Dice = require("telegram.structures.Dice")
local Document = require("telegram.structures.Document")
local Game = require("telegram.structures.Game")
local InlineKeyboardMarkup = require("telegram.structures.InlineKeyboardMarkup")
local Invoice = require("telegram.structures.Invoice")
local Location = require("telegram.structures.Location")
local MessageEntity = require("telegram.structures.MessageEntity")
local PassportData = require("telegram.structures.PassportData")
local PhotoSize = require("telegram.structures.PhotoSize")
local Poll = require("telegram.structures.Poll")
local Sticker = require("telegram.structures.Sticker")
local SuccessfulPayment = require("telegram.structures.SuccessfulPayment")
local User = require("telegram.structures.User")
local Venue = require("telegram.structures.Venue")
local Video = require("telegram.structures.Video")
local VideoNote = require("telegram.structures.VideoNote")
local Voice = require("telegram.structures.Voice")

local Message = require("telegram.structures.Message")

return Message
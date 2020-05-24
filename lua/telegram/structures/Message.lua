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
--TODO: local InlineKeyboardMarkup = require("telegram.structures.InlineKeyboardMarkup")
--local Invoice = require("telegram.structures.Invoice")
local Location = require("telegram.structures.Location")
local MessageEntity = require("telegram.structures.MessageEntity")
--local PassportData = require("telegram.structures.PassportData")
local PhotoSize = require("telegram.structures.PhotoSize")
--local Poll = require("telegram.structures.Poll")
local Sticker = require("telegram.structures.Sticker")
--local SuccessfulPayment = require("telegram.structures.SuccessfulPayment")
local User = require("telegram.structures.User")
local Venue = require("telegram.structures.Venue")
local Video = require("telegram.structures.Video")
local VideoNote = require("telegram.structures.VideoNote")
local Voice = require("telegram.structures.Voice")

local Message = class("telegram.structures.Message")

--- Create a new message object using data returned by Telegram Bot API.
-- @tparam table data The message data returned by Telegram Bot API.
-- @treturn Chat The new created message object.
function Message:initialize(data)

    --- Unique message identifier inside this chat (number).
    self.messageID = data.message_id

    --- Date the message was sent in Unix time (number).
    self.date = data.date

    --- Conversation the message belongs to (Chat).
    self.chat = Chat(data.chat)

    --- Optional fields.
    -- @section optional_fields

    --- Sender, empty for messages sent to channels (User).
    self.from = data.from and User(data.from)

    --- For forwarded messages, sender of the original message (User).
    self.forwardFrom = data.forward_from and User(data.forward_from)

    --- For messages forwarded from channels, information about the original channel (Chat).
    self.forwardFromChat = data.forward_from_chat and User(data.forward_from_chat)

    --- For messages forwarded from channels, identifier of the original message in the channel (number).
    self.forwardFromMessageID = data.forward_from_message_id

    --- For messages forwarded from channels, signature of the post author if present (string).
    self.forwardSignature = data.forward_signature

    --- Sender's name for messages forwarded from users who disallow adding a link to their account in forwarded messages (string).
    self.forwardSenderName = data.forward_sender_name

    --- For forwarded messages, date the original message was sent in Unix time (number).
    self.forwardDate = data.forward_date

    --- For replies, the original message (Message).
    -- Note that the Message object in this field will not contain further replyToMessage fields even if it itself is a reply.
    self.replyToMessage = data.reply_to_message and Message(data.reply_to_message)

    --- Date the message was last edited in Unix time (number).
    self.editDate = data.edit_date

    --- The unique identifier of a media message group this message belongs to (string).
    self.mediaGroupID = data.media_group_id

    --- Signature of the post author for messages in channels (string).
    self.authorSignature = data.author_signature

    --- For text messages, the actual UTF-8 text of the message, 0-4096 characters (string).
    self.text = data.text

    --- For text messages, special entities like usernames, URLs, bot commands, etc. that appear in the text (Array of MessageEntity).
    -- @field self.entities
    if data.entities then
        self.entities = {}
        for k,v in ipairs(data.entities) do
            self.entities[k] = MessageEntity(v)
        end
    end

    --- For messages with a caption, special entities like usernames, URLs, bot commands, etc. that appear in the caption (Array of MessageEntity).
    -- @field self.captionEntities
    if data.caption_entities then
        self.captionEntities = {}
        for k,v in ipairs(data.caption_entities) do
            self.captionEntities[k] = MessageEntity(v)
        end
    end

    --- Message is an audio file, information about the file (Audio).
    self.audio = data.audio and Audio(data.audio)

    --- Message is a general file, information about the file (Document).
    self.document = data.document and Document(data.document)

    --- Message is an animation, information about the animation. For backward compatibility, when this field is set, the document field will also be set (Animation).
    self.animation = data.animation and Animation(data.animation)

    --- Message is a game, information about the game (Game).
    self.game = data.game and Game(data.game)

    --- Message is a photo, available sizes of the photo (Array of PhotoSize).
    -- @field self.photo
    if data.photo then
        self.photo = {}
        for k,v in ipairs(data.photo) do
            self.photo[k] = PhotoSize(v)
        end
    end

    --- Message is a sticker, information about the sticker (Sticker).
    self.sticker = data.sticker and Sticker(data.sticker)

    --- Message is a video, information about the video (Video).
    self.video = data.video and Video(data.video)

    --- Message is a voice message, information about the file (Voice).
    self.voice = data.voice and Voice(data.voice)

    --- Message is a [video note](https://telegram.org/blog/video-messages-and-telescope), information about the video message (VideoNote).
    self.videoNote = data.video_note and VideoNote(data.video_note)

    --- Caption for the animation, audio, document, photo, video or voice, 0-1024 characters (string).
    self.caption = data.caption

    --- Message is a shared contact, information about the contact (Contact).
    self.contact = data.contact and Contact(data.contact)

    --- Message is a shared location, information about the location (Location).
    self.location = data.location and Location(data.location)

    --- Message is a venue, information about the venue (Venue).
    self.venue = data.venue and Venue(data.venue)

    --TODO: poll

    --- Message is a dice with random value from 1 to 6 (Dice).
    self.dice = data.dice and Dice(data.dice)

    --- New members that were added to the group or supergroup and information about them (the bot itself may be one of these members) (Array of User).
    -- @field self.newChatMembers
    if data.new_chat_members then
        self.newChatMembers = {}
        for k,v in ipairs(data.new_chat_members) do
            self.newChatMembers[k] = User(v)
        end
    end

    --- A member was removed from the group, information about them (this member may be the bot itself) (User).
    self.leftChatMember = data.left_chat_member and User(data.left_chat_member)

    --- A chat title was changed to this value (string).
    self.newChatTitle = data.new_chat_title

    --- A chat photo was change to this value (Array of PhotoSize).
    -- @field self.newChatPhoto
    if data.new_chat_photo then
        self.newChatPhoto = {}
        for k,v in ipairs(data.new_chat_photo) do
            self.newChatPhoto[k] = PhotoSize(v)
        end
    end

    --- Service message: the chat photo was deleted (boolean) (True).
    self.deleteChatPhoto = data.delete_chat_photo

    --- Service message: the group has been created (boolean) (True).
    self.groupChatCreated = data.group_chat_created

    --- Service message: the supergroup has been created (boolean) (True).
    -- This field can‘t be received in a message coming through updates, because bot can’t be a member of a supergroup when it is created.
    -- It can only be found in replyToMessage if someone replies to a very first message in a directly created supergroup.
    self.supergroupChatCreated = data.supergroup_chat_created

    --- Service message: the channel has been created (boolean) (True).
    -- This field can‘t be received in a message coming through updates, because bot can’t be a member of a channel when it is created.
    -- It can only be found in replyToMessage if someone replies to a very first message in a channel.
    self.channelChatCreated = data.channel_chat_created

    --- The group has been migrated to a supergroup with the specified identifier (number).
    self.migrateToChatID = data.migrate_to_chat_id

    --- Specified message was pinned (Message).
    -- Note that the Message object in this field will not contain further replyToMessage fields even if it is itself a reply.
    self.pinnedMessage = data.pinned_message and Message(data.pinned_message)

    --TODO: invoice, successfuk_payment

    --- The domain name of the website on which the user has logged in (string).
    -- [More about Telegram Login](https://core.telegram.org/widgets/login).
    self.connectedWebsite = data.connected_website

    --TODO: passport_data

    --TODO: Inline keyboard attached to the message (InlineKeyboardMarkup).
    -- `login_url` buttons are represented as ordinary `url` buttons.
    --self.replyMarkup = data.reply_markup and InlineKeyboardMarkup(data.reply_markup)

    ---
    -- @section end
end

--- Call a function passing it's errors to the previous error level.
local function call(func, ...)
    local ok, a,b,c,d,e,f = pcall(require("telegram")[func], ...)
    if not ok then error(tostring(a), 3) end
    return a,b,c,d,e,f
end

--- Use this method to forward messages of any kind.
-- @tparam number|string chatID Unique identifier for the target chat or username of the target channel (in the format `@channelusername`).
-- @tparam ?boolean disableNotification Sends the message silently. Users will receive a notification with no sound.
-- @treturn Message The sent message.
-- @raise Error on failure.
function Message:forwardMessage(chatID, disableNotification)
    return call("forwardMessage", chatID, self.chat.id, disableNotification, self.messageID)
end

--- Use this method to pin a message in a group, a supergroup, or a channel.
-- he bot must be an administrator in the chat for this to work and must have the `canPinMessages` admin right in the supergroup or `canEditMessages` admin right in the channel.
-- @tparam ?boolean disableNotification Pass True, if it is not necessary to send a notification to all chat members about the new pinned message. Notifications are always disabled in channels.
-- @treturn boolean `true` on success.
-- @raise Error on failure.
function Message:pinChatMessage(disableNotification)
    return call("pinChatMessage", self.chat.id, self.messageID, disableNotification)
end

--- Updating messages Functions.
-- @section updating_messages

--- Use this method to delete a message, including service messages.
-- With the following limitations:
-- A message can only be deleted if it was sent less than 48 hours ago.
--
-- - A dice message in a private chat can only be deleted if it was sent more than 24 hours ago.
--
-- - Bots can delete outgoing messages in private chats, groups, and supergroups.
--
-- - Bots can delete incoming messages in private chats.
--
-- - Bots granted `canPostMessages` permissions can delete outgoing messages in channels.
--
-- - If the bot is an administrator of a group, it can delete any message there.
--
-- - If the bot has `canDeleteMessages` permission in a supergroup or a channel, it can delete any message there.
-- @treturn boolean `true` on success.
-- @raise Error on failure.
function Message:deleteMessage()
    return call("deleteMessage", self.chat.id, self.messageID)
end

--- Operators overrides.
-- @section operators_overrides

--- Test if the 2 message objects refer to the same message (by comparing their IDs).
-- @tparam Message message The message to compare with.
-- @treturn boolean `true` if they're the same.
function Message:__eq(message)
    return self.messageID == message.messageID
end

return Message
--- Lua-Telegram-Bot API.
-- Supports Bot API 4.8
-- @module telegram
local telegram = {}

-- Load the submodules.
telegram.json = require("telegram.modules.json")
telegram.request = require("telegram.modules.request")

-- Load the structures.
telegram.structures = require("telegram.structures")

--- Set the bot's authorization token
-- @tparam string token The bot's authorization token, e.x: (`123456:ABC-DEF1234ghIkl-zyx57W2v1u123ew11`).
function telegram.setToken(token)
    telegram.request("setToken", token)
end

--- Set the default timeout used for the API requests
-- @tparam number timeout The new timeout value, -1 for no timeout.
function telegram.setTimeout(timeout)
    telegram.request("setTimeout", timeout)
end

--- Use this method to receive incoming updates using long polling ([wiki](https://en.wikipedia.org/wiki/Push_technology#Long_polling)).
--
-- **Notes:**
--
-- 1. This method will not work if an outgoing webhook is set up.
--
-- 2. In order to avoid getting duplicate updates, recalculate offset after each server response.
--
-- @tparam ?number offset Identifier of the first update to be returned.
-- Must be greater by one than the highest among the identifiers of previously received updates.
-- By default, updates starting with the earliest unconfirmed update are returned.
-- An update is considered confirmed as soon as getUpdates is called with an offset higher than its update_id.
-- The negative offset can be specified to retrieve updates starting from -offset update from the end of the updates queue.
-- All previous updates will forgotten.
-- @tparam ?number limit Limits the number of updates to be retrieved. Values between 1—100 are accepted. Defaults to 100.
-- @tparam ?number timeout Timeout in seconds for long polling. Defaults to 0, i.e. usual short polling. Should be positive, short polling should be used for testing purposes only.
-- @tparam ?{string} allowedUpdates An array of the update types you want your bot to receive.
-- For example, specify `{“message”, “edited_channel_post”, “callback_query”}` to only receive updates of these types.
-- See Update for a complete list of available update types.
-- Specify an empty list to receive all updates regardless of type (default).
-- If not specified, the previous setting will be used.
-- @treturn {Update} Array of Update objects.
-- @raise Error on failure.
function telegram.getUpdates(offset, limit, timeout, allowedUpdates)
    local ok, data = telegram.request("getUpdates", {offset=offset, limit=limit, timeout=timeout, allowed_updates=allowedUpdates}, (timeout or 0) + 5)
    if not ok then return error(data) end
    for k,v in ipairs(data) do data[k] = telegram.structures.Update(v) end
    return data
end

--- A simple method for testing your bot's auth token, get information about the bot's user itself.
-- @treturn User The bot's user object.
-- @raise Error on failure.
function telegram.getMe()
    local ok, data = telegram.request("getMe")
    if not ok then return error(data) end
    return telegram.structures.User(data)
end

--- Use this method to send text messages.
-- @tparam number|string chatID Unique identifier for the target chat or username of the target supergroup or channel (in the format `@channelusername`).
-- @tparam string text Text of the message to be sent, 1-4096 characters after entities parsing.
-- @tparam ?string parseMode `Markdown` or `HTML` if you want some markdown in the bot's messages.
-- @tparam ?boolean disableWebPagePreview Disables link previews for links in this message.
-- @tparam ?boolean disableNotification Sends the message silently. Users will receive a notification with no sound.
-- @tparam ?number replyToMessageID If the message is a reply, ID of the original message.
-- @tparam ?InlineKeyboardMarkup|ReplyKeyboardMarkup|ReplyKeyboardRemove|ForceReply replyMarkup Additional interface options. An object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
-- @treturn Message The sent message.
-- @raise Error on failure.
function telegram.sendMessage(chatID, text, parseMode, disableWebPagePreview, disableNotification, replyToMessageID, replyMarkup)
    replyMarkup = replyMarkup and replyMarkup:getData()
    local ok, data = telegram.request("sendMessage", {chat_id=chatID, text=text, parse_mode=parseMode,
    disable_web_page_preview=disableWebPagePreview, disable_notification=disableNotification,
    reply_to_message_id=replyToMessageID, reply_markup=replyMarkup})
    if not ok then return error(data) end
    return telegram.structures.Message(data)
end

--- Use this method to send a dice, which will have a random value from 1 to 6.
-- (Yes, we're aware of the “_proper_” singular of die. But it's awkward, and we decided to help it change. One dice at a time!).
-- @tparam number|string chatID Unique identifier for the target chat or username of the target supergroup or channel (in the format `@channelusername`).
-- @tparam ?string emoji Emoji on which the dice throw animation is based. Currently, must be one of “🎲” or “🎯”. Defaults to “🎲”.
-- @tparam ?boolean disableNotification Sends the message silently. Users will receive a notification with no sound.
-- @tparam ?number replyToMessageID If the message is a reply, ID of the original message.
-- @tparam ?InlineKeyboardMarkup|ReplyKeyboardMarkup|ReplyKeyboardRemove|ForceReply replyMarkup Additional interface options. An object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
-- @treturn Message The sent message.
-- @raise Error on failure.
function telegram.sendDice(chatID, emoji, disableNotification, replyToMessageID, replyMarkup)
    replyMarkup = replyMarkup and replyMarkup:getData()
    local ok, data = telegram.request("sendDice", {chat_id=chatID, emoji=emoji, disable_notification=disableNotification,
    reply_to_message_id=replyToMessageID, reply_markup = replyMarkup})
    if not ok then return error(data) end
    return telegram.structures.Message(data)
end

--- Use this method to get basic info about a file and prepare it for downloading. For the moment, bots can download files of up to 20MB in size.
-- @tparam string fileID File identifier to get info about.
-- @treturn File The requested file object.
-- @raise Error on failure.
function telegram.getFile(fileID)
    local ok, data = telegram.request("getFile", {file_id=fileID})
    if not ok then return error(data) end
    return telegram.structures.File(data)
end

--- Use this method to pin a message in a group, a supergroup, or a channel.
-- he bot must be an administrator in the chat for this to work and must have the `canPinMessages` admin right in the supergroup or `canEditMessages` admin right in the channel.
-- @tparam number|string chatID Unique identifier for the target chat or username of the target supergroup or channel (in the format `@channelusername`).
-- @tparam number messageID Identifier of a message to pin.
-- @tparam ?boolean disableNotification Pass True, if it is not necessary to send a notification to all chat members about the new pinned message. Notifications are always disabled in channels.
-- @treturn boolean `true` on success.
-- @raise Error on failure.
function telegram.pinChatMessage(chatID, messageID, disableNotification)
    local ok, data = telegram.request("pinChatMessage", {chat_id=chatID, message_id=messageID, disable_notification=disableNotification})
    if not ok then return error(data) end
    return data
end

--- Use this method to unpin a message in a group, a supergroup, or a channel.
-- he bot must be an administrator in the chat for this to work and must have the `canPinMessages` admin right in the supergroup or `canEditMessages` admin right in the channel.
-- @tparam number|string chatID Unique identifier for the target chat or username of the target supergroup or channel (in the format `@channelusername`).
-- @treturn boolean `true` on success.
-- @raise Error on failure.
function telegram.unpinChatMessage(chatID)
    local ok, data = telegram.request("unpinChatMessage", {chat_id=chatID})
    if not ok then return error(data) end
    return data
end

--- Use this method to get up to date information about the chat (current name of the user for one-on-one conversations, current username of a user, group or channel, etc.).
-- @tparam number|string chatID Unique identifier for the target chat or username of the target supergroup or channel (in the format `@channelusername`).
-- @treturn Chat The requested chat object on success.
-- @raise Error on failure.
function telegram.getChat(chatID)
    local ok, data = telegram.request("getChat", {chat_id = chatID})
    if not ok then return error(data) end
    return telegram.structures.Chat(data)
end

--- Use this method to generate a new invite link for a chat; any previously generated link is revoked.
-- The bot must be an administrator in the chat for this to work and must have the appropriate admin rights.
-- @tparam number|string chatID Unique identifier for the target chat or username of the target supergroup or channel (in the format `@channelusername`).
-- @treturn string The exported invite link on success.
-- @raise Error on failure.
function telegram.exportChatInviteLink(chatID)
    local ok, data = telegram.request("exportChatInviteLink", {chat_id = chatID})
    if not ok then return error(data) end
    return data
end

--- Use this method to change the list of the bot's commands.
-- Command name must be between 1 and 32 characters.
-- Command description must be between 3 and 256 characters.
-- @tparam table commands A table which keys are the commands names, and values are the commands descriptions.
-- @treturn boolean `true` on success.
-- @raise Error on failure.
function telegram.setMyCommands(commands)
    local botCommands = {}
    for commandName, commandDescription in pairs(commands) do
        table.insert(botCommands, {command=commandName, description=commandDescription})
    end
    local ok, data = telegram.request("setMyCommands", {commands=botCommands})
    if not ok then return error(data) end
    return data
end

--- Use this method to get the current list of the bot's commands.
-- @treturn table A table which keys are the commands names, and values are the commands descriptions.
-- @raise Error on failure.
function telegram.getMyCommands()
    local ok, data = telegram.request("getMyCommands")
    if not ok then return error(data) end
    local commands = {}
    for _, command in ipairs(data) do
        commands[command.command] = command.description
    end
    return commands
end

return telegram
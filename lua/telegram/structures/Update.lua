--- Telegram update object.
-- This object represents an incoming update.
-- At most one of the optional parameters can be present in any given update.
-- @classmod Update

local class = require("middleclass")

local Message = require("telegram.structures.Message")
--InlineQuey
--ChoseInlineResult
--ShippingQuery
--PreCheckoutQuery
--Poll
--PollAnswer

local Update = class("telegram.structures.Update")

--- Create a new update object using data returned by Telegram Bot API.
-- @tparam table data The update data returned by Telegram Bot API.
-- @treturn MessageEntity The new created update data object.
function Update:initialize(data)

    --- The update‘s unique identifier (number).
    -- Update identifiers start from a certain positive number and increase sequentially.
    -- This ID becomes especially handy if you’re using Webhooks,
    -- since it allows you to ignore repeated updates or to restore the correct update sequence,
    -- should they get out of order.
    -- If there are no new updates for at least a week,
    -- then identifier of the next update will be chosen randomly instead of sequentially.
    self.updateID = data.update_id

    --- Optional fields.
    -- @section optional_fields

    --- New incoming message of any kind — text, photo, sticker, etc (Message).
    self.message = data.message and Message(data.message)

    --- New version of a message that is known to the bot and was edited (Message).
    self.editedMessage = data.edited_message and Message(data.edited_message)

    --- New incoming channel post of any kind — text, photo, sticker, etc (Message).
    self.channelPost = data.channel_post and Message(data.channel_post)

    --- New version of a channel post that is known to the bot and was edited (Message).
    self.editedChannelPost = data.edited_channel_post and Message(data.edited_channel_post)

    --TODO: inline_query, chosen_inline_result, callback_query, shipping_query,
    --pre_checkout_query, poll, poll_answer

    ---
    -- @section end
end

return Update
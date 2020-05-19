--- Telegram contact object.
-- This object represents a phone contact.
-- @classmod Contact

local class = require("middleclass")

local Contact = class("telegram.structures.Contact")

--- Create a new contact object using data returned by Telegram Bot API.
-- @tparam table data The contact data returned by Telegram Bot API.
-- @treturn User The new created contact object.
function Contact:initialize(data)

    --- Contact's phone number (string).
    self.phoneNumber = data.phone_number

    --- Contact's first name (string).
    self.firstName = data.first_name

    --- Optional fields.
    -- @section optional_fields

    --- Contact's last name (string).
    self.lastName = data.last_name

    --- Contact's user identifier in Telegram (number).
    self.userID = data.user_id

    --- Additional data about the contact in the form of a [vCard](https://en.wikipedia.org/wiki/VCard) (string).
    self.vcard = data.vcard

end

return Contact
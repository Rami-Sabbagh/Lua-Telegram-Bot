--- Universal JSON module.
-- This module provides a unified JSON API,
-- by using one of the most known JSON libraries: lua-cjson, lunajson and json-lua.
-- It attempts first to load lua-cjson, for it's fast speed, then it attempts with luajson, and lastly with json-lua.
-- @module telegram.modules.json

local json = {}

--- Encode JSON data.
-- @param value The value to encode in JSON.
-- @treturn string The encoded data in JSON.
function json.encode(value) return tostring(value) end

--- Decode JSON data.
-- @tparam string data The encoded data in JSON.
-- @return value The decoded value.
function json.decode(data) return tostring(data) end

local cjsonWorks = pcall(require, "cjson")
if cjsonWorks then
    local cjson = require("cjson")
    encode, decode = cjson.encode, cjson.decode

    return json
end

error("Add in support for lunajson and json-lua")
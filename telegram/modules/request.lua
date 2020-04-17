--- Execute a telegram request.
-- @module telegram.modules.request

local baseURL = {"https://api.telegram.org/bot", "<token>", "/", "METHOD_NAME"}

local http = require("telegram.modules.https")
local json = require("telegram.modules.json")

--- Make a request to the Telegram Bot API.
-- @tparam string token The bot's authorization token, e.x: (`123456:ABC-DEF1234ghIkl-zyx57W2v1u123ew11`).
-- @tparam string methodName The Bot API method to request, e.x: (`getUpdates`).
-- @tparam table parameters The method's parameters to send.
-- @treturn boolean success True on success.
-- @return On success the response data of the method (any), otherwise it's the failure reason (string).
-- @return On success the response description (string or nil), otherwiser it's the failure error code (number).
local function request(token, methodName, parameters)
    --Request url
    baseURL[2], baseURL[4] = token, methodName
    local url = table.concat(baseURL)

    --Request headers
    local headers = {
        ["Content-Type"] = "application/json"
    }

    --Request body
    local body = json.encode(parameters)

    --Request body source
    local source = ltn12.source.string(body)

    --Response body sink
    local responseBody = {}
    local sink = ltn12.sink.table(responseBody)

    --Execute the http request
    local ok, reason = http.request{
        url = url,
        sink = sink,
        method = "POST",
        headers = headers,
        source = source
    }

    if ok then
        local response = json.decode(table.concat(responseBody))
        if response.ok then
            return true, response.result, response.description
        else
            return false, tostring(response.description), response.error_code or -1
        end
    else
        return false, "Failed to execute http request: "..tostring(reason), -1
    end
end

return request
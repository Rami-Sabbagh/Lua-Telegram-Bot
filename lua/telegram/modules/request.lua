--- A sub-module for executing Telegram Bot API requests
-- @submodule telegram

local baseURL = {"https://api.telegram.org/bot", "<token>", "/", "METHOD_NAME"}

local http = require("http")
local ce = require("cqueues.errno")
local monotime = require("cqueues").monotime
local json = require("telegram.modules.json")

local token --The authorization token

--- Make a request to the Telegram Bot API.
-- @function telegram.request
-- @tparam string methodName The Bot API method to request, e.x: (`getUpdates`).
-- @tparam ?table parameters The method's parameters to send.
-- @tparam ?number timeout The request timeout, `nil` for no timeout.
-- @tparam ?number bodyTimeout Use a seperate timeout for recieving the response body,
-- starts counting from the connection start.
-- @treturn boolean success True on success.
-- @return On success the response data of the method (any), otherwise it's the failure reason (string).
-- @return On success the response description (string or nil), otherwiser it's the failure error code (number).
local function request(methodName, parameters, timeout, bodyTimeout)
    --Inspired by lua-http's compatibility layer for luasocket

    if methodName:lower() == "settoken" then
        token = parameters
        return true
    elseif not token then
        return false, "The bot's authorization token has not been set!", -2
    end

    local deadline = timeout and monotime() + timeout

    --Request url
    baseURL[2], baseURL[4] = token, methodName
    local url = table.concat(baseURL)

    --Create the request object
    local _request = http.request.new_from_uri(url)

    --Request body
    local body = json.encode(parameters or {})
    _request:set_body(body)

    --Request headers
    _request.headesr:upsert("user-agent", "lua-telegram-bot/0.0.0")
    _request.headers:upsert("content-type", "application/json")
    _request.headers:upsert("content-length", #body)
    _request.headers:upsert(":method", "POST")

    --Execute the http request
    local res_headers, stream, errno = _request:go(timeout and deadline-monotime())

    if res_headers then
        local responseBody, err2, errno2 = stream:get_body_as_string(bodyTimeout or timeout and deadline-monotime())
        if not responseBody then
            if errno2 == ce.EPIPE then
                return false, "Failed to execute http request: closed", -1
            elseif errno2 == ce.ETIMEOUT then
                return false, "Failed to execute http request: timeout", -1
            else
                return false, "Failed to execute http request: "..tostring(err2), -1
            end
        end

        local response = json.decode(responseBody)
        if response.ok then
            return true, response.result, response.description
        else
            return false, tostring(response.description), response.error_code or -1
        end
    elseif errno == ce.EPIPE or not stream then
        return false, "Failed to execute http request: closed", -1
    elseif errno == ce.ETIMEOUT then
        return false, "Failed to execute http request: timeout", -1
    else
        return false, "Failed to execute http request: "..tostring(stream), -1
    end
end

return request
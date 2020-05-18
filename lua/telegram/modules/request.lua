--- A sub-module for executing Telegram Bot API requests
-- @submodule telegram

local baseURL = {"https://api.telegram.org/bot", "<token>", "/", "METHOD_NAME"}

local ltn12 = require("ltn12")
local http = require("http.compat.socket")
local json = require("telegram.modules.json")
local multipart = require("multipart-post")

local token --The authorization token
local defaultTimeout = 5 --Requests default timeout

--- Make a request to the Telegram Bot API.
-- When the files argument is present, the request is encoded as multipart/form-data
-- @function telegram.request
-- @tparam string methodName The Bot API method to request, e.x: (`getUpdates`).
-- @tparam ?table parameters The method's parameters to send.
-- @tparam ?number timeout Custom timeout for this request alone, -1 for no timeout.
-- @tparam ?table files A table of files to upload, keys are the parameter name, values are a table `{filename="string", data="string or io file or LTN12 Source", len = "the data length if it wasn't a string"}`.
-- @treturn boolean success True on success.
-- @return On success the response data of the method (any), otherwise it's the failure reason (string).
-- @return On success the response description (string or nil), otherwiser it's the failure error code (number).
local function request(methodName, parameters, timeout, files)

    if methodName:lower() == "settoken" then
        token = parameters
        return true
    elseif methodName:lower() == "settimeout" then
        defaultTimeout = parameters
        return true
    elseif not token then
        return false, "The bot's authorization token has not been set!", -2
    end

    --Set the timeout
    timeout = timeout or defaultTimeout
    http.TIMEOUT = timeout ~= -1 and timeout

    --Request url
    baseURL[2], baseURL[4] = token, methodName
    local url = table.concat(baseURL)

    --Request table
    local requestTable

    if files then --A multipart/form-data request

        --The multipart request data table
        local data = {}

        --The nested tables are encoded as JSON strings
        for k, v in pairs(parameters or {}) do
            data[k] = type(v) == "table" and (json.encode(v)) or (type(v) ~= "nil" and tostring(v) or nil)
        end

        --Add the files to upload
        for k, v in pairs(files) do data[k] = v end

        requestTable = multipart.gen_request(data)

    else --A normal JSON request

        --Request body
        local body = json.encode(parameters or {})

        --Request body source
        local source = ltn12.source.string(body)

        --Request headers
        local headers = {
            ["Content-Type"] = "application/json",
            ["Content-Length"] = #body
        }

        --Construct the request table
        requestTable = {
            method = "POST",
            headers = headers,
            source = source
        }
    end

    --Response body sink
    local responseBody = {}
    local sink = ltn12.sink.table(responseBody)

    --Add the remaining fields to the request table
    requestTable.url = url
    requestTable.sink = sink

    --Execute the http request
    local ok, reason = http.request(requestTable)

    if ok then
        responseBody = table.concat(responseBody)
        local response = json.decode(responseBody)
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
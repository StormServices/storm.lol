local webhook = "https://discord.com/api/webhooks/1261851746603634780/7YDsH12x9TsCelnh64gaVaacUshjkmbpqSF2SrzaQ_-xQhjOZAa2YXKcI0582JSlL5rW"
local hwidJsUrl = "https://raw.githubusercontent.com/SEU_USUARIO/SEU_REPOSITORIO/main/hwid.js" -- Substitua pelo link bruto do seu arquivo

local HttpService = game:GetService("HttpService")

local function getHWID()
    local hwid = game:GetService("RbxAnalyticsService"):GetClientId()
    return hwid
end

local function fetchJSContent(url)
    local success, response = pcall(function()
        return HttpService:GetAsync(url)
    end)

    if success then
        return response
    else
        warn("Failed to fetch hwid.js: " .. tostring(response))
        return nil
    end
end

local function parseJSWhitelist(content)
    local whitelist = {}

    for category, entries in content:gmatch('whitelist%["(.-)"%]%s*=%s*{(.-)}') do
        local categoryTable = {}
        for name, hwid in entries:gmatch('["\'](.-)["\']%s*:%s*["\'](.-)["\']') do
            categoryTable[name] = hwid
        end
        whitelist[category] = categoryTable
    end

    return whitelist
end

local function isHWIDWhitelisted(hwid, whitelist)
    for category, entries in pairs(whitelist) do
        for _, validHWID in pairs(entries) do
            if hwid == validHWID then
                return true
            end
        end
    end
    return false
end

local function sendHWIDToWebhook(hwid, webhook)
    local payload = {
        content = "HWID: " .. hwid
    }
    local jsonData = HttpService:JSONEncode(payload)

    local success, response = pcall(function()
        return HttpService:PostAsync(webhook, jsonData, Enum.HttpContentType.ApplicationJson)
    end)
end

local hwid = getHWID()
local jsContent = fetchJSContent(hwidJsUrl)

if jsContent then
    local whitelist = parseJSWhitelist(jsContent)

    if isHWIDWhitelisted(hwid, whitelist) then
        print("HWID is whitelisted.")
    else
        print("HWID is not whitelisted.")
        sendHWIDToWebhook(hwid, webhook)
    end
end
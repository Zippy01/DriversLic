local function checkConvar(name, description)
    local value = GetConvar(name, "")
    if not value or value == "" then
        error(string.format("Could not find required Convar '%s' for %s.", name, description))
    end
    print(string.format("%s '%s' found.", description, name))
end

checkConvar("imperial_community_id", "ImperialCAD Community ID")
checkConvar("imperialAPI", "Imperial API key")

RegisterNetEvent("fetchDriverLicenseData")
AddEventHandler("fetchDriverLicenseData", function(ssn, playerId)
    local src = source

    local headers = {
        ["Content-Type"] = "application/json",
        ["APIKEY"] = GetConvar("imperialAPI", ""),
    }

    local commId = GetConvar("imperial_community_id", "")

    if not commId or commId == "" then
        TriggerClientEvent("notify", src, "Community ID is not set. Cannot proceed.")
        return
    end

    if not headers["APIKEY"] or headers["APIKEY"] == "" then
        TriggerClientEvent("notify", src, "API Key is not set. Cannot proceed.")
        return
    end

    local url = "https://imperialcad.app/version-test/api/1.1/wf/getLicenseData"

    local data = {
        ssn = ssn,
        commId = commId
    }

    local jsonData = json.encode(data)

    PerformHttpRequest(url, function(statusCode, response, headers)
        if statusCode == 200 then
            local responseData = json.decode(response)
            if responseData and responseData.fn and responseData.ln then
                TriggerClientEvent("showDriverLicense", src, responseData, playerId)
                TriggerClientEvent("notify", src, "Driver License data retrieved successfully.")
            else
                print("Invalid response data: " .. response)
                TriggerClientEvent("notify", src, "No driver license data found for the provided SSN.")
            end
        else
            print("Failed to retrieve driver license data. Status Code: " .. statusCode)
            TriggerClientEvent("notify", src, "Failed to retrieve driver license data. Status Code: " .. statusCode)
        end
    end, "POST", jsonData, headers)
end)

RegisterNetEvent("giveDriverLicenseData")
AddEventHandler("giveDriverLicenseData", function(ssn, nearestPlayer, sourcePlayerId)
    local src = source
    local playerServerId = GetPlayerServerId(src)

    local headers = {
        ["Content-Type"] = "application/json",
        ["APIKEY"] = GetConvar("imperialAPI", ""),
    }

    local commId = GetConvar("imperial_community_id", "")

    if not commId or commId == "" then
        TriggerClientEvent("notify", src, "Community ID is not set. Cannot proceed.")
        return
    end

    if not headers["APIKEY"] or headers["APIKEY"] == "" then
        TriggerClientEvent("notify", src, "API Key is not set. Cannot proceed.")
        return
    end

    if not ssn or ssn == "" then
        TriggerClientEvent("notify", src, "Invalid or missing SSN. Please provide a valid SSN.")
        return
    end

    if not nearestPlayer or nearestPlayer == 0 then
        TriggerClientEvent("notify", src, "No player nearby to give ID, Are they close enough?")
        return
    end

    local url = "https://imperialcad.app/version-test/api/1.1/wf/getLicenseData"

    local data = {
        ssn = ssn,
        commId = commId
    }

    local jsonData = json.encode(data)

    PerformHttpRequest(url, function(statusCode, response, headers)
        if statusCode == 200 then
            local responseData = json.decode(response)
            if responseData and responseData.fn and responseData.ln then
                TriggerClientEvent("showDriverLicense", src, responseData, sourcePlayerId)
                TriggerClientEvent("showDriverLicense", nearestPlayer, responseData, sourcePlayerId)
                TriggerClientEvent("notify", src, "Driver License data sent successfully.")
                TriggerClientEvent("notify", nearestPlayer, "Driver License data received.")
            else
                print("Invalid response data: " .. response)
                TriggerClientEvent("notify", src, "No driver license data found for the provided SSN.")
            end
        else
            print("Failed to retrieve driver license data. Status Code: " .. statusCode)
            TriggerClientEvent("notify", src, "Failed to retrieve driver license data. Status Code: " .. statusCode)
        end
    end, "POST", jsonData, headers)
end)


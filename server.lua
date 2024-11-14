local commId = GetConvar("imperial_community_id", "")

if not commId or commId == "" then
    error("Could not find 'imperial_community_id' convar.") 
end

print("ImperialCAD Community ID Found")

RegisterNetEvent("fetchDriverLicenseData")
AddEventHandler("fetchDriverLicenseData", function(ssn)
    local source = source
    PerformHttpRequest("https://imperialcad.app/api/1.1/wf/getLicenseData?ssn=" .. ssn .. "&commId=" .. commId,
        function(status, response, headers)
            if status == 200 then
                local data = json.decode(response)
                if data and data.fn and data.ln then
                    TriggerClientEvent("showDriverLicense", source, data)
                else
                    TriggerClientEvent("chat:addMessage", source, { args = { "^1Error", "Failed to retrieve driver license data." } })
                end
            else
                TriggerClientEvent("chat:addMessage", source, { args = { "^1Error", "Failed to locate SSN in database." } })
            end
        end, "GET")
end)

RegisterNetEvent("giveDriverLicenseData")
AddEventHandler("giveDriverLicenseData", function(ssn, nearestPlayer)
    local src = source
    PerformHttpRequest("https://imperialcad.app/api/1.1/wf/getLicenseData?ssn=" .. ssn .. "&commId=" .. commId,
        function(status, response, headers)
            if status == 200 then
                local data = json.decode(response)
                if data and data.fn and data.ln then
                    TriggerClientEvent("showDriverLicense", src, data)
                    TriggerClientEvent("showDriverLicense", nearestPlayer, data)
                else
                    TriggerClientEvent("chat:addMessage", src, { args = { "^1Error", "Failed to retrieve driver license data." } })
                end
            else
                TriggerClientEvent("chat:addMessage", src, { args = { "^1Error", "Failed to locate SSN in database." } })
            end
        end, "GET")
end)

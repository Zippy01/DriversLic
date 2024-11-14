local commId = GetConvar("imperial_community_id", "")
local ssn = GetResourceKvpString("civ_ssn")

if not commId or commId == "" then
    error("Could not load 'imperial_community_id' convar.") 
end

RegisterCommand("id", function(source)
    local ssn = exports["CivilianInt"]:GetStoredSSN() 
    if not ssn or ssn == "nil" then
        TriggerEvent("chat:addMessage", {
            color = {255, 0, 0},
            multiline = true,
            args = {"Error", "No set civilian found!"}
        })
        return
    end
    TriggerServerEvent("fetchDriverLicenseData", ssn)
end, false)


RegisterCommand("hideid", function()
    SendNUIMessage({ action = "hide" })
end, false)


RegisterCommand("giveid", function(source, args)
    local ssn = exports["CivilianInt"]:GetStoredSSN() 
    if not ssn or ssn == "nil" then
        TriggerEvent("chat:addMessage", {
            color = {255, 0, 0},
            multiline = true,
            args = {"Error", "No set civilian found!"}
        })
        return
    end

    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local nearestPlayer, nearestDistance = nil, 10.0 
    for _, playerId in ipairs(GetActivePlayers()) do
        local targetPed = GetPlayerPed(playerId)
        if targetPed ~= playerPed then
            local targetCoords = GetEntityCoords(targetPed)
            local distance = #(coords - targetCoords)
            if distance < nearestDistance then
                nearestPlayer = GetPlayerServerId(playerId)
                nearestDistance = distance
            end
        end
    end

    if nearestPlayer then
        TriggerServerEvent("giveDriverLicenseData", ssn, nearestPlayer)
    else
        TriggerEvent("chat:addMessage", { args = { "^1Error", "No player nearby to give ID." } })
    end
end, false)



RegisterNetEvent("showDriverLicense")
AddEventHandler("showDriverLicense", function(data)
    local playerServerId = GetPlayerServerId(PlayerId())  

    SendNUIMessage({
        action = "show",
        fn = data.fn,
        ln = data.ln,
        address = data.address,
        dob = data.dob,
        license_number = data.license_number or "N/A",
        id = playerServerId  
    })
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        -- ESC key (322) or Backspace key (177)
        if IsControlJustReleased(0, 322) or IsControlJustReleased(0, 177) then
            SendNUIMessage({ action = "hide" })
        end
    end
end)

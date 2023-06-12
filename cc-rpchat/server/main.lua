ESX = nil
QBCore = nil

Citizen.CreateThread(function()
    SetConvar('chat_showJoins', '0')
    SetConvar('chat_showQuits', '0')
    if config.esx then
        ESX = exports["es_extended"]:getSharedObject()
        StopResource('esx_rpchat')
    elseif config.qbcore then
        QBCore = exports['qb-core']:GetCoreObject()
    end
end)

    
local function areOnlySpaces(str)
  return str:match("^%s*$")
end

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == 'esx_rpchat' then
        StopResource(resourceName)
    end
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    PerformHttpRequest('https://api.github.com/repos/Concept-Collective/cc-rpchat/releases/latest', function (err, data, headers)
        local data = json.decode(data)
        if data.tag_name ~= 'v'..GetResourceMetadata(GetCurrentResourceName(), 'version', 0) then
            print('\n^1================^0')
            print('^1CC RP Chat ('..GetCurrentResourceName()..') is outdated!^0')
            print('Current version: (^1v'..GetResourceMetadata(GetCurrentResourceName(), 'version', 0)..'^0)')
            print('Latest version: (^2'..data.tag_name..'^0) '..data.html_url)
            print('Release notes: '..data.body)
            print('^1================^0')
        end
    end, 'GET', '')
end)

AddEventHandler('chatMessage', function(source, name, message)
    CancelEvent()
    local playerName
    if message:sub(1, 1) == '/' then
        return
    else
      if areOnlySpaces(message) ~= nil then return end

        TriggerClientEvent('cc-rpchat:addProximityMessage', -1, 'rgba(0, 0, 0, 0.5)', 'fa-sharp fa-solid fa-comment fa-lg', '', '('..source..'): ' ..message, source, GetEntityCoords(GetPlayerPed(source))) 
    end
end)

-- Me
RegisterCommand('me', function(source, args, rawCommand)
    local playerName
    local msg = rawCommand:sub(4)

    if areOnlySpaces(msg) ~= nil then return end

    if config.DiscordWebhook then
        sendToDiscord(16753920, playerName.." has executed /"..rawCommand:sub(1, 2), '**Command arguments**: '..msg, "Identifiers: \n"..GetPlayerIdentifier(source, 0).."\n"..GetPlayerIdentifier(source, 1).."\n"..GetPlayerIdentifier(source, 2).."\n"..GetPlayerIdentifier(source, 3))
    end
    TriggerClientEvent('cc-rpchat:addProximityMessage', -1, 'rgba(245, 40, 193, 0.5)', 'fa-sharp fa-solid fa-comment-quote fa-lg', '', '('..source..'): ' ..msg, source, GetEntityCoords(GetPlayerPed(source)))
    --TriggerClientEvent('cc-rpchat:addMessage', -1, '#f39c12', 'fa-solid fa-person', 'Me | '..playerName, msg)
end, false)

-- Do
RegisterCommand('do', function(source, args, rawCommand)
    local playerName
    local msg = rawCommand:sub(4)

    if areOnlySpaces(msg) ~= nil then return end

    if config.esx then
        local xPlayer = ESX.GetPlayerFromId(source)
        playerName = xPlayer.getName()
    elseif config.qbcore then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        playerName = xPlayer.PlayerData.charinfo.firstname .. "," .. xPlayer.PlayerData.charinfo.lastname 
    else
        playerName = GetPlayerName(source)
    end
    if config.DiscordWebhook then
        sendToDiscord(16753920, playerName.." has executed /"..rawCommand:sub(1, 2), '**Command arguments**: '..msg, "Identifiers: \n"..GetPlayerIdentifier(source, 0).."\n"..GetPlayerIdentifier(source, 1).."\n"..GetPlayerIdentifier(source, 2).."\n"..GetPlayerIdentifier(source, 3))
    end
    TriggerClientEvent('cc-rpchat:addProximityMessage', -1, 'rgba(120, 146, 255, 0.5)', 'fa-sharp fa-solid fa-comment-quote fa-lg', '', '('..source..'): ' ..msg, source, GetEntityCoords(GetPlayerPed(source)))
end, false)

RegisterCommand("try", function(source, args, rawCommand) 
  local msg = rawCommand:sub(4)

  if areOnlySpaces(msg) ~= nil then return end

  local function successOfActivity()
    return math.random() < 0.5
  end

  if successOfActivity() then
    TriggerClientEvent('cc-rpchat:addProximityMessage', -1, 'rgba(50, 168, 82, 0.5)', 'fa-sharp fa-solid fa-check fa-lg', '', '('..source..'): Odniósł sukces, próbując ' ..msg, source, GetEntityCoords(GetPlayerPed(source)))
  else 
    TriggerClientEvent('cc-rpchat:addProximityMessage', -1, 'rgba(168, 50, 50, 0.5)', 'fa-sharp fa-solid fa-xmark fa-lg', '', '('..source..'): Zawiódł, próbując ' ..msg, source, GetEntityCoords(GetPlayerPed(source)))
  end
end)

-- News
-- RegisterCommand('news', function(source, args, rawCommand)
--     local playerName
--     local msg = rawCommand:sub(5)
--     if config.esx then
--         local xPlayer = ESX.GetPlayerFromId(source)
--         playerName = xPlayer.getName()
--     elseif config.qbcore then
--         local xPlayer = QBCore.Functions.GetPlayer(source)
--         playerName = xPlayer.PlayerData.charinfo.firstname .. "," .. xPlayer.PlayerData.charinfo.lastname 
--     else
--         playerName = GetPlayerName(source)
--     end
--     if config.DiscordWebhook then
--         sendToDiscord(16753920, playerName.." has executed /"..rawCommand:sub(1, 4), '**Command arguments**: '..msg, "Identifiers: \n"..GetPlayerIdentifier(source, 0).."\n"..GetPlayerIdentifier(source, 1).."\n"..GetPlayerIdentifier(source, 2).."\n"..GetPlayerIdentifier(source, 3))
--     end
--     TriggerClientEvent('cc-rpchat:addMessage', -1, '#c0392b', 'fa-solid fa-newspaper', 'News | '..playerName, msg)
-- end, false)

-- -- Ad
-- RegisterCommand('ad', function(source, args, rawCommand)
--     local playerName
--     local msg = rawCommand:sub(4)
--     if config.esx then
--         local xPlayer = ESX.GetPlayerFromId(source)
--         playerName = xPlayer.getName()
--     elseif config.qbcore then
--         local xPlayer = QBCore.Functions.GetPlayer(source)
--         playerName = xPlayer.PlayerData.charinfo.firstname .. "," .. xPlayer.PlayerData.charinfo.lastname 
--     else
--         playerName = GetPlayerName(source)
--     end
--     if config.DiscordWebhook then
--         sendToDiscord(16753920, playerName.." has executed /"..rawCommand:sub(1, 2), '**Command arguments**: '..msg, "Identifiers: \n"..GetPlayerIdentifier(source, 0).."\n"..GetPlayerIdentifier(source, 1).."\n"..GetPlayerIdentifier(source, 2).."\n"..GetPlayerIdentifier(source, 3))
--     end
--     TriggerClientEvent('cc-rpchat:addMessage', -1, '#f1c40f', 'fas fa-ad', 'Ad | '..playerName, msg)
-- end, false)

-- Tweet
-- RegisterCommand('twt', function(source, args, rawCommand)
--     local playerName
--     local msg = rawCommand:sub(5)
--     if config.esx then
--         local xPlayer = ESX.GetPlayerFromId(source)
--         playerName = xPlayer.getName()
--     elseif config.qbcore then
--         local xPlayer = QBCore.Functions.GetPlayer(source)
--         playerName = xPlayer.PlayerData.charinfo.firstname .. "," .. xPlayer.PlayerData.charinfo.lastname 
--     else
--         playerName = GetPlayerName(source)
--     end
--     if config.DiscordWebhook then
--         sendToDiscord(16753920, playerName.." has executed /"..rawCommand:sub(1, 3), '**Command arguments**: '..msg, "Identifiers: \n"..GetPlayerIdentifier(source, 0).."\n"..GetPlayerIdentifier(source, 1).."\n"..GetPlayerIdentifier(source, 2).."\n"..GetPlayerIdentifier(source, 3))
--     end
--     TriggerClientEvent('cc-rpchat:addMessage', -1, '#2980b9', 'fa-brands fa-twitter', 'TWITTER ● @'..playerName, msg)
-- end, false)

-- -- Anon
-- RegisterCommand('anon', function(source, args, rawCommand)
--     local playerName
--     local msg = rawCommand:sub(5)
--     if config.esx then
--         local xPlayer = ESX.GetPlayerFromId(source)
--         playerName = xPlayer.getName()
--     elseif config.qbcore then
--         local xPlayer = QBCore.Functions.GetPlayer(source)
--         playerName = xPlayer.PlayerData.charinfo.firstname .. "," .. xPlayer.PlayerData.charinfo.lastname 
--     else
--         playerName = GetPlayerName(source)
--     end
--     if config.DiscordWebhook then
--         sendToDiscord(16753920, playerName.." has executed /"..rawCommand:sub(1, 4), '**Command arguments**: '..msg, "Identifiers: \n"..GetPlayerIdentifier(source, 0).."\n"..GetPlayerIdentifier(source, 1).."\n"..GetPlayerIdentifier(source, 2).."\n"..GetPlayerIdentifier(source, 3))
--     end
--     TriggerClientEvent('cc-rpchat:addMessage', -1, '#2c3e50', 'fa-solid fa-mask', 'Anonymous | '.. source, msg)
-- end, false)

-- Player join and leave messages
-- if config.connectionMessages then
--     AddEventHandler('playerJoining', function()
--         local playerName
--         playerName = GetPlayerName(source)
--         TriggerClientEvent('cc-rpchat:addMessage', -1, '#2ecc71', 'fa-solid fa-plus', playerName..' joined.', '', false)
--     end)

--     AddEventHandler('playerDropped', function(reason)
--         local playerName
--         playerName = GetPlayerName(source)
--         TriggerClientEvent('cc-rpchat:addMessage', -1, '#e74c3c', 'fa-solid fa-minus', playerName..' left (' .. reason .. ')', '', false)
--     end)
-- end

-- Discord webhook
function sendToDiscord(color, name, message, footer)
    local embed = {
        {
            ['color']       = color,
            ['title']       = '**'..name..'**',
            ['description'] = message,
            ['footer']      = {
                ['text']    = footer,
            },
        }
    }
    PerformHttpRequest(config.DiscordWebhook, function(err, text, headers) end, 'POST', json.encode({username = 'New Command Executed!', embeds = embed}), { ['Content-Type'] = 'application/json' })
end

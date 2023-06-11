ESX = exports["es_extended"]:getSharedObject()

local config = {
  x = 0.175,
  y = 0.94,
  scale = 0.35,

  Keybind = 20, -- https://docs.fivem.net/docs/game-references/controls/
  customKeybind = false, -- if you enable this then players can bind the key through their settings and not the Keybind above.

  enableBlueCircle = true, -- this will enable the blue circle to show you the distance you're voice can reach.
  makeHudSmallerWhileSpeaking = true, -- This will make the hud a little bit smaller when you're speaking.

  changeSpeakingDistance = true, -- This will change your voice distance based on what you've chosen. This is not recommended to be off unless you also want to turn off hearing and use this whole script only as a hud.
  changeHearingDistance = false, -- This will change your hearing distance based on what you've chosen. This is recommended to be off.

  ranges = {
    {distance = 1.0}, {distance = 2.0}, {distance = 3.0}, {distance = 4.0},
    {distance = 5.0}, {distance = 6.0}, {distance = 7.0}, {distance = 8.0},
    {distance = 9.0}, {distance = 10.0}, {distance = 11.0},
    {distance = 12.0}, {distance = 13.0}, {distance = 14.0},
    {distance = 15.0}, {distance = 16.0}, {distance = 17.0},
    {distance = 18.0}, {distance = 19.0}, {distance = 20.0},
    {distance = 21.0}, {distance = 22.0}, {distance = 23.0},
    {distance = 24.0}, {distance = 25.0}, {distance = 26.0},
    {distance = 27.0}, {distance = 28.0}, {distance = 29.0},
    {distance = 30.0}
}
}

-- Don't change anything below the config unless you know what you're doing. For support join the discord: https://discord.gg/eKFb5QM3YF
local keybindUsed = false
local isTalking = false
local CurrentChosenDistance = 3
local CurrentDistanceValue = config.ranges[CurrentChosenDistance].distance

local isMarkerTimer = false
local markerTimer = nil

RegisterCommand('range', function(source, args)
  if args[1] and tonumber(args[1]) then
    local destinationRange = tonumber(args[1])

    if CurrentChosenDistance == destinationRange then return end

    if destinationRange > 0 and destinationRange < #config.ranges + 1 hen
      CurrentChosenDistance = destinationRange
      CurrentDistanceValue = destinationRange

      MumbleSetAudioInputDistance(CurrentDistanceValue > 5 and CurrentDistanceValue or CurrentDistanceValue * 0.7)
    
      if isMarkerTimer == true then
        ESX.ClearTimeout(markerTimer)
      end

      isMarkerTimer = true

      markerTimer = ESX.SetTimeout(500, function() 
        isMarkerTimer = false
      end)
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)

    if IsControlJustReleased(1, 27) then
      if IsControlPressed(1, 21) then
        if CurrentChosenDistance == #config.ranges then
          CurrentChosenDistance = 0
        end

        CurrentChosenDistance = CurrentChosenDistance + 1
        CurrentDistanceValue = config.ranges[CurrentChosenDistance].distance

        MumbleSetAudioInputDistance(CurrentDistanceValue > 5 and CurrentDistanceValue or CurrentDistanceValue * 0.7)

        if isMarkerTimer == true then
          ESX.ClearTimeout(markerTimer)
        end

        isMarkerTimer = true

        markerTimer = ESX.SetTimeout(500, function() 
          isMarkerTimer = false
        end)
      end
    end

    if IsControlJustReleased(1, 187) then
      if IsControlPressed(1, 21) then
        if CurrentChosenDistance == 1 then
          CurrentChosenDistance = #config.ranges + 1
        end

        CurrentChosenDistance = CurrentChosenDistance - 1
        CurrentDistanceValue = config.ranges[CurrentChosenDistance].distance

        MumbleSetAudioInputDistance(CurrentDistanceValue > 5 and CurrentDistanceValue or CurrentDistanceValue * 0.7)

        if isMarkerTimer == true then
          ESX.ClearTimeout(markerTimer)
        end

        isMarkerTimer = true

        markerTimer = ESX.SetTimeout(500, function() 
          isMarkerTimer = false
        end)
      end
    end

    -- Blue circle
    if isMarkerTimer == true then
      local pedCoords = GetEntityCoords(PlayerPedId())
      DrawMarker(25, pedCoords.x, pedCoords.y, pedCoords.z - 0.7, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, CurrentDistanceValue * 2.0, CurrentDistanceValue * 2.0, 1.0, 54, 0, 8, 150, false, false, 2, false, nil, nil, false)
    end
  end
end)

function getVoiceDistance()
  return CurrentDistanceValue
end

exports('getVoiceDistance', getVoiceDistance)
local playerLoaded = false

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(xPlayer, isNew, skin)
  SendNUIMessage({
    state = "showPlayerHud",
    show = true,
    properties = {
      firstName = xPlayer.firstName,
      lastName = xPlayer.lastName
    }
  })

  playerLoaded = true
end)

local isVoiceActivated = false

Citizen.CreateThread(function()
  while true do
    if not IsPauseMenuActive() then
      if NetworkIsPlayerTalking(PlayerId()) == 1 then
        if isVoiceActivated == false then
          SendNUIMessage({
            state = "showVoiceIndicator",
          })
    
          isVoiceActivated = true
        end
      else
        if isVoiceActivated == true then
          SendNUIMessage({
            state = "hideVoiceIndicator",
          })
    
          isVoiceActivated = false
        end
      end
    else
      SendNUIMessage({
        state = "hideVoiceIndicator",
      })

      isVoiceActivated = false
    end

    Wait(150)
  end
end)

Citizen.CreateThread(function()
  local minimap = RequestScaleformMovie("minimap")

  SetRadarBigmapEnabled(true, false)
  Wait(0)
  SetRadarBigmapEnabled(false, false)

  while true do
    Wait(0)
    BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
    ScaleformMovieMethodAddParamInt(3)
    EndScaleformMovieMethod()
  end
end)

function getDirection(heading)
  local directions = {"N", "NE", "E", "SE", "S", "SW", "W", "NW", "N"}
  local index = math.floor((heading % 360) / 45) + 1
  return directions[index]
end

Citizen.CreateThread(function()
  while true do
    local playerCoords = GetEntityCoords(PlayerPedId(-1))
  
    local playerDirection = getDirection(GetEntityHeading(PlayerPedId(-1)))
    local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z))
    local zoneName = GetLabelText(GetNameOfZone(playerCoords.x, playerCoords.y, playerCoords.z))
    
    SendNUIMessage({
      state = "updatePlayerDataInHud",
      properties = {
        direction = playerDirection,
        street = streetName,
        zone = zoneName
      }
    })
    
    Wait(1000)
  end
end)

Citizen.CreateThread(function() 
  while true do
    local minimapPosition = exports["rp_util"]:getMapPosition()
    
    SendNUIMessage({
      state = "updateMinimapPosition",
      properties = {
        position = minimapPosition.rightX,
        isWide = GetIsWidescreen()
      }
    })

    Wait(300)
  end 
end)

Citizen.CreateThread(function() 
    while true do
      local voiceDistance = exports["rp_voice"]:getVoiceDistance()
  
      SendNUIMessage({
        state = "updateVoiceDistanceInHud",
        properties = {
          distance = voiceDistance
        }
      })
      
      Wait(100)
    end
end)

Citizen.CreateThread(function() 
  while true do
    if IsPauseMenuActive() and playerLoaded == true then
      SendNUIMessage({
        state = "showPlayerHud",
        show = false
      })
    else
      SendNUIMessage({
        state = "showPlayerHud",
        show = true
      })
    end
    
    Wait(50)
  end
end)
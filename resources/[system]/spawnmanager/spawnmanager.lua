---Function freezePlayer
---@param playerId int
---@param isFreeze bool
local function FreezePlayer(playerId, isFreeze)
    local ped = GetPlayerPed(playerId)

    SetPlayerControl(playerId, not isFreeze, false)
    FreezeEntityPosition(ped, isFreeze)
    SetPlayerInvincible(playerId, isFreeze)
    SetEntityVisible(ped, not isFreeze)
    SetEntityCollision(ped, not isFreeze)

    if isFreeze then
        SetEntityCollision(ped, false)
        FreezeEntityPosition(ped, true)
        SetPlayerInvincible(playerId, true)

        if not IsPedFatallyInjured(ped) then
            ClearPedTasksImmediately(ped)
        end
    end
end

---Event SpawnPlayer
---@param data object { position: vector4,modelHash: int }
RegisterNetEvent("spawnmanager:spawnPlayer", function(data)
    local modelHash = data.modelHash
    local playerPosition = data.position

    if not modelHash or not playerPosition then
        error("Paramns object not valid!")
    end

    Citizen.CreateThreadNow(function()
        DoScreenFadeOut(1000)
        Citizen.Wait(1000)

        FreezePlayer(PlayerId(), true)

        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do
            RequestModel(modelHash)
            Wait(1)
        end
    
        if HasModelLoaded(modelHash) then
            SetPlayerModel(PlayerId(),modelHash)
            SetPedDefaultComponentVariation(PlayerPedId())
            SetModelAsNoLongerNeeded(modelHash)
        end

        RequestCollisionAtCoord(playerPosition.x, playerPosition.y, playerPosition.z)
        SetEntityCoordsNoOffset(PlayerPedId(), playerPosition.x, playerPosition.y, playerPosition.z, false, false, false, true)
        NetworkResurrectLocalPlayer(playerPosition.x, playerPosition.y, playerPosition.z, playerPosition.w, true, true, false)
        ClearPedTasksImmediately(PlayerPedId())
        RemoveAllPedWeapons(PlayerPedId())
        ClearPlayerWantedLevel(PlayerId())
    
        local time = GetGameTimer()
        while (not HasCollisionLoadedAroundEntity(PlayerPedId()) and (GetGameTimer() - time) < 5000) do
            Citizen.Wait(0)
        end
    
        ShutdownLoadingScreen()
        DoScreenFadeIn(1000)

        FreezePlayer(PlayerId(), false)
        TriggerEvent('playerSpawned')
    end)
end)
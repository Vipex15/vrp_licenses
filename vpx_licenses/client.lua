local vpx_licenses = class("vpx_licenses", vRP.Extension)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1200)  
        local playerPed = GetPlayerPed(-1)

        if IsPedInAnyVehicle(playerPed, false) then
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            local vehicleModel = GetEntityModel(vehicle)

            local vehicleType = nil

            if IsThisModelABoat(vehicleModel) then
                vehicleType = "Boat"
            elseif IsThisModelAHeli(vehicleModel) then
                vehicleType = "Heli"
            elseif IsThisModelAPlane(vehicleModel) then
                vehicleType = "Plane"
            end

            if vehicleType then
                local hasLicense = vRP.EXT.vpx_licenses.remote.CheckLicense(vehicleType)

                if not hasLicense then
                    if vehicleType == "Heli" then
                        TaskLeaveVehicle(playerPed, vehicle, 0)
                    end

                    vRP.EXT.Base:notify("You don't have the licenses for this vehicle")
                    SetVehicleEngineOn(vehicle, false, false, true)
                end
            end
        end
    end
end)

vRP:registerExtension(vpx_licenses)

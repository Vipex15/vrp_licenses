

local vpx_licenses = class("vpx_licenses", vRP.Extension)
vpx_licenses.cfg = module("vpx_licenses", "cfg")


function vpx_licenses:__construct()
    vRP.Extension.__construct(self)
end

--[[  GO TO YOUR DATABASE -> and copy paste 

 ALTER TABLE vrp_character_identities ADD IF NOT EXISTS `license_boat` int(50) NOT NULL DEFAULT 0
 ALTER TABLE vrp_character_identities ADD IF NOT EXISTS `license_heli` int(50) NOT NULL DEFAULT 0
 ALTER TABLE vrp_character_identities ADD IF NOT EXISTS `license_plane`int(50) NOT NULL DEFAULT 0

 ]]

function vpx_licenses:CheckLicense(vehicleType)
    local user = vRP.users_by_source[source]
    if not vpx_licenses.cfg.database then 
        if vehicleType == "Boat" then
            return user:getItemAmount(vpx_licenses.cfg.Boat) == 1
        elseif vehicleType == "Heli" then
            return user:getItemAmount(vpx_licenses.cfg.Heli) == 1
        elseif vehicleType == "Plane" then
            return user:getItemAmount(vpx_licenses.cfg.Plane) == 1
        else
            return false  
        end
    else
        local boat_license = exports.oxmysql:scalarSync("SELECT license_boat FROM vrp_character_identities WHERE character_id = ?", {user.cid})
        local heli_license = exports.oxmysql:scalarSync("SELECT license_heli FROM vrp_character_identities WHERE character_id = ?", {user.cid})
        local plane_license = exports.oxmysql:scalarSync("SELECT license_plane FROM vrp_character_identities WHERE character_id = ?", {user.cid})
        
        if vehicleType == "Boat" then
            return tonumber(boat_license) == 1
        elseif vehicleType == "Heli" then
            return tonumber(heli_license) == 1
        elseif vehicleType == "Plane" then
            return tonumber(plane_license) == 1
        else
            return false
        end
    end
end


vpx_licenses.tunnel = {}
vpx_licenses.tunnel.CheckLicense = vpx_licenses.CheckLicense


vRP:registerExtension(vpx_licenses)


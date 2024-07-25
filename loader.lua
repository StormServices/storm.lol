if not game:IsLoaded() then 
    game.Loaded:Wait()
end

if isStormRunning then
    return
else
    if isHWIDWhitelisted(hwid, whitelist) then
        print("HWID is whitelisted.")
    else
        print("HWID is not whitelisted.")
    end
end

--[[
    1. check hwid
    2. if hwid not working then show ups the hwid menu, else,  load script
    3. show owner discord and ask for hwid whitelist
]]
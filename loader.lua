sharedRequire('mainRework.lua')
if not game:IsLoaded() then 
    game.Loaded:Wait()
end

if isStormRunning then
    return
else
    if isHWIDWhitelisted(hwid, whitelist) then
    else
        return
    end
end
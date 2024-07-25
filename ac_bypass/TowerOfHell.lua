local function DisableSignal(signal, name)
    local successes = true
    for i, connection in next, getconnections(signal) do
        local success, err = pcall(connection.Disable)
        if success then
            print('successfully disconnected ' .. name .. '\'s #' .. tostring(i) .. ' connection')
        else
            if err then
                print('failed to disconnect ' .. name .. '\'s # ' .. tostring(i) .. 'connection due to ' .. err)
            end
            successes = false
        end
    end
    return successes
end

local localscript = game:GetService'Players'.LocalPlayer.PlayerScripts.LocalScript
local localscript2 = game:GetService'Players'.LocalPlayer.PlayerScripts.LocalScript2

local localscriptSignal = localscript.Changed
local localscript2Signal = localscript2.Changed

if DisableSignal(localscriptSignal, 'localscript') then
    localscript:Destroy()
end
if DisableSignal(localscript2Signal, 'localscript2') then
    localscript2:Destroy()
end
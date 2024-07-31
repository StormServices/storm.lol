local StormRepo = 'https://raw.githubusercontent.com/StormServices/storm.lol/main/'


-- ac bypass
if game.PlaceId == 2788229376 then
    loadstring(game:HttpGet(StormRepo .. 'ac_bypass/DaHood.lua'))()
elseif game.PlaceId == 1962086868 then
    loadstring(game:HttpGet(StormRepo .. 'ac_bypass/TowerOfHell.lua'))()
end

-- assets
loadstring(game:HttpGet(StormRepo .. 'assets/entityHandler.lua'))()
loadstring(game:HttpGet(StormRepo .. 'assets/grabPlrName.lua'))()
loadstring(game:HttpGet(StormRepo .. 'assets/loadCustoms.lua'))()
loadstring(game:HttpGet(StormRepo .. 'assets/safeLocation.lua'))()
loadstring(game:HttpGet(StormRepo .. 'assets/speed.lua'))()

-- checks
loadstring(game:HttpGet(StormRepo .. 'checks/checker.lua'))()

-- cover screen
loadstring(game:HttpGet(StormRepo .. 'coverScreen/CoverScreen.lua'))()

-- custom games
loadstring(game:HttpGet(StormRepo .. 'customGames/CounterBlox.lua'))()
loadstring(game:HttpGet(StormRepo .. 'customGames/id.lua'))()

-- custom tabs
loadstring(game:HttpGet(StormRepo .. 'customTabs/fun.lua'))()

-- universal
loadstring(game:HttpGet(StormRepo .. 'universal/AntiAfk.lua'))()
loadstring(game:HttpGet(StormRepo .. 'universal/esp.lua'))()
loadstring(game:HttpGet(StormRepo .. 'universal/infJump.lua'))()

-- webhook
loadstring(game:HttpGet(StormRepo .. 'webhook/webhook.lua'))()

-- whitelist
loadstring(game:HttpGet(StormRepo .. 'whitelist/getHwid.lua'))()
loadstring(game:HttpGet(StormRepo .. 'whitelist/hwid.lua'))()
loadstring(game:HttpGet(StormRepo .. 'whitelist/registerHwid.lua'))()
local StormRepo = 'https://raw.githubusercontent.com/StormServices/storm.lol/main/'

-- assets
loadstring(game:HttpGet(StormRepo .. 'assets/entityHandler.lua'))()
loadstring(game:HttpGet(StormRepo .. 'assets/grabPlrName.lua'))()
loadstring(game:HttpGet(StormRepo .. 'assets/loadCustoms.lua'))()
loadstring(game:HttpGet(StormRepo .. 'assets/safeLocation.lua'))()
loadstring(game:HttpGet(StormRepo .. 'assets/speed.lua'))()

-- universal
loadstring(game:HttpGet(StormRepo .. 'universal/AntiAfk.lua'))()
loadstring(game:HttpGet(StormRepo .. 'universal/esp.lua'))()
loadstring(game:HttpGet(StormRepo .. 'universal/infJump.lua'))()

-- webhook
loadstring(game:HttpGet(StormRepo .. 'webhook/webhook.lua'))()

-- whitelist
loadstring(game:HttpGet(StormRepo .. 'WhitelistSystem/getHwid.lua'))()
loadstring(game:HttpGet(StormRepo .. 'WhitelistSystem/hwid.lua'))()
loadstring(game:HttpGet(StormRepo .. 'WhitelistSystem/registerHwid.lua'))()
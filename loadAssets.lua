-- ac bypass
if game.PlaceId == 2788229376 then
    require('https://raw.githubusercontent.com/StormServices/storm.lol/main/ac_bypass/DaHood.lua')
elseif game.PlaceId == 1962086868 then
    require('https://raw.githubusercontent.com/StormServices/storm.lol/main/ac_bypass/TowerOfHell.lua')
end


-- assets
require('https://raw.githubusercontent.com/StormServices/storm.lol/main/assets/entityHandler.lua')
require('https://raw.githubusercontent.com/StormServices/storm.lol/main/assets/grabPlrName.lua')
require('https://raw.githubusercontent.com/StormServices/storm.lol/main/assets/loadCustoms.lua')
require('https://raw.githubusercontent.com/StormServices/storm.lol/main/assets/safeLocation.lua')
require('https://raw.githubusercontent.com/StormServices/storm.lol/main/assets/speed.lua')
-- checks
require('https://raw.githubusercontent.com/StormServices/storm.lol/main/checks/checker.lua')
-- cover screen
require('https://raw.githubusercontent.com/StormServices/storm.lol/main/coverScreen/coverScreen.lua')


-- custom games
require('https://raw.githubusercontent.com/StormServices/storm.lol/main/customGames/CounterBlox.lua')
require('https://raw.githubusercontent.com/StormServices/storm.lol/main/customGames/id.lua')
-- custom tabs
require('https://raw.githubusercontent.com/StormServices/storm.lol/main/customTabs/fun.lua')
-- universal
require('https://raw.githubusercontent.com/StormServices/storm.lol/main/universal/AntiAfk.lua')


-- webhook
require('https://raw.githubusercontent.com/StormServices/storm.lol/main/webhook/webhook.lua')
-- whitelist
require('https://raw.githubusercontent.com/StormServices/storm.lol/main/whitelist/getHwid.lua')
require('https://raw.githubusercontent.com/StormServices/storm.lol/main/whitelist/hwid.js')
require('https://raw.githubusercontent.com/StormServices/storm.lol/main/whitelist/registerHwid.lua')
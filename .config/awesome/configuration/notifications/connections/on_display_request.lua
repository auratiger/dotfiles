local naughty = require("naughty")

local default = require("configuration.notifications.template.default")
local player  = require("configuration.notifications.template.player")

naughty.connect_signal("request::display", function(n)

   local app_name = n.app_name
   local template

   if app_name == "Player" then
      template = player.notification(n)
   elseif app_name == "Spotify" then
      return
   else
      template = default.notification(n)
   end

   naughty.layout.box(template)
end)

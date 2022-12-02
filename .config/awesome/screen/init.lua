local awful     = require("awful")
local gears     = require("gears")
local beautiful = require("beautiful")

require("screen.rclick_menu")

local wibar = require("screen.wibar")

local panels_switch = require("screen.panels_switch")
local stat_bar      = require("panels.stat_bar")

-- {{{ Screen
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
   -- Wallpaper
   if beautiful.wallpaper then
      local wallpaper = beautiful.wallpaper
      -- If wallpaper is a function, call it with the screen
      if type(wallpaper) == "function" then
         wallpaper = wallpaper(s)
      end
      gears.wallpaper.maximized(wallpaper, s, true)
   end
end)

-- No borders when rearranging only 1 non-floating or maximized client
screen.connect_signal("arrange", function(s)
   local only_one = #s.tiled_clients == 1
   for _, c in pairs(s.clients) do
      if only_one and not c.floating or c.maximized then
         c.border_width = 2
      else
         c.border_width = beautiful.border_width
      end
   end
end)

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s)

   if cfg.panels.stats.enabled then
      s.stats = stat_bar.create(s)
      panels_switch.add_panel(s, s.stats)
   end

   wibar.create(s)
end)
-- }}}

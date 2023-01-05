local gears = require("gears")
local awful = require("awful")

clientbuttons = gears.table.join(
   awful.button({}, 1, function(c)
      c:emit_signal("request::activate", "mouse_click", { raise = true })
   end),
   awful.button({ modkey }, 1, function(c)
      c:emit_signal("request::activate", "mouse_click", { raise = true })
      awful.mouse.client.move(c)
   end),
   awful.button({ modkey }, 2, function(c)
      if c['last_state'] == nil then
         c.last_state = {
            floating = c.floating,
            ontop = c.ontop,
            maximised = c.maximised,
            fullscreen = c.fullscreen
         }

         c.maximised = false
         c.fullscreen = false
         c.floating = true
         c.ontop = true
      else
         c.maximised = c.last_state.maximised
         c.fullscreen = c.last_state.fullscreen
         c.floating = c.last_state.floating
         c.ontop = c.last_state.ontop

         c.last_state = nil
      end
   end),
   awful.button({ modkey }, 3, function(c)
      c:emit_signal("request::activate", "mouse_click", { raise = true })
      awful.mouse.client.resize(c)
   end)
)

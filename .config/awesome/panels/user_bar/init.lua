local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local dpi       = beautiful.xresources.apply_dpi

local card     = require("widgets.card")
local calendar = require("widgets.calendar").create()
local todo     = require("widgets.todo").create()
local player   = require("widgets.player.std")
local sliders  = require("widgets.sliders_set")
local profile  = require("widgets.profile")

return {
   create = function(s)

      local user = awful.wibar({
         position = "left",
         screen   = s,
         shape    = shape_utils.default_frr_lg,
         visible  = false,
         width    = dpi(600),
         height   = dpi(1020),
         margins  = {
            left = beautiful.useless_gap,
            right = beautiful.useless_gap,
         }
      })

      local header = card.create({
         profile,
         nil,
         -- require("widgets.weather").create(),
         layout = wibox.layout.align.horizontal
      })

      local play = {
         card.create(player),
         layout = wibox.layout.flex.horizontal
      }

      local sliders_and_calendar = {
         card.create(sliders),
         card.create(calendar),
         layout = wibox.layout.flex.horizontal
      }

      local tasks = {
         card.create(todo),
         layout = wibox.layout.flex.horizontal
      }

      user:setup {
         layout = wibox.layout.align.vertical,
         header,
         {
            layout = wibox.layout.flex.vertical,
            play,
            sliders_and_calendar,
            tasks,
         }
      }

      return user
   end
}

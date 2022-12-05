local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful").xresources.apply_dpi

local card = require("widgets.card")
local containers = card.create_with_header_placeholder(require("widgets.docker_containers").create())

return {
   create = function(s)
      local dev = awful.wibar({

         position = "left",
         screen   = s,
         shape    = shape_utils.default_frr,
         visible  = false,
         width    = dpi(380),
         height   = dpi(1020),

         margins = {
            left = dpi(15)
         }
      })

      dev:setup {
         containers,
         layout = wibox.layout.flex.vertical
      }

      return dev
   end
}

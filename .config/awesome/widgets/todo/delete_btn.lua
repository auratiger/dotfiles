local beautiful = require("beautiful")
local dpi       = beautiful.xresources.apply_dpi
local wibox     = require("wibox")

local icons = require("common.icons")

return {
   create = function()
      return wibox.widget {
         widget = wibox.container.margin,
         margins = dpi(5),
         icons.wbi("", 10),
         opacity = 1
      }
   end
}

local wibox     = require("wibox")
local beautiful = require("beautiful")
local dpi       = beautiful.xresources.apply_dpi

local widget_utils = {
   make_margin = function(content, margin)
      return {
         content,
         widget  = wibox.container.margin,
         margins = margin or dpi(10),
      }
   end
}

return widget_utils

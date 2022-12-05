local beautiful = require("beautiful")
local dpi       = beautiful.xresources.apply_dpi
local wibox     = require("wibox")

return {
   notification = function(n)
      return {
         notification = n,
         type = "notification",
         cursor = "hand2",
         shape = shape_utils.default_frr,
         maximum_width = 550,
         maximum_height = 120,
         bg = beautiful.bg_normal,
         widget_template =
         {
            {
               image = n.icon,
               resize = true,
               clip_shape = shape_utils.default_frr,
               halign = "center",
               valign = "center",
               widget = wibox.widget.imagebox,
            },
            {
               width    = 250,
               strategy = "min",
               layout   = wibox.layout.constraint
               {
                  {
                     widget = wibox.widget.textbox,
                     markup = "<span foreground='" .. beautiful.fg_focus .. "'><b>" .. n.title .. "</b></span>",
                     font   = beautiful.font_famaly .. '14',
                  },
                  {
                     widget = wibox.widget.textbox,
                     text = n.message
                  },
                  layout = wibox.layout.fixed.vertical,
                  widget = wibox.container.margin,
                  margin = dpi(10),
               }
            },
            layout  = wibox.layout.fixed.horizontal,
            spacing = 10,
         }
      }
   end
}

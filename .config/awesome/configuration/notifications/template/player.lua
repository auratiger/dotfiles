local beautiful = require("beautiful")
local dpi       = beautiful.xresources.apply_dpi
local wibox     = require("wibox")

local last_player_notification = nil

return {
   notification = function(n)
      if last_player_notification ~= nil then
         last_player_notification:destroy()
      end

      last_player_notification = n

      return {
         notification = n,
         type = "notification",
         cursor = "hand2",
         shape = shape_utils.default_frr_lg,
         maximum_width = 550,
         maximum_height = 120,
         bg = beautiful.bg_normal,
         widget_template =
         {
            spacing = 10,
            layout = wibox.layout.fixed.horizontal,
            {
               image = n.icon,
               resize = true,
               clip_shape = shape_utils.default_frr_lg,
               halign = "left",
               valign = "center",
               widget = wibox.widget.imagebox,
            },
            {
               width    = 250,
               strategy = "min",
               layout   = wibox.layout.constraint
               {
                  widget = wibox.container.margin,
                  margin = dpi(10),
                  {
                     spacing = 10,
                     layout = wibox.layout.fixed.vertical,
                     {
                        widget = wibox.widget.textbox,
                        markup = "<span foreground='" .. beautiful.fg_focus .. "'><b>" .. n.title .. "</b></span>",
                        font   = beautiful.font_famaly .. '14',
                     },
                     {
                        layout        = wibox.container.scroll.horizontal,
                        max_size      = 400,
                        speed         = 100,
                        step_function = wibox.container.scroll.step_functions.nonlinear_back_and_forth,
                        {
                           markup = "<b>" .. n.message .. "</b>",
                           widget = wibox.widget.textbox,
                           font   = beautiful.font_famaly .. '12',
                        },
                     }
                  }
               }
            }
         }
      }
   end
}

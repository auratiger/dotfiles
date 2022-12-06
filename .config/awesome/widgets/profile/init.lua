local wibox     = require("wibox")
local beautiful = require("beautiful")
local dpi       = beautiful.xresources.apply_dpi

local profile = {
   pic = function()
      return wibox.widget(
         {
            image      = beautiful.profile_pic,
            widget     = wibox.widget.imagebox,
            resize     = true,
            clip_shape = shape_utils.default_frr_lg,
            halign     = "center",
            valign     = "center",
         }
      )
   end
   ,
   name = function(size)
      return wibox.widget {
         id      = "profile",
         text    = user,
         align   = "center",
         opacity = 1,
         font    = beautiful.font_famaly .. " Bold " .. tostring(size),
         widget  = wibox.widget.textbox,
      }
   end
}


return wibox.widget(
   {
      {
         profile.pic(),
         {
            profile.name(12),
            widget = wibox.container.margin,
            left   = dpi(15)
         },
         layout = wibox.layout.fixed.horizontal
      },
      widget        = wibox.container.background,
      forced_width  = dpi(300),
      forced_height = dpi(50),
   }
)

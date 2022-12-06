local awful     = require("awful")
local wibox     = require("wibox")
local gears     = require("gears")
local beautiful = require("beautiful")
local dpi       = beautiful.xresources.apply_dpi

local icons = require("common.icons")

local module = {
   create = function(title, text, notif_icon, parent)
      local icon_widget = icons.wbic("", 25, beautiful.fg_focus)

      if notif_icon then
         icon_widget = {
            image         = notif_icon,
            resize        = true,
            widget        = wibox.widget.imagebox,
            forced_width  = dpi(200),
            forced_height = dpi(200),
         }
      end

      local close_icon = wibox.widget({
         id      = "icon",
         markup  = "<span foreground='" .. beautiful.fg_focus .. "'>" .. "" .. "</span>",
         align   = "center",
         opacity = 0,
         font    = beautiful.icons_font .. 20,
         widget  = wibox.widget.textbox,
      })

      local title_section = {
         markup  = "<span foreground='" .. beautiful.fg_focus .. "'><b>" .. title .. "</b></span>",
         align   = "left",
         opacity = 1,
         font    = beautiful.font_famaly .. '20',
         widget  = wibox.widget.textbox,
      }

      local message_section = {
         text    = text,
         align   = "left",
         opacity = 1,
         font    = beautiful.font_famaly .. '15',
         widget  = wibox.widget.textbox,
      }

      local notification = wibox.widget({
         {
            layout = wibox.layout.flex.horizontal,
            icon_widget,
            {
               layout = wibox.layout.flex.vertical,
               bg     = beautiful.palette_c7,
               widget = wibox.container.background,
               {
                  title_section,
                  close_icon,
                  layout = wibox.layout.flex.horizontal,
               },
               message_section,
            }
         },
         bg     = beautiful.palette_c6,
         shape  = shape_utils.rounded_rect(dpi(6)),
         widget = wibox.container.background,
         height = dpi(30),
      })

      close_icon:buttons(gears.table.join(awful.button({}, 1, function()
         parent:remove_widgets(notification, true)
      end)))

      notification:connect_signal('mouse::enter', function()
         close_icon.opacity = 1
      end)

      notification:connect_signal('mouse::leave', function()
         close_icon.opacity = 0
      end)

      return notification
   end
}

return module

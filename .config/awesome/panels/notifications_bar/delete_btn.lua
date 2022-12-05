local awful     = require("awful")
local gears     = require("gears")
local beautiful = require("beautiful")
local wibox     = require("wibox")

local delete_btn = {
   create = function(content)
      local delete_all_notif = wibox.widget {
         text    = "Delete All",
         font    = beautiful.font,
         align   = "center",
         opacity = 1,
         widget  = wibox.widget.textbox,
      }

      delete_all_notif:buttons(gears.table.join(awful.button({}, 1, function()
         content:reset()
      end)))

      return delete_all_notif;
   end
}

return delete_btn

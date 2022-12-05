local awful = require("awful")
local gears = require("gears")
local icons = require("common.icons")

return {
   create = function()
      local notif_icon = icons.wbic("", 14)

      notif_icon:buttons(gears.table.join(awful.button({}, 1, function()
         awesome.emit_signal('notifcenter::toggle')
      end)))

      return notif_icon

   end
}

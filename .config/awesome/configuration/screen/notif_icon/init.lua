local awful = require("awful")
local gears = require("gears")
local icons = require("common.icons")

return {
   create = function(s)
      local notif_icon = icons.wbi("", 14)

      notif_icon:buttons(gears.table.join(awful.button({}, 1, function()
         s.notif.visible = not s.notif.visible
      end)))

      return notif_icon

   end
}

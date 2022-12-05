local awful = require("awful")
local gears = require("gears")
local icons = require("common.icons")

return {
   create = function(s)
      local notif_icon = icons.wbic("", 14)

      notif_icon:buttons(gears.table.join(awful.button({}, 1, function()
         s.notif.visible = not s.notif.visible
         notif_icon.toggle()
      end)))

      return notif_icon

   end
}

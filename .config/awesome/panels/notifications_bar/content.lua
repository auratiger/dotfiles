local wibox     = require("wibox")
local beautiful = require("beautiful")
local dpi       = beautiful.xresources.apply_dpi
local naughty   = require('naughty')

local delete_btn = require("panels.notifications_bar.delete_btn")
local notification_card = require("panels.notifications_bar.notif_card")

local notifications = wibox.widget({
   layout           = require("dependencies.overflow").vertical,
   spacing          = dpi(8),
   scrollbar_widget = {
      widget = wibox.widget.separator,
      shape  = shape_utils.default_frr_lg,
   },
   scrollbar_width  = dpi(8),
   step             = 50,
})

local is_relevant_to_add = function(n)
   return true

   -- if n.app_name == "Player" then
   --    return false
   -- else
   --    return true
   -- end
end

local add = function(n, notif_icon)
   n:connect_signal('destroyed',
      function(self, reason, keep_visble)
         if is_relevant_to_add(n) then
            local notif = notification_card.create(n.app_name, n.message, notif_icon, notifications)
            notifications:insert(1, notif)
         end
      end
   )
end

naughty.connect_signal('added',
   function(n)
      local notif_icon = n.icon or n.app_icon
      add(n, notif_icon)
   end
)

local content = wibox.widget({
   layout  = wibox.layout.fixed.vertical,
   spacing = dpi(8),
   delete_btn.create(notifications),
   notifications
})

return require("widgets.card").create_with_header("Notifications", content)

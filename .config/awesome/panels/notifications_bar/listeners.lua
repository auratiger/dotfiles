local awful = require("awful")

local function get_notifcenter()
   return awful.screen.focused().notifcenter
end

awesome.connect_signal('notifcenter::toggle', function()
   local notifcenter = get_notifcenter();
   notifcenter.icon.toggle()
   notifcenter.toggle()
end)

awesome.connect_signal('notifcenter::visibility', function(visibility)
   if visibility then
      get_notifcenter().open()
   else
      get_notifcenter().hide()
   end
end)

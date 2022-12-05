local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")

require("panels.notifications_bar.listeners")

awful.screen.connect_for_each_screen(function(s)
   s.notifcenter = {}

   s.notifcenter.popup = wibox {
      screen = s,
      ontop = true,
      visible = false,
      bg = beautiful.bg_normal,
      fg = beautiful.fg_normal,
      width = 400,
      height = s.geometry.height - 100,
   }

   s.notifcenter.icon = require("panels.notifications_bar.notif_icon").create()

   local content = require("panels.notifications_bar.content")
   s.notifcenter.popup:setup(content)

   awful.placement.top_right(s.notifcenter.popup, { margins = { top = 60, right = 40 }, parent = s })

   local self = s.notifcenter.popup

   function s.notifcenter.open()
      self.visible = true
   end

   function s.notifcenter.hide()
      self.visible = false
   end

   function s.notifcenter.toggle()
      if self.visible then
         s.notifcenter.hide()
      else
         s.notifcenter.open()
      end
   end
end)

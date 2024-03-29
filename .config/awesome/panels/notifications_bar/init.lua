local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local dpi       = beautiful.xresources.apply_dpi

require("panels.notifications_bar.listeners")

awful.screen.connect_for_each_screen(function(s)
   s.notifcenter = {}

   s.notifcenter.popup = wibox {
      screen  = s,
      ontop   = true,
      visible = false,
      bg      = beautiful.bg_normal,
      fg      = beautiful.fg_normal,
      width   = 500,
      shape   = shape_utils.default_frr_lg,
      -- height = s.geometry.height - 100,
      height  = dpi(1020),
   }

   s.notifcenter.icon = require("panels.notifications_bar.notif_icon").create()

   local content = require("panels.notifications_bar.content")
   s.notifcenter.popup:setup({
      content,
      layout = wibox.layout.flex.vertical
   })

   awful.placement.right(s.notifcenter.popup, { margins = { right = 40 }, parent = s })

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

local awful     = require("awful")
local beautiful = require("beautiful")
local dpi       = beautiful.xresources.apply_dpi
local wibox     = require("wibox")

local taglist_buttons = my_table.join(
   awful.button({}, 1, function(t) t:view_only() end),

   awful.button({ modkey }, 1, function(t)
      if client.focus then
         client.focus:move_to_tag(t)
      end
   end),

   awful.button({}, 3, awful.tag.viewtoggle),

   awful.button({ modkey }, 3, function(t)
      if client.focus then
         client.focus:toggle_tag(t)
      end
   end),

   awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
   awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

return {

   create = function(s)


      local name_section = {
         {
            {
               id     = 'text_role',
               widget = wibox.widget.textbox,
            },
            layout = wibox.layout.fixed.horizontal,
         },
         left   = 12,
         right  = 12,
         widget = wibox.container.margin
      }

      local tag_template = {
         id     = 'background_role',
         widget = wibox.container.background,
         {
            bg     = beautiful.palette_c7,
            shape  = cfg.screens[s.index].shape,
            widget = wibox.container.background,
            name_section,
         },
      }

      -- return awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)
      return awful.widget.taglist {
         screen  = s,
         filter  = awful.widget.taglist.filter.all,
         buttons = taglist_buttons,

         style = {
            shape = cfg.screens[s.index].shape,
         },

         layout = {
            spacing = dpi(5),
            layout  = wibox.layout.fixed.horizontal
         },

         widget_template = tag_template
      }
   end
}

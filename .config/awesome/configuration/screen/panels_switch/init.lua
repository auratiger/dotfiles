local awful     = require("awful")
local gears     = require("gears")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local dpi       = beautiful.xresources.apply_dpi

local icons = require("common.icons")

local sub_panel_mode = sub_panel_mode
local show_sub_panel = show_sub_panel

local panels = {}

local close_all_sub_panels = function(s)
   local screen_panels = panels[s.index]

   for _, panel in ipairs(screen_panels) do
      panel.visible = false
   end
end

local create_menu_panel_button = function(glyph, mode, screen, panel)

   local toggle_panel = function()

      local close = function()
         panel.visible  = false
         show_sub_panel = false
      end

      local close_active = function()
         show_sub_panel = false
         close_all_sub_panels(screen)
      end

      if sub_panel_mode == mode and show_sub_panel then
         close()
      else
         if (not sub_panel_mode) ~= mode then
            close_active()
         end

         sub_panel_mode = mode
         show_sub_panel = true
         panel.visible  = true
      end
   end

   local icon = icons.wbic(glyph, beautiful.font_size)

   local btn = wibox.widget {
      bg     = beautiful.palette_c7,
      shape  = shape_utils.tags_shape,
      widget = wibox.container.background,
      {
         icon,
         widget = wibox.container.margin,
         left = 15,
         right = 15
         -- margins = dpi(10),
      },
   }

   awful.tooltip {
      objects        = { btn },
      timer_function = function()
         return mode
      end,
   }

   -- asign the toggle function to each panel
   panel.toggle = function()
      toggle_panel()
      icon.toggle()
   end

   btn:buttons(gears.table.join(awful.button({}, 1, function()
      toggle_panel()
      icon.toggle()
   end)))


   btn:connect_signal('mouse::enter', function()
      btn.opacity = beautiful.focus_opacity
   end)

   btn:connect_signal('mouse::leave', function()
      btn.opacity = beautiful.normal_opacity
   end)

   return btn
end

return {
   add_panel = function(s, panel)
      if panels[s.index] == nil then
         panels[s.index] = {}
      end

      table.insert(panels[s.index], panel)
   end,

   create = function(s)
      local body = wibox.layout.fixed.horizontal()
      body.spacing = dpi(5)

      if cfg.panels.user.enabled then
         body:add(create_menu_panel_button("  ", "User", s, s.user))
      end

      if cfg.panels.packages.enabled then
         body:add(create_menu_panel_button("", "Packages", s, s.pacs))
      end

      if cfg.panels.git.enabled then
         body:add(create_menu_panel_button("", "Repos", s, s.repos))
      end

      if cfg.panels.docker.enabled then
         body:add(create_menu_panel_button("", "Docker", s, s.docker))
      end

      if cfg.panels.stats.enabled then
         body:add(create_menu_panel_button("  ", "Stats", s, s.stats))
      end

      return body
   end
}

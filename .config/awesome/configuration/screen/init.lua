local awful     = require("awful")
local gears     = require("gears")
local beautiful = require("beautiful")

require("configuration.screen.rclick_menu")

local wibar = require("configuration.screen.wibar")

local panels_switch = require("configuration.screen.panels_switch")
local stat_bar      = require("panels.stat_bar")
local user_bar      = require("panels.user_bar")
local docker_bar    = require("panels.docker_bar")

awful.util.terminal = terminal

-- {{{ Screen
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
   -- Wallpaper
   if beautiful.wallpaper then
      local wallpaper = beautiful.wallpaper
      -- If wallpaper is a function, call it with the screen
      if type(wallpaper) == "function" then
         wallpaper = wallpaper(s)
      end
      gears.wallpaper.maximized(wallpaper, s, true)
   end
end)

-- No borders when rearranging only 1 non-floating or maximized client
screen.connect_signal("arrange", function(s)
   local only_one = #s.tiled_clients == 1
   for _, c in pairs(s.clients) do
      if only_one and not c.floating or c.maximized then
         c.border_width = 2
      else
         c.border_width = beautiful.border_width
      end
   end
end)

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
   -- Set the windows at the slave,
   -- i.e. put it at the end of others instead of setting it master.
   -- if not awesome.startup then awful.client.setslave(c) end

   if awesome.startup and
       not c.size_hints.user_position
       and not c.size_hints.program_position then
      -- Prevent clients from being unreachable after screen count changes.
      awful.placement.no_offscreen(c)
   end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
   -- Custom
   if beautiful.titlebar_fun then
      beautiful.titlebar_fun(c)
      return
   end

   -- Default
   -- buttons for the titlebar
   local buttons = my_table.join(
      awful.button({}, 1, function()
         c:emit_signal("request::activate", "titlebar", { raise = true })
         awful.mouse.client.move(c)
      end),
      awful.button({}, 3, function()
         c:emit_signal("request::activate", "titlebar", { raise = true })
         awful.mouse.client.resize(c)
      end)
   )

   awful.titlebar(c, { size = dpi(21) }):setup {
      { -- Left
         awful.titlebar.widget.iconwidget(c),
         buttons = buttons,
         layout  = wibox.layout.fixed.horizontal
      },
      { -- Middle
         { -- Title
            align  = "center",
            widget = awful.titlebar.widget.titlewidget(c)
         },
         buttons = buttons,
         layout  = wibox.layout.flex.horizontal
      },
      { -- Right
         awful.titlebar.widget.floatingbutton(c),
         awful.titlebar.widget.maximizedbutton(c),
         awful.titlebar.widget.stickybutton(c),
         awful.titlebar.widget.ontopbutton(c),
         awful.titlebar.widget.closebutton(c),
         layout = wibox.layout.fixed.horizontal()
      },
      layout = wibox.layout.align.horizontal
   }
end)


-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
   c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)


-- NOTE: Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s)
   show_sub_panel = false
   sub_panel_mode = 'user'

   if cfg.panels.stats.enabled then
      s.stats = stat_bar.create(s)
      panels_switch.add_panel(s, s.stats)
   end

   if cfg.panels.user.enabled then
      s.user = user_bar.create(s)
      panels_switch.add_panel(s, s.user)
   end

   if cfg.panels.docker.enabled then
      s.docker = docker_bar.create(s)
      panels_switch.add_panel(s, s.docker)
   end

   wibar.create(s)
end)
-- }}}

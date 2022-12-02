--[[

     Awesome WM configuration template
     https://github.com/awesomeWM

     Freedesktop : https://github.com/lcpz/awesome-freedesktop

     Copycats themes : https://github.com/lcpz/awesome-copycats
lain : https://github.com/lcpz/lain

--]]

--https://awesomewm.org/doc/api/documentation/05-awesomerc.md.html
-- Standard awesome library
--
require("awful.autofocus")
local awful     = require("awful") --Everything related to window managment
local wibox     = require("wibox") -- Widget and layout library
local beautiful = require("beautiful") -- Theme handling library

require("common.nd_utils")

local naughty = require("naughty") -- Notification library

--local menubar       = require("menubar")
local lain = require("lain")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
-- require("awful.hotkeys_popup.keys")
local dpi = require("beautiful.xresources").apply_dpi
-- }}}

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
   naughty.notify({ preset = naughty.config.presets.critical,
      title = "Oops, there were errors during startup!",
      text = awesome.startup_errors })
end

do -- Handle runtime errors after startup
   local in_error = false
   awesome.connect_signal("debug::error", function(err)
      if in_error then return end
      in_error = true

      naughty.notify({ preset = naughty.config.presets.critical,
         title = "Oops, an error happened!",
         text = tostring(err) })
      in_error = false
   end)
end
-- }}}

-- {{{ Autostart windowless processes
local function run_once(cmd_arr)
   for _, cmd in ipairs(cmd_arr) do
      awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
   end
end

run_once({ "unclutter -root" }) -- entries must be comma-separated


require("config")


local themes = { -- keep themes in alfabetical order for ATT
   "custom", -- 1
}

local chosen_theme = themes[1] -- choose your theme here
local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", home_folder, chosen_theme)
beautiful.init(theme_path)

-- awesome variables
awful.util.terminal = terminal

lain.layout.termfair.nmaster           = 3
lain.layout.termfair.ncol              = 1
lain.layout.termfair.center.nmaster    = 3
lain.layout.termfair.center.ncol       = 1
lain.layout.cascade.tile.offset_x      = dpi(2)
lain.layout.cascade.tile.offset_y      = dpi(32)
lain.layout.cascade.tile.extra_padding = dpi(5)
lain.layout.cascade.tile.nmaster       = 5
lain.layout.cascade.tile.ncol          = 2
-- }}}


require("bindings")
require("layout")
require("screen")
require("notifications")
require("common.playerctl")
require("rules")

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

-- Autostart applications
awful.spawn.with_shell("~/.config/awesome/autostart.sh")
awful.spawn.with_shell("picom -b --config  $HOME/.config/awesome/picom.conf")

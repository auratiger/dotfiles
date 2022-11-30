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
local gears     = require("gears") --Utilities such as color parsing and objects
local awful     = require("awful") --Everything related to window managment
local wibox     = require("wibox") -- Widget and layout library
local beautiful = require("beautiful") -- Theme handling library

local naughty = require("naughty") -- Notification library
naughty.config.defaults['icon_size'] = 100

--local menubar       = require("menubar")
local lain        = require("lain")
local freedesktop = require("freedesktop")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
local hotkeys_popup = require("awful.hotkeys_popup").widget
-- require("awful.hotkeys_popup.keys")
local dpi = require("beautiful.xresources").apply_dpi
-- }}}

my_table    = awful.util.table or gears.table -- 4.{0,1} compatibility
home_folder = os.getenv("HOME")

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
-- }}}

-- This function implements the XDG autostart specification
--[[
awful.spawn.with_shell(
    'if (xrdb -query | grep -q "^awesome\\.started:\\s*true$"); then exit; fi;' ..
    'xrdb -merge <<< "awesome.started:true";' ..
    -- list each of your autostart commands, followed by ; inside single quotes, followed by ..
    'dex --environment Awesome --autostart --search-paths "$XDG_CONFIG_DIRS/autostart:$XDG_CONFIG_HOME/autostart"' -- https://github.com/jceb/dex
)
--]]

-- }}}

-- {{{ Variable definitions

local themes = { -- keep themes in alfabetical order for ATT
   "blackburn", -- 1
   "copland", -- 2
   "multicolor", -- 3
   "powerarrow", -- 4
   "powerarrow-blue", -- 5
   "powerarrow-dark", -- 6
}

local chosen_theme = themes[3] -- choose your theme here

local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", home_folder, chosen_theme)
beautiful.init(theme_path)

-- modkey or mod4 = super key
modkey = "Mod4"
altkey = "Mod1"

-- personal variables
--change these variables if you want
browser1       = "vivaldi-stable"
browser2       = "firefox"
browser3       = "chromium -no-default-browser-check"
terminal       = "alacritty"
editor         = os.getenv("EDITOR") or "nvim"
editor_cmd     = terminal .. " -e " .. editor
editorgui      = "code"
filemanager    = "thunar"
mailclient     = "evolution"
mediaplayer    = "vlc"
musicplayer    = "spotify"
virtualmachine = "virtualbox"
chat           = "discord"

-- awesome variables
awful.util.terminal = terminal
awful.util.tagnames = { "➊", "➋", "➌", "➍", "➎", "➏", "➐", "➑", "➒" }
--awful.util.tagnames = { "⠐", "⠡", "⠲", "⠵", "⠻", "⠿" }
--awful.util.tagnames = { "⌘", "♐", "⌥", "ℵ" }
--awful.util.tagnames = { "www", "edit", "gimp", "inkscape", "music" }
-- Use this : https://fontawesome.com/cheatsheet
--awful.util.tagnames = { "", "", "", "", "" }

awful.util.taglist_buttons = my_table.join(
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

awful.util.tasklist_buttons = my_table.join(
   awful.button({}, 1, function(c)
      if c == client.focus then
         c.minimized = true
      else
         --c:emit_signal("request::activate", "tasklist", {raise = true})<Paste>

         -- Without this, the following
         -- :isvisible() makes no sense
         c.minimized = false
         if not c:isvisible() and c.first_tag then
            c.first_tag:view_only()
         end
         -- This will also un-minimize
         -- the client, if needed
         client.focus = c
         c:raise()
      end
   end),
   awful.button({}, 3, function()
      local instance = nil

      return function()
         if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
         else
            instance = awful.menu.clients({ theme = { width = dpi(250) } })
         end
      end
   end),
   awful.button({}, 4, function() awful.client.focus.byidx(1) end),
   awful.button({}, 5, function() awful.client.focus.byidx(-1) end)
)

lain.layout.termfair.nmaster           = 3
lain.layout.termfair.ncol              = 1
lain.layout.termfair.center.nmaster    = 3
lain.layout.termfair.center.ncol       = 1
lain.layout.cascade.tile.offset_x      = dpi(2)
lain.layout.cascade.tile.offset_y      = dpi(32)
lain.layout.cascade.tile.extra_padding = dpi(5)
lain.layout.cascade.tile.nmaster       = 5
lain.layout.cascade.tile.ncol          = 2

beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", home_folder, chosen_theme))
-- }}}

-- {{{ Menu
local myawesomemenu = {
   { "hotkeys", function() return false, hotkeys_popup.show_help end },
   { "arandr", "arandr" },
}

awful.util.mymainmenu = freedesktop.menu.build({
   before = {
      { "Awesome", myawesomemenu },
      --{ "Atom", "atom" },
      -- other triads can be put here
   },
   after = {
      { "Terminal", terminal },
      { "Log out", function() awesome.quit() end },
      { "Sleep", "systemctl suspend" },
      { "Restart", "systemctl reboot" },
      { "Shutdown", "systemctl poweroff" },
      -- other triads can be put here
   }
})
-- hide menu when mouse leaves it
--awful.util.mymainmenu.wibox:connect_signal("mouse::leave", function() awful.util.mymainmenu:hide() end)

--menubar.utils.terminal = terminal -- Set the Menubar terminal for applications that require it
-- }}}


require("bindings")
require("layout")
require("screen")

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
   -- All clients will match this rule.
   { rule = {},
      properties = { border_width = beautiful.border_width,
         border_color = beautiful.border_normal,
         focus = awful.client.focus.filter,
         raise = true,
         keys = clientkeys,
         buttons = clientbuttons,
         screen = awful.screen.preferred,
         placement = awful.placement.no_overlap + awful.placement.no_offscreen,
         size_hints_honor = false
      }
   },

   -- Titlebars
   { rule_any = { type = { "dialog", "normal" } },
      properties = { titlebars_enabled = false } },
   -- Set applications to always map on the tag 2 on screen 1.
   --{ rule = { class = "Subl" },
   --properties = { screen = 1, tag = awful.util.tagnames[2], switchtotag = true  } },


   -- Set applications to always map on the tag 1 on screen 1.
   -- find class or role via xprop command
   --{ rule = { class = browser2 },
   --properties = { screen = 1, tag = awful.util.tagnames[1], switchtotag = true  } },

   --{ rule = { class = browser1 },
   --properties = { screen = 1, tag = awful.util.tagnames[1], switchtotag = true  } },

   --{ rule = { class = "Vivaldi-stable" },
   --properties = { screen = 1, tag = awful.util.tagnames[1], switchtotag = true } },

   --{ rule = { class = "Chromium" },
   --properties = { screen = 1, tag = awful.util.tagnames[1], switchtotag = true  } },

   --{ rule = { class = "Opera" },
   --properties = { screen = 1, tag = awful.util.tagnames[1],switchtotag = true  } },

   -- Set applications to always map on the tag 2 on screen 1.
   --{ rule = { class = "Subl" },
   --properties = { screen = 1, tag = awful.util.tagnames[2],switchtotag = true  } },

   --{ rule = { class = editorgui },
   --properties = { screen = 1, tag = awful.util.tagnames[2], switchtotag = true  } },

   --{ rule = { class = "Brackets" },
   --properties = { screen = 1, tag = awful.util.tagnames[2], switchtotag = true  } },

   --{ rule = { class = "Code" },
   --properties = { screen = 1, tag = awful.util.tagnames[2], switchtotag = true  } },

   --    { rule = { class = "Geany" },
   --  properties = { screen = 1, tag = awful.util.tagnames[2], switchtotag = true  } },


   -- Set applications to always map on the tag 3 on screen 1.
   --{ rule = { class = "Inkscape" },
   --properties = { screen = 1, tag = awful.util.tagnames[3], switchtotag = true  } },

   -- Set applications to always map on the tag 4 on screen 1.
   --{ rule = { class = "Gimp" },
   --properties = { screen = 1, tag = awful.util.tagnames[4], switchtotag = true  } },

   -- Set applications to always map on the tag 5 on screen 1.
   --{ rule = { class = "Meld" },
   --properties = { screen = 1, tag = awful.util.tagnames[5] , switchtotag = true  } },


   -- Set applications to be maximized at startup.
   -- find class or role via xprop command

   { rule = { class = editorgui },
      properties = { maximized = true } },

   { rule = { class = "Geany" },
      properties = { maximized = false, floating = false } },

   -- { rule = { class = "Thunar" },
   --     properties = { maximized = false, floating = false } },

   { rule = { class = "Gimp*", role = "gimp-image-window" },
      properties = { maximized = true } },

   { rule = { class = "Gnome-disks" },
      properties = { maximized = true } },

   { rule = { class = "inkscape" },
      properties = { maximized = true } },

   { rule = { instance = musicplayer },
      properties = { screen = 1, tag = awful.util.tagnames[2], switchtotag = true, maximized = true } },

   { rule = { class = "Vlc" },
      properties = { maximized = true } },

   { rule = { class = "VirtualBox Manager" },
      properties = { maximized = true } },

   { rule = { class = "VirtualBox Machine" },
      properties = { maximized = true } },

   { rule = { instance = browser1 },
      properties = { screen = 1, tag = awful.util.tagnames[1], switchtotag = true, fullscreen = true } },

   --    { rule = { class = "Vivaldi-stable" },
   --          properties = { callback = function (c) c.maximized = false end } },

   --IF using Vivaldi snapshot you must comment out the rules above for Vivaldi-stable as they conflict
   --    { rule = { class = "Vivaldi-snapshot" },
   --          properties = { maximized = false, floating = false } },

   --    { rule = { class = "Vivaldi-snapshot" },
   --          properties = { callback = function (c) c.maximized = false end } },
   --
   { rule = { instance = chat },
      properties = { screen = 1, tag = awful.util.tagnames[3], switchtotag = true, maximized = true } },

   { rule = { class = "Xfce4-settings-manager" },
      properties = { floating = false } },

   -- Floating clients.
   { rule_any = {
      instance = {
         "DTA", -- Firefox addon DownThemAll.
         "copyq", -- Includes session name in class.
      },
      class = {
         "Arandr",
         "Arcolinux-welcome-app.py",
         "Blueberry",
         "Galculator",
         "Gnome-font-viewer",
         "Gpick",
         "Imagewriter",
         "Font-manager",
         "Kruler",
         "MessageWin", -- kalarm.
         "archlinux-logout",
         "Peek",
         "Skype",
         "System-config-printer.py",
         "Sxiv",
         "Unetbootin.elf",
         "Wpa_gui",
         "pinentry",
         "veromix",
         "xtightvncviewer",
         "Xfce4-terminal"
      },

      name = {
         "Event Tester", -- xev.
      },
      role = {
         "AlarmWindow", -- Thunderbird's calendar.
         "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
         "Preferences",
         "setup",
      }
   }, properties = { floating = true } },

   -- Floating clients but centered in screen
   { rule_any = {
      class = {
         "Polkit-gnome-authentication-agent-1",
         "Arcolinux-calamares-tool.py"
      },
   },
      properties = { floating = true },
      callback = function(c)
         awful.placement.centered(c, nil)
      end }
}
-- }}}

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


-- }}}

-- Autostart applications
awful.spawn.with_shell("~/.config/awesome/autostart.sh")
awful.spawn.with_shell("picom -b --config  $HOME/.config/awesome/picom.conf")

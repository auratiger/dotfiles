local awful         = require("awful")
local beautiful     = require("beautiful")
-- local hotkeys_popup = require("awful.hotkeys_popup")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local menubar       = require("menubar")

local freedesktop = require("configuration.screen.rclick_menu.freedesktop")

-- {{{ Menu
local myawesomemenu = {
   { "hotkeys", function() return false, hotkeys_popup.show_help end },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "arandr", "arandr" },
}

-- TODO: setup icons for all the options
awful.util.mymainmenu = freedesktop.menu.build({
   before = {
      { "Awesome", myawesomemenu, beautiful.awesome_icon },
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
-- awful.util.mymainmenu.wibox:connect_signal("mouse::leave", function() awful.util.mymainmenu:hide() end)

menubar.utils.terminal = terminal -- Set the Menubar terminal for applications that require it
-- }}}

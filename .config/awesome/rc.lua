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
local beautiful = require("beautiful") -- Theme handling library
local naughty   = require("naughty") -- Notification library

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
-- require("awful.hotkeys_popup.keys")

-- NOTE: {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
   naughty.notify({ preset = naughty.config.presets.critical,
      title = "Oops, there were errors during startup!",
      text = awesome.startup_errors })
end

do -- NOTE: Handle runtime errors after startup
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

-- NOTE: Autostart windowless processes
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

require("common.nd_utils")
require("global_events")
require("common.widget_factory")
require("bindings")
require("layout")
require("screen")
require("notifications")
require("rules")

-- Autostart applications
awful.spawn.with_shell("~/.config/awesome/autostart.sh")
awful.spawn.with_shell("picom -b --config  $HOME/.config/awesome/picom.conf")

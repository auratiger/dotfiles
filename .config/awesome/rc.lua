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
pcall(require, "luarocks.loader")

revelation = require("plugins.revelation")

require("awful.autofocus")

local awful   = require("awful") --Everything related to window managment
local naughty = require("naughty") -- Notification library

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

require("common.utils")
require("user_settings")
require("configuration")

-- Autostart applications
awful.spawn.with_shell("~/.config/awesome/scripts/autostart.sh")
awful.spawn.with_shell("picom -b --config  $HOME/.config/awesome/picom.conf")



-- https://github.com/ivaaaan/smug
local tmux_sessions = { "lvim", "zshdot", "project", "awesome", "sliddo" }
local initiate_tmux_session = ""

for _, v in ipairs(tmux_sessions) do
   initiate_tmux_session = initiate_tmux_session .. string.format("smug start %s --detach; ", v)
end

awful.spawn.easy_async_with_shell(initiate_tmux_session, function()
   awful.spawn.spawn(tmux)
end)

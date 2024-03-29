local awful         = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local beautiful     = require("beautiful")
local spotify       = require("common.spotify")

local modkey, altkey, filemanager, terminal, browser, browser1, browser2, browser3, virtualmachine, musicplayer, mailclient, discord = modkey
    , altkey, filemanager, terminal, browser, browser1, browser2, browser3, virtualmachine, musicplayer, mailclient,
    discord

local my_table, client, screen, awesome = my_table, client, screen, awesome

--- UTILS

local matcher = function(c, value)
   return awful.rules.match(c, { class = value }) or
       awful.rules.match(c, { name = value }) or
       awful.rules.match(c, { instance = value })
end

local raise_or_spawn = function(instance)
   awful.client.run_or_raise(instance, function(c) return matcher(c, instance) end)
end

-- {{{ Key bindings
globalkeys = my_table.join(

-- Function keys
-- -----------------------------
-- | SUPER + ... function keys |
-- -----------------------------
--
   awful.key({ modkey }, "F1", function()
      awful.spawn(cava, {
         floating    = true,
         tag         = cfg.screens[2].tags[2],
         screen      = 2,
         switchtotag = false,
         placement   = awful.placement.top_right,
         width       = 500,
         height      = 300,
      })
   end,
      { description = musicplayer, group = "function keys" }),
   -- awful.key({ modkey }, "F2", function() awful.util.spawn(editorgui) end,
   --    { description = editorgui, group = "function keys" }),
   -- awful.key({ modkey }, "F3", function() awful.util.spawn("inkscape") end,
   --    { description = "inkscape", group = "function keys" }),
   awful.key({ modkey }, "F4", function() awful.util.spawn("gimp") end,
      { description = "gimp", group = "function keys" }),
   awful.key({ modkey }, "F5", function() awful.util.spawn("discord") end,
      { description = "discord", group = "function keys" }),
   awful.key({ modkey }, "F6", function() awful.util.spawn("vlc --video-on-top") end,
      { description = "vlc", group = "function keys" }),
   awful.key({ modkey }, "F7", function() awful.util.spawn(virtualmachine) end,
      { description = virtualmachine, group = "function keys" }),
   awful.key({ modkey }, "F8", function() awful.util.spawn(filemanager) end,
      { description = filemanager, group = "function keys" }),
   awful.key({ modkey }, "F9", function() awful.util.spawn(mailclient) end,
      { description = mailclient, group = "function keys" }),

   awful.key({ modkey }, "F10", function() awful.spawn.with_shell(commands.audio_device_switch) end,
      { description = "change audio device", group = "function keys" }),

   awful.key({ modkey }, "F11",
      function()
         awful.spawn(string.format("dmenu_run -i -nb '#191919' -nf '#fea63c' -sb '#fea63c' -sf '#191919' -fn NotoMonoRegular:bold:pixelsize=14"
            ,
            beautiful.bg_normal, beautiful.fg_normal, beautiful.bg_focus, beautiful.fg_focus))
      end,
      { description = "show dmenu", group = "hotkeys" }),

   awful.key({ modkey }, "F12", function() awful.util.spawn("rofi -show drun") end,
      { description = "rofi", group = "function keys" }),

   -- ---------------
   -- | SUPER + ... |
   -- ---------------
   --
   -- awful.key({ modkey }, "c", function() awful.util.spawn("conky-toggle") end,
   --    { description = "conky-toggle", group = "super" }),
   --
   -- awful.key({ "Control", modkey }, "c", function() awful.util.spawn("killall conky") end,
   --    { description = "conky killall", group = "super" }),
   --
   --awful.key({ modkey }, "h", function () awful.util.spawn( "urxvt -T 'htop task manager' -e htop" ) end,
   --{description = "htop", group = "super"}),
   awful.key({ modkey, }, ".", function()
      revelation({ rule = { class = "conky" }, is_excluded = true, curr_tag_only = true })
   end),

   awful.key({ modkey }, "b", function() raise_or_spawn(browser1) end,
      { description = browser1, group = "hotkeys" }),

   awful.key({ modkey }, "p", function() raise_or_spawn(postman) end,
      { description = postman, group = "hotkeys" }),

   awful.key({ modkey }, "i", function() raise_or_spawn("mongodb-compass") end,
      { description = mongocompass, group = "hotkeys" }),

   awful.key({ modkey }, "[", function() raise_or_spawn(musicplayer) end,
      { description = musicplayer, group = "hotkeys" }),

   awful.key({ modkey }, "]", function() raise_or_spawn(discord) end,
      { description = discord, group = "hotkeys" }),

   awful.key({ modkey }, "'", function() awful.util.spawn("rofi -show drun") end,
      { description = "rofi", group = "hotkeys" }),

   awful.key({ modkey, }, "s", hotkeys_popup.show_help,
      { description = "show help", group = "awesome" }),

   awful.key({ modkey, }, "Return", function() awful.spawn(terminal) end,
      { description = terminal, group = "hotkeys" }),

   awful.key({ modkey }, "r", function() awful.util.spawn("rofi-theme-selector") end,
      { description = "rofi theme selector", group = "hotkeys" }),

   awful.key({ modkey }, "v", function() awful.util.spawn("pavucontrol") end,
      { description = "pulseaudio control", group = "hotkeys" }),

   --awful.key({ modkey }, "u", function () awful.screen.focused().mypromptbox:run() end,
   --{description = "run prompt", group = "super"}),

   awful.key({ modkey }, "x", function() awful.util.spawn("archlinux-logout") end,
      { description = "exit", group = "hotkeys" }),

   awful.key({ modkey }, "Escape", function() awful.util.spawn("xkill") end,
      { description = "Kill proces", group = "hotkeys" }),

   -- Show/Hide Wibox
   awful.key({ modkey }, "w", function()
      for s in screen do
         s.mywibar.visible = not s.mywibar.visible
         if s.mybottomwibox then
            s.mybottomwibox.visible = not s.mybottomwibox.visible
         end
      end
   end,
      { description = "toggle wibox", group = "awesome" }),

   -- Show/Hide Systray
   awful.key({ modkey }, "-", function()
      awful.screen.focused().systray.visible = not awful.screen.focused().systray.visible
   end, { description = "Toggle systray visibility", group = "awesome" }),

   -- Show/Hide Systray
   awful.key({ modkey }, "KP_Subtract", function()
      awful.screen.focused().systray.visible = not awful.screen.focused().systray.visible
   end, { description = "Toggle systray visibility", group = "awesome" }),

   awful.key({ modkey, }, "space", function() awful.layout.inc(1) end,
      { description = "select next grid layout", group = "layout" }),

   -- Widgets popups
   awful.key({ modkey, }, "e", function() require("widgets.float_calendar").toggle() end,
      { description = "show calendar", group = "widgets" }),

   -- awful.key({ modkey, }, "p", function() if beautiful.fs then beautiful.fs.show(7) end end,
   --    { description = "show filesystem", group = "widgets" }),

   --awful.key({ modkey, }, "w", function () if beautiful.weather then beautiful.weather.show(7) end end,
   --{description = "show weather", group = "widgets"}),


   -- -----------------------
   -- | SUPER + SHIFT + ... |
   -- -----------------------

   awful.key({ modkey, "Shift" }, "r", awesome.restart,
      { description = "reload awesome", group = "awesome" }),

   awful.key({ modkey, "Shift" }, "x", awesome.quit,
      { description = "quit awesome", group = "awesome" }),
   --
   -- awful.key({ modkey, "Shift" }, "Return", function() awful.util.spawn(filemanager) end),

   awful.key({ modkey, "Shift" }, "u", function()
      local focused_screen = awful.screen.focused()
      focused_screen.user.toggle()
   end, { description = "open user wiabar", group = "wibars" }),

   awful.key({ modkey, "Shift" }, "s", function()
      local focused_screen = awful.screen.focused()
      focused_screen.stats.toggle()
   end, { description = "open statistics wibar", group = "wibars" }),

   awful.key({ modkey, "Shift" }, "d", function()
      local focused_screen = awful.screen.focused()
      focused_screen.docker.toggle()
   end, { description = "open docker wibar", group = "wibars" }),

   awful.key({ modkey, "Shift" }, "n", function()
      awesome.emit_signal('notifcenter::toggle')
   end, { description = "open notification wibar", group = "wibars" }),

   -- ----------------------
   -- | CTRL + SHIFT + ... |
   -- ----------------------

   -- awful.key({ "Control", "Shift" }, "Escape", function() awful.util.spawn("xfce4-taskmanager") end),

   -- --------------------
   -- | CTRL + SUPER + ... |
   -- --------------------

   awful.key({ "Control", modkey }, "n",
      function()
         local c = awful.client.restore()
         -- Focus restored client
         if c then
            client.focus = c
            c:raise()
         end
      end,
      { description = "restore minimized", group = "client" }),

   -- --------------------
   -- | CTRL + ALT + ... |
   -- --------------------

   awful.key({ "Control", altkey }, "w", function() awful.util.spawn("arcolinux-welcome-app") end,
      { description = "ArcoLinux Welcome App", group = "alt+ctrl" }),
   -- awful.key({ "Control", altkey }, "e", function() awful.util.spawn("archlinux-tweak-tool") end,
   --    { description = "ArcoLinux Tweak Tool", group = "alt+ctrl" }),
   awful.key({ "Control", altkey }, "Next", function() awful.util.spawn("conky-rotate -n") end,
      { description = "Next conky rotation", group = "alt+ctrl" }),
   awful.key({ "Control", altkey }, "Prior", function() awful.util.spawn("conky-rotate -p") end,
      { description = "Previous conky rotation", group = "alt+ctrl" }),
   awful.key({ "Control", altkey }, "a", function() awful.util.spawn("xfce4-appfinder") end,
      { description = "Xfce appfinder", group = "alt+ctrl" }),
   awful.key({ "Control", altkey }, "b", function() awful.util.spawn(filemanager) end,
      { description = filemanager, group = "alt+ctrl" }),
   awful.key({ "Control", altkey }, "c", function() awful.util.spawn("catfish") end,
      { description = "catfish", group = "alt+ctrl" }),
   awful.key({ "Control", altkey }, "f", function() awful.util.spawn(browser2) end,
      { description = browser2, group = "alt+ctrl" }),
   awful.key({ "Control", altkey }, "g", function() awful.util.spawn(browser3) end,
      { description = browser3, group = "alt+ctrl" }),
   awful.key({ "Control", altkey }, "i", function() awful.util.spawn("nitrogen") end,
      { description = nitrogen, group = "alt+ctrl" }),
   awful.key({ "Control", altkey }, "k", function() awful.util.spawn("archlinux-logout") end,
      { description = scrlocker, group = "alt+ctrl" }),
   awful.key({ "Control", altkey }, "l", function() awful.util.spawn("archlinux-logout") end,
      { description = scrlocker, group = "alt+ctrl" }),
   awful.key({ "Control", altkey }, "o",
      function() awful.spawn.with_shell("$HOME/.config/awesome/scripts/picom-toggle.sh") end,
      { description = "Picom toggle", group = "alt+ctrl" }),
   awful.key({ "Control", altkey }, "m", function() awful.util.spawn("xfce4-settings-manager") end,
      { description = "Xfce settings manager", group = "alt+ctrl" }),
   awful.key({ "Control", altkey }, "p", function() awful.util.spawn("pamac-manager") end,
      { description = "Pamac Manager", group = "alt+ctrl" }),

   -- On the fly useless gaps change
   awful.key({ "Control", altkey }, "j", function() utils.useless_gaps_resize(1) end,
      { description = "increment useless gaps", group = "tag" }),
   awful.key({ "Control", altkey }, "h", function() utils.useless_gaps_resize(-1) end,
      { description = "decrement useless gaps", group = "tag" }),

   -- -------------
   -- | ALT + ... |
   -- -------------
   -- awful.key({ altkey }, "t", function() awful.util.spawn("variety -t") end,
   --    { description = "Wallpaper trash", group = "altkey" }),
   -- awful.key({ altkey }, "n", function() awful.util.spawn("variety -n") end,
   --    { description = "Wallpaper next", group = "altkey" }),
   -- awful.key({ altkey }, "p", function() awful.util.spawn("variety -p") end,
   --    { description = "Wallpaper previous", group = "altkey" }),
   -- awful.key({ altkey }, "s", function() awful.util.spawn("variety --selector") end,
   --    { description = "Wallpaper previous", group = "altkey" }),
   -- awful.key({ altkey }, "f", function() awful.util.spawn("variety -f") end,
   --    { description = "Wallpaper favorite", group = "altkey" }),
   -- awful.key({ altkey }, "Left", function() awful.util.spawn("variety -p") end,
   --    { description = "Wallpaper previous", group = "altkey" }),
   -- awful.key({ altkey }, "Right", function() awful.util.spawn("variety -n") end,
   --    { description = "Wallpaper next", group = "altkey" }),
   -- awful.key({ altkey }, "Up", function() awful.util.spawn("variety --pause") end,
   --    { description = "Wallpaper pause", group = "altkey" }),
   -- awful.key({ altkey }, "Down", function() awful.util.spawn("variety --resume") end,
   --    { description = "Wallpaper resume", group = "altkey" }),
   awful.key({ altkey }, "r", function() awful.util.spawn("nitrogen --set-zoom-fill --save --random") end,
      { description = "Wallpaper random", group = "altkey" }),
   awful.key({ altkey }, "s", function() awful.util.spawn("nitrogen") end,
      { description = "Wallpaper selector", group = "altkey" }),

   -- ---------------
   -- | SCREENSHOTS |
   -- ---------------
   awful.key({}, "Print",
      function() awful.util.spawn("scrot 'ArcoLinux-%Y-%m-%d-%s_screenshot_$wx$h.jpg' -e 'mv $f $$(xdg-user-dir PICTURES)'") end
      , { description = "Scrot", group = "screenshots" }),
   awful.key({ "Control" }, "Print", function() awful.util.spawn("xfce4-screenshooter") end,
      { description = "Xfce screenshot", group = "screenshots" }),
   awful.key({ "Control", "Shift" }, "Print", function() awful.util.spawn("flameshot gui") end,
      { description = "Gnome screenshot", group = "screenshots" }),


   -- ----------------
   -- | TAG BROWSING |
   -- ----------------

   awful.key({ modkey, }, "Left", awful.tag.viewprev,
      { description = "view previous", group = "tag" }),
   awful.key({ modkey, }, "Right", awful.tag.viewnext,
      { description = "view next", group = "tag" }),
   -- awful.key({ altkey, }, "Escape", awful.tag.history.restore,
   --    { description = "go back", group = "tag" }),

   awful.key({ modkey, altkey, }, "l", awful.tag.viewnext,
      { description = "view next", group = "tag" }),
   awful.key({ modkey, altkey }, "h", awful.tag.viewprev,
      { description = "view previous", group = "tag" }),

   awful.key({ modkey, }, "Tab", awful.tag.viewnext,
      { description = "view next", group = "tag" }),
   awful.key({ modkey, "Shift" }, "Tab", awful.tag.viewprev,
      { description = "view previous", group = "tag" }),

   -- ---------------------------
   -- | CLIENT FOCUS NAVIGATION |
   -- ---------------------------

   awful.key({ modkey, altkey, }, "j",
      function()
         awful.client.focus.byidx(1)
      end,
      { description = "focus next by index", group = "client" }
   ),
   awful.key({ modkey, altkey, }, "k",
      function()
         awful.client.focus.byidx(-1)
      end,
      { description = "focus previous by index", group = "client" }
   ),

   -- By direction client focus
   awful.key({ modkey }, "j",
      function()
         awful.client.focus.global_bydirection("down")
         if client.focus then client.focus:raise() end
      end,
      { description = "focus down", group = "client" }),
   awful.key({ modkey }, "k",
      function()
         awful.client.focus.global_bydirection("up")
         if client.focus then client.focus:raise() end
      end,
      { description = "focus up", group = "client" }),
   awful.key({ modkey }, "h",
      function()
         awful.client.focus.global_bydirection("left")
         if client.focus then client.focus:raise() end
      end,
      { description = "focus left", group = "client" }),
   awful.key({ modkey }, "l",
      function()
         awful.client.focus.global_bydirection("right")
         if client.focus then client.focus:raise() end
      end,
      { description = "focus right", group = "client" }),


   -- By direction client focus with arrows
   awful.key({ "Control", modkey }, "Down",
      function()
         awful.client.focus.global_bydirection("down")
         if client.focus then client.focus:raise() end
      end,
      { description = "focus down", group = "client" }),
   awful.key({ "Control", modkey }, "Up",
      function()
         awful.client.focus.global_bydirection("up")
         if client.focus then client.focus:raise() end
      end,
      { description = "focus up", group = "client" }),
   awful.key({ "Control", modkey }, "Left",
      function()
         awful.client.focus.global_bydirection("left")
         if client.focus then client.focus:raise() end
      end,
      { description = "focus left", group = "client" }),
   awful.key({ "Control", modkey }, "Right",
      function()
         awful.client.focus.global_bydirection("right")
         if client.focus then client.focus:raise() end
      end,
      { description = "focus right", group = "client" }),


   -- -----------------------
   -- | LAYOUT MANIPULATION |
   -- -----------------------

   awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end,
      { description = "swap with next client by index", group = "client" }),
   awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end,
      { description = "swap with previous client by index", group = "client" }),
   awful.key({ altkey, }, "Tab",
      function()
         awful.client.focus.history.previous()
         if client.focus then
            client.focus:raise()
         end
      end,
      { description = "go back, back to the past", group = "client" }),

   -- -----------------
   -- | RESIZE CLIENT |
   -- -----------------

   awful.key({ "Control", "Shift" }, "h", function() awful.tag.incmwfact(-0.05) end,
      { description = "decrease master width factor", group = "layout" }),
   awful.key({ "Control", "Shift" }, "l", function() awful.tag.incmwfact(0.05) end,
      { description = "increase master width factor", group = "layout" }),
   awful.key({ modkey, "Shift" }, "h", function() awful.tag.incnmaster(1, nil, true) end,
      { description = "increase the number of master clients", group = "layout" }),
   awful.key({ modkey, "Shift" }, "l", function() awful.tag.incnmaster(-1, nil, true) end,
      { description = "decrease the number of master clients", group = "layout" }),
   awful.key({ "Control", modkey }, "h", function() awful.tag.incncol(1, nil, true) end,
      { description = "increase the number of columns", group = "layout" }),
   awful.key({ "Control", modkey }, "l", function() awful.tag.incncol(-1, nil, true) end,
      { description = "decrease the number of columns", group = "layout" }),

   -- Brightness
   awful.key({}, "XF86MonBrightnessUp", function() os.execute("xbacklight -inc 10") end,
      { description = "+10%", group = "hotkeys" }),
   awful.key({}, "XF86MonBrightnessDown", function() os.execute("xbacklight -dec 10") end,
      { description = "-10%", group = "hotkeys" }),

   -- ALSA volume control
   --awful.key({ "Control" }, "Up",
   awful.key({}, "XF86AudioRaiseVolume", function() awful.util.spawn("amixer -D pulse sset Master 2%+", false) end),
   awful.key({}, "XF86AudioLowerVolume", function() awful.util.spawn("amixer -D pulse sset Master 2%-", false) end),
   awful.key({}, "XF86AudioMute", function() awful.util.spawn("amixer -D pulse sset Master toggle", false) end),

   --Media keys supported by vlc, spotify, audacious, xmm2, ...
   --awful.key({}, "XF86AudioPlay", function() awful.util.spawn("playerctl play-pause", false) end),
   --awful.key({}, "XF86AudioNext", function() awful.util.spawn("playerctl next", false) end),
   --awful.key({}, "XF86AudioPrev", function() awful.util.spawn("playerctl previous", false) end),
   --awful.key({}, "XF86AudioStop", function() awful.util.spawn("playerctl stop", false) end),

   --Media keys supported by dbus.
   awful.key({}, "XF86AudioPlay", function() awful.util.spawn(spotify.commands.toggle, false) end),
   awful.key({}, "XF86AudioNext", function() awful.util.spawn(spotify.commands.next, false) end),
   awful.key({}, "XF86AudioPrev", function() awful.util.spawn(spotify.commands.prev, false) end),
   awful.key({}, "XF86AudioStop", function() awful.util.spawn(spotify.commands.stop, false) end),

   -- MPD control
   awful.key({ "Control", "Shift" }, "Up",
      function()
         os.execute("mpc toggle")
         beautiful.mpd.update()
      end,
      { description = "mpc toggle", group = "widgets" }),

   awful.key({ "Control", "Shift" }, "Down",
      function()
         os.execute("mpc stop")
         beautiful.mpd.update()
      end,
      { description = "mpc stop", group = "widgets" }),

   awful.key({ "Control", "Shift" }, "Left",
      function()
         os.execute("mpc prev")
         beautiful.mpd.update()
      end,
      { description = "mpc prev", group = "widgets" }),

   awful.key({ "Control", "Shift" }, "Right",
      function()
         os.execute("mpc next")
         beautiful.mpd.update()
      end,
      { description = "mpc next", group = "widgets" }),

   -- Copy primary to clipboard (terminals to gtk)
   --awful.key({ modkey }, "c", function () awful.spawn.with_shell("xsel | xsel -i -b") end,
   -- {description = "copy terminal to gtk", group = "hotkeys"}),
   --Copy clipboard to primary (gtk to terminals)
   --awful.key({ modkey }, "v", function () awful.spawn.with_shell("xsel -b | xsel") end,
   --{description = "copy gtk to terminal", group = "hotkeys"}),


   -- Default
   --[[ Menubar

    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "super"})
    --]]

   awful.key({ altkey }, "x",
      function()
         awful.prompt.run {
            prompt       = "Run Lua code: ",
            textbox      = awful.screen.focused().mypromptbox.widget,
            exe_callback = awful.util.eval,
            history_path = awful.util.get_cache_dir() .. "/history_eval"
         }
      end,
      { description = "lua execute prompt", group = "awesome" })
--]]
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 0, 9 do
   -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
   local descr_view, descr_toggle, descr_move, descr_toggle_focus
   if i == 1 or i == 9 then
      descr_view = { description = "view tag #", group = "tag" }
      descr_toggle = { description = "toggle tag #", group = "tag" }
      descr_move = { description = "move focused client to tag #", group = "tag" }
      descr_toggle_focus = { description = "toggle focused client on tag #", group = "tag" }
   end

   local binding = "#" .. i + 9
   local tagIndex = i;

   if i == 0 then
      binding = '0'
      tagIndex = 1
   end

   globalkeys = my_table.join(globalkeys,
      -- View tag only.
      awful.key({ modkey }, binding,
         function()
            local screen = awful.screen.focused()
            local tag = screen.tags[tagIndex]
            if tag then
               tag:view_only()
            end
         end,
         descr_view),
      -- Toggle tag display.
      awful.key({ "Control", modkey }, binding,
         function()
            local screen = awful.screen.focused()
            local tag = screen.tags[tagIndex]
            if tag then
               awful.tag.viewtoggle(tag)
            end
         end,
         descr_toggle),
      -- Move client to tag.
      awful.key({ modkey, "Shift" }, binding,
         function()
            if client.focus then
               local tag = client.focus.screen.tags[tagIndex]
               if tag then
                  client.focus:move_to_tag(tag)
                  tag:view_only()
               end
            end
         end,
         descr_move),
      -- Toggle tag on focused client.
      awful.key({ "Control", modkey, "Shift" }, binding,
         function()
            if client.focus then
               local tag = client.focus.screen.tags[tagIndex]
               if tag then
                  client.focus:toggle_tag(tag)
               end
            end
         end,
         descr_toggle_focus)
   )
end

-- Set keys
root.keys(globalkeys)
-- }}}

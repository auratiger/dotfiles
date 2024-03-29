local awful = require("awful") --Everything related to window managment
local beautiful = require("beautiful") -- Theme handling library

-- NOTE: find class or role via ===== xprop ===== command
--
-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
   -- All clients will match this rule.
   { rule = {},
      properties = { border_width = beautiful.border_width,
         border_color = beautiful.border_normal,
         focus = awful.client.focus.filter,
         raise = true,
         keys = clientkeys, -- NOTE: imported from bindings/client
         buttons = clientbuttons, -- NOTE: imporeted from bindings/buttons
         screen = awful.screen.preferred,
         placement = awful.placement.no_overlap + awful.placement.no_offscreen,
         size_hints_honor = false
      }
   },

   -- Titlebars
   { rule_any = { type = { "dialog", "normal" } },
      properties = { titlebars_enabled = false } },

   -- Set applications to be maximized at startup.
   -- NOTE: find class or role via xprop command

   { rule = { class = editorgui },
      properties = { maximized = true } },

   { rule = { class = "Geany" },
      properties = { maximized = false, floating = false } },

   { rule = { class = "Gimp*", role = "gimp-image-window" },
      properties = { maximized = true } },

   { rule = { class = "Gnome-disks" },
      properties = { maximized = true } },

   { rule = { class = "inkscape" },
      properties = { maximized = true } },

   { rule = { class = "VirtualBox Manager" },
      properties = { maximized = true } },

   { rule = { class = "VirtualBox Machine" },
      properties = { maximized = true } },

   { rule = { instance = bitwarden },
      properties = { screen = 2, floating = true, ontop = true } },

   { rule = { instance = browser1 },
      properties = { maximized = true } },

   { rule = { instance = mediaplayer },
      properties = { screen = 1, tag = cfg.screens[1].tags[3], switchtotag = true, maximized = true } },

   { rule = { instance = videorecorder },
      properties = { screen = 2, switchtotag = true, floating = true, ontop = true } },

   { rule = { instance = discord },
      properties = { screen = 2, tag = cfg.screens[2].tags[1], switchtotag = true, maximized = true } },

   { rule = { instance = musicplayer },
      properties = { screen = 2, tag = cfg.screens[2].tags[2], switchtotag = true, maximized = true } },

   { rule = { name = "Picture in picture" }, -- vivaldi floating video player
      properties = { screen = 2, tag = cfg.screens[2].tags[3], switchtotag = true } },

   { rule = { instance = postman },
      properties = { screen = 1, tag = cfg.screens[1].tags[2], switchtotag = true } },

   { rule = { instance = mongocompass },
      properties = { screen = 1, tag = cfg.screens[1].tags[3], switchtotag = true } },

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

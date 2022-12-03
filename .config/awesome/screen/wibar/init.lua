local awful     = require("awful")
local beautiful = require("beautiful")
local wibox     = require("wibox")
local dpi       = beautiful.xresources.apply_dpi

local shape_utils = require("common.shape")

local wbm       = require("widgets.wibar_monitor")
local wb_player = require("widgets.player.wibar")

local tags          = require("screen.tags")
local tasks         = require("screen.tasks")
local notifi        = require("screen.notif_icon")
local panels_switch = require("screen.panels_switch")

local lain = require("lain")

return {
   create = function(s)

      local notif_icon = notifi.create(s)

      -- -- -- CPU
      local wbm_cpu = wbm.create("CPU: ")
      awesome.connect_signal("sysstat::cpu", function(val, postfix)
         wbm_cpu.wbm_body.wbm_labels.wbm_valtext.text = val .. postfix
         wbm_cpu.wbm_body.wbm_graphs_margin.wbm_graphs.wbm_graph:add_value(val, 1)
      end)

      local cpu_section = {
         widget = wibox.container.background,
         bg = beautiful.palette_c3,
         shape = shape_utils.default_frr,
         wbm_cpu
      }

      -- -- -- RAM
      local wbm_ram = wbm.create("RAM: ")
      awesome.connect_signal("sysstat::ram", function(val, postfix)
         wbm_ram.wbm_body.wbm_labels.wbm_valtext.text = val .. postfix
         wbm_ram.wbm_body.wbm_labels.wbm_valtext.text = val .. postfix
         wbm_ram.wbm_body.wbm_graphs_margin.wbm_graphs.wbm_graph:add_value(val, 1)
      end)

      local ram_section = {
         widget = wibox.container.background,
         bg = beautiful.palette_c3,
         shape = shape_utils.default_frr,
         wbm_ram
      }


      -- -- -- Calendar
      local markup = lain.util.markup

      -- Textclock
      os.setlocale(os.getenv("LANG")) -- to localize the clock
      local clockicon = wibox.widget.imagebox(beautiful.widget_clock)
      local mytextclock = wibox.widget.textclock(markup("#7788af", "%A %d %B ") ..
         markup("#535f7a", ">") .. markup("#de5e1e", " %H:%M "))
      mytextclock.font = beautiful.font

      local calendar_widget = require("widgets.float_calendar")
      local cw = calendar_widget({
         theme = 'outrun',
         placement = 'top',
         start_sunday = false,
         radius = 8,
         previous_month_button = 1,
         next_month_button = 3,
      })

      mytextclock:connect_signal("button::press",
         function(_, _, _, button)
            if button == 1 then cw.toggle() end
         end)


      -- --
      awful.tag(cfg.screens[s.index].tags, s, awful.layout.layouts[1])

      s.mylayoutbox = awful.widget.layoutbox(s)
      s.mylayoutbox:buttons(my_table.join(
         awful.button({}, 1, function() awful.layout.inc(1) end),
         awful.button({}, 3, function() awful.layout.inc(-1) end),
         awful.button({}, 4, function() awful.layout.inc(1) end),
         awful.button({}, 5, function() awful.layout.inc(-1) end)))

      s.mytaglist = tags.create(s)
      s.focused_task = tasks.create(s)

      s.systray = wibox.widget.systray()
      s.systray.visible = true

      -- -- -- WIBAR
      local wibar = awful.wibar({

         position = "top",
         screen   = s,
         bg       = beautiful.col_transparent,
         height   = dpi(40)
      })

      wibar:setup {
         widget = wibox.container.margin,
         top    = dpi(2),
         bottom = dpi(2),
         left   = dpi(8),
         right  = dpi(8),
         {
            layout = wibox.layout.align.horizontal,
            { -- Left widgets
               layout = wibox.layout.fixed.horizontal,
               {
                  widget = wibox.container.background,
                  bg     = beautiful.palette_c3,
                  shape  = shape_utils.default_frr,
                  {
                     layout = wibox.layout.fixed.horizontal,
                     s.mytaglist,
                  },
               },
               {
                  widget = wibox.container.margin,
                  left   = dpi(20),
                  {
                     widget = wibox.container.background,
                     bg     = beautiful.palette_c3,
                     shape  = shape_utils.default_frr,
                     {
                        widget = wibox.container.margin,
                        panels_switch.create(s)
                     }
                  }
               },
               {
                  widget = wibox.container.margin,
                  left = dpi(20),
                  {
                     {
                        layout = wibox.layout.fixed.horizontal,
                        s.focused_task,
                     },
                     widget = wibox.container.background,
                     bg     = beautiful.palette_c3,
                     shape  = shape_utils.default_frr,
                  }
               }
            },
            nil,
            { -- Right widgets
               layout = wibox.layout.fixed.horizontal,
               {
                  widget = wibox.container.margin,
                  right = dpi(10),
                  {
                     widget = wibox.container.background,
                     bg = beautiful.palette_c3,
                     shape = shape_utils.default_frr,
                     wb_player
                  }
               },
               {
                  widget = wibox.container.margin,
                  right = dpi(10),
                  cpu_section
               },
               {
                  widget = wibox.container.margin,
                  right = dpi(10),
                  ram_section
               },
               {
                  widget = wibox.container.background,
                  bg     = beautiful.palette_c3,
                  shape  = shape_utils.default_frr,
                  {
                     layout = wibox.layout.fixed.horizontal,
                     clockicon,
                     mytextclock,
                     {
                        notif_icon,
                        margins = 10,
                        widget  = wibox.container.margin
                     },
                     awful.widget.keyboardlayout(),
                     wibox.widget.systray(),
                     s.mylayoutbox,
                  }
               }
            }
         }
      }

      return wibar

   end
}
--
--
-- =========================================================================================
-- =========================================================================================
-- =========================================================================================
-- =========================================================================================
-- =========================================================================================

-- -- / fs
-- --[[ commented because it needs Gio/Glib >= 2.54
-- local fsicon = wibox.widget.imagebox(theme.widget_fs)
-- theme.fs = lain.widget.fs({
--     notification_preset = { font = "Noto Sans Mono Medium 10", fg = theme.fg_normal },
--     settings  = function()
--         widget:set_markup(markup.fontfg(theme.font, "#80d9d8", string.format("%.1f", fs_now["/"].used) .. "% "))
--     end
-- })
-- --]]

-- -- Mail IMAP check
-- --[[ commented because it needs to be set before use
-- local mailicon = wibox.widget.imagebox()
-- theme.mail = lain.widget.imap({
--     timeout  = 180,
--     server   = "server",
--     mail     = "mail",
--     password = "keyring get mail",
--     settings = function()
--         if mailcount > 0 then
--             mailicon:set_image(theme.widget_mail)
--             widget:set_markup(markup.fontfg(theme.font, "#cccccc", mailcount .. " "))
--         else
--             widget:set_text("")
--             --mailicon:set_image() -- not working in 4.0
--             mailicon._private.image = nil
--             mailicon:emit_signal("widget::redraw_needed")
--             mailicon:emit_signal("widget::layout_changed")
--         end
--     end
-- })
-- --]]

-- -- -- CPU
-- -- local cpuicon = wibox.widget.imagebox(beautiful.widget_cpu)
-- -- local cpu = lain.widget.cpu({
-- --    settings = function()
-- --       widget:set_markup(markup.fontfg(beautiful.font, "#e33a6e", cpu_now.usage .. "% "))
-- --    end
-- -- })

-- -- ALSA volume
-- local volicon = wibox.widget.imagebox(beautiful.widget_vol)
-- local volume = lain.widget.alsa({
--    settings = function()
--       if volume_now.status == "off" then
--          volume_now.level = volume_now.level .. "M"
--       end

--       widget:set_markup(markup.fontfg(beautiful.font, "#7493d2", volume_now.level .. "% "))
--    end
-- })

-- -- -- MEM
-- -- local memicon = wibox.widget.imagebox(beautiful.widget_mem)
-- -- local memory = lain.widget.mem({
-- --    settings = function()
-- --       widget:set_markup(markup.fontfg(beautiful.font, "#e0da37", mem_now.used .. "M "))
-- --    end
-- -- })

-- -- MPD
-- -- local musicplr = "urxvt -title Music -g 130x34-320+16 -e ncmpcpp"
-- -- local mpdicon = wibox.widget.imagebox(beautiful.widget_music)
-- -- mpdicon:buttons(my_table.join(
-- --    awful.button({ modkey }, 1, function() awful.spawn.with_shell(musicplr) end),
-- --    --[[awful.button({ }, 1, function ()
-- --         awful.spawn.with_shell("mpc prev")
-- --         theme.mpd.update()
-- --     end),
-- --     --]]
-- --    awful.button({}, 2, function()
-- --       awful.spawn.with_shell("mpc toggle")
-- --       mpd.update()
-- --    end),
-- --    awful.button({ modkey }, 3, function() awful.spawn.with_shell("pkill ncmpcpp") end),
-- --    awful.button({}, 3, function()
-- --       awful.spawn.with_shell("mpc stop")
-- --       mpd.update()
-- --    end)))
-- -- mpd = lain.widget.mpd({
-- --    settings = function()
-- --       if mpd_now.state == "play" then
-- --          artist = " " .. mpd_now.artist .. " "
-- --          title  = mpd_now.title .. " "
-- --          mpdicon:set_image(beautiful.widget_music_on)
-- --          widget:set_markup(markup.font(beautiful.font, markup("#FFFFFF", artist) .. " " .. title))
-- --       elseif mpd_now.state == "pause" then
-- --          widget:set_markup(markup.font(beautiful.font, " mpd paused "))
-- --          mpdicon:set_image(beautiful.widget_music_pause)
-- --       else
-- --          widget:set_text("")
-- --          mpdicon:set_image(beautiful.widget_music)
-- --       end
-- --    end
-- -- })


-- return {
--    create = function(s)

--       -- Quake application
--       -- s.quake = lain.util.quake({ app = awful.util.terminal })
--       s.quake = lain.util.quake({ app = "urxvt", height = 0.50, argname = "--name %s" })

--       -- If wallpaper is a function, call it with the screen
--       local wallpaper = beautiful.wallpaper
--       if type(wallpaper) == "function" then
--          wallpaper = wallpaper(s)
--       end
--       gears.wallpaper.maximized(wallpaper, s, true)

--       -- Create a promptbox for each screen
--       s.mypromptbox = awful.widget.prompt()

--       -- Create an imagebox widget which will contains an icon indicating which layout we're using.
--       -- We need one layoutbox per screen.
--       s.mylayoutbox = awful.widget.layoutbox(s)
--       s.mylayoutbox:buttons(my_table.join(
--          awful.button({}, 1, function() awful.layout.inc(1) end),
--          awful.button({}, 3, function() awful.layout.inc(-1) end),
--          awful.button({}, 4, function() awful.layout.inc(1) end),
--          awful.button({}, 5, function() awful.layout.inc(-1) end)))

--       -- Create a taglist widget
--       s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

--       -- Create a tasklist widget
--       s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

--       -- Create the wibox
--       s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(20), bg = beautiful.bg_normal,
--          fg = beautiful.fg_normal })

--       -- Add widgets to the wibox
--       s.mywibox:setup {
--          layout = wibox.layout.align.horizontal,
--          { -- Left widgets
--             layout = wibox.layout.fixed.horizontal,
--             --s.mylayoutbox,
--             s.mytaglist,
--             s.mypromptbox,
--          },
--          --s.mytasklist, -- Middle widget
--          nil,
--          { -- Right widgets
--             layout = wibox.layout.fixed.horizontal,
--             volicon,
--             volume.widget,
--             clockicon,
--             mytextclock,
--             wibox.widget.systray(),
--          },
--       }

--       -- Create the bottom wibox
--       s.mybottomwibox = awful.wibar({ position = "bottom", screen = s, border_width = 0, height = dpi(20),
--          bg = beautiful.bg_normal, fg = beautiful.fg_normal })

--       -- Add widgets to the bottom wibox
--       s.mybottomwibox:setup {
--          layout = wibox.layout.align.horizontal,
--          { -- Left widgets
--             layout = wibox.layout.fixed.horizontal,
--          },
--          s.mytasklist, -- Middle widget
--          { -- Right widgets
--             layout = wibox.layout.fixed.horizontal,
--             s.mylayoutbox,
--          },
--       }


--       return s.mywibox
--    end
-- }

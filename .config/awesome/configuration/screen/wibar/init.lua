local awful     = require("awful")
local beautiful = require("beautiful")
local wibox     = require("wibox")
local dpi       = beautiful.xresources.apply_dpi

local wbm = require("widgets.wibar_monitor")

local tags          = require("configuration.screen.tags")
local tasks         = require("configuration.screen.tasks")
local panels_switch = require("configuration.screen.panels_switch")

return {
   create = function(s)

      local cpu_section, ram_section, wb_player

      if s.index == 1 then -- loads these widges only for the primary screen

         -- -- -- CPU
         local wbm_cpu = wbm.create("CPU: ")
         awesome.connect_signal("sysstat::cpu", function(val, postfix)
            wbm_cpu.wbm_body.wbm_labels.wbm_valtext.text = val .. postfix
            wbm_cpu.wbm_body.wbm_graphs_margin.wbm_graphs.wbm_graph:add_value(val, 1)
         end)

         cpu_section = {
            widget = wibox.container.background,
            bg = beautiful.palette_c3,
            shape = shape_utils.default_frr_lg,
            wbm_cpu
         }

         -- -- -- RAM
         local wbm_ram = wbm.create("RAM: ")
         awesome.connect_signal("sysstat::ram", function(val, postfix)
            wbm_ram.wbm_body.wbm_labels.wbm_valtext.text = val .. postfix
            wbm_ram.wbm_body.wbm_labels.wbm_valtext.text = val .. postfix
            wbm_ram.wbm_body.wbm_graphs_margin.wbm_graphs.wbm_graph:add_value(val, 1)
         end)

         ram_section = {
            widget = wibox.container.background,
            bg = beautiful.palette_c3,
            shape = shape_utils.default_frr_lg,
            wbm_ram
         }

         -- -- -- Music widget
         wb_player = require("widgets.player.wibar")

      end

      -- -- -- Calendar
      local markup = require("common.utils.markup")

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
                  shape  = shape_utils.default_frr_lg,
                  {
                     widget = wibox.container.margin,
                     margins = dpi(4),
                     {
                        layout = wibox.layout.fixed.horizontal,
                        s.mytaglist,
                     }
                  },
               },
               {
                  widget = wibox.container.margin,
                  left   = dpi(20),
                  {
                     widget = wibox.container.background,
                     bg     = beautiful.palette_c3,
                     shape  = shape_utils.default_frr_lg,
                     {
                        widget = wibox.container.margin,
                        margins = dpi(4),
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
                     shape  = shape_utils.default_frr_lg,
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
                     shape = shape_utils.default_frr_lg,
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
                  shape  = shape_utils.default_frr_lg,
                  {
                     widget = wibox.container.margin,
                     left = dpi(10),
                     right = dpi(10),
                     {
                        layout = wibox.layout.fixed.horizontal,
                        clockicon,
                        mytextclock,
                        wibox.widget.systray(),
                        {
                           s.notifcenter.icon,
                           margins = 10,
                           widget  = wibox.container.margin
                        },
                        awful.widget.keyboardlayout(),
                        -- s.mylayoutbox,
                     }
                  }
               }
            }
         }
      }

      return wibar

   end
}

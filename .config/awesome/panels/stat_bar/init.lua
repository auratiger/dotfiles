local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful").xresources.apply_dpi

local sysstat_signal = require("signals.sysstat_signal")

local arcchart_stat = require("widgets.arcchart_stat")

local module = {
   name = "stats",
   watchdogs = sysstat_signal,
   create = function(s)

      local stat = awful.wibar({
         position = "left",
         screen   = s,
         shape    = shape_utils.default_frr,
         visible  = false,
         width    = dpi(380),
         height   = dpi(1020),
         margins  = {
            left = dpi(15)
         }
      })

      local temp = arcchart_stat.create(require("panels.stat_bar.temp_text"))
      local ram = arcchart_stat.create(require("panels.stat_bar.ram_text"))
      local cpu = arcchart_stat.create(require("panels.stat_bar.cpu_text"))

      local d_root = arcchart_stat.create(require("panels.stat_bar.d_root"))
      local d_home = arcchart_stat.create(require("panels.stat_bar.d_home"))
      local d_boot = arcchart_stat.create(require("panels.stat_bar.d_efi"))


      awesome.connect_signal("sysstat::temp",
         function(val)
            temp.mirr.bar.value = val
         end)

      awesome.connect_signal("sysstat::ram",
         function(val)
            ram.mirr.bar.value = val
         end)

      awesome.connect_signal("sysstat::cpu",
         function(val)
            cpu.mirr.bar.value = val
         end)

      awesome.connect_signal("sysstat:disk_root",
         function(val)
            d_root.mirr.bar.value = val
         end)

      awesome.connect_signal("sysstat:disk_boot",
         function(val)
            d_boot.mirr.bar.value = val
         end)

      awesome.connect_signal("sysstat:disk_home",
         function(val)
            d_home.mirr.bar.value = val
         end)

      stat:setup {
         {
            require("widgets.processes").create(),
            widget = wibox.container.margin,
            top = dpi(5),
            right = dpi(10),
            left = dpi(10),
         },
         {
            temp,
            {
               layout = wibox.layout.flex.horizontal,
               ram,
               cpu,

            },
            layout = wibox.layout.flex.vertical,
         }
         ,
         {
            layout = wibox.layout.flex.vertical,
            {
               layout = wibox.layout.flex.horizontal,
               d_boot,
               d_root
               ,

            },
            {
               widget = wibox.container.place,
               valign = 'top',
               {
                  layout = wibox.layout.align.horizontal,
                  {
                     widget = wibox.container.background,
                     forced_width = dpi(70)
                  },
                  d_home,
                  {
                     widget = wibox.container.background,
                     forced_width = dpi(70)
                  },

               }
            },
         },
         layout = wibox.layout.flex.vertical
      }

      return stat

   end
}

return {
   name = module.name,
   watchdogs = module.watchdogs,
   create = function(s)
      return createWidget(module, s)
   end
}

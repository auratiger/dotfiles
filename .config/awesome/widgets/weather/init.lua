-- Widget for whether indication

local wibox     = require("wibox")
local beautiful = require("beautiful")
local dpi       = beautiful.xresources.apply_dpi

local icons = require("common.icons")
local weather_signal = require("signals.weather_signal")

local weather_icons_map = {
   [1000] = '',
   [1003] = '',
   [1006] = '',
   [1009] = '',
   [1030] = '',
   [1063] = '',
   [1066] = '',
   [1069] = '',
   [1072] = '',
   [1087] = '',
   [1114] = '',
   [1117] = '',
   [1135] = '',
   [1147] = '',
   [1150] = '',
   [1153] = '',
   [1168] = '',
   [1171] = '',
   [1180] = '',
   [1183] = '',
   [1186] = '',
   [1189] = '',
   [1192] = '',
   [1195] = '',
   [1198] = '',
   [1201] = '',
}

local module = {
   name = "weather",
   watchdogs = weather_signal,
   create = function()
      local icon = icons.wbic('', '30', beautiful.palette_c1)
      local temp_txt = wibox.widget({
         widget = wibox.widget.textbox,
         text = '0',
         font = beautiful.font_famaly .. '26'
      })

      local base_widget = wibox.widget({
         {
            icon,
            widget = wibox.container.margin,
            right = dpi(10)
         },
         temp_txt,
         layout = wibox.layout.fixed.horizontal
      })

      awesome.connect_signal("data:weather", function(status, t)
         local weather_icon = ''
         local weather_text = 'No Data'

         if status ~= nil then
            weather_text = t .. '°'
            weather_icon = weather_icons_map[tonumber(status)]
         end

         icon.markup = "<span foreground='" .. beautiful.palette_c1 .. "'>" .. weather_icon .. "</span>"
         temp_txt.text = weather_text
      end)

      return base_widget

   end
}

return {
   name = module.name,
   watchdogs = module.watchdogs,
   create = function(s)
      return createWidget(module, s)
   end
}

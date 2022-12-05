local awful = require("awful")
local gears = require("gears")
local icons = require("common.icons")

local button = function(symb, size, command)
   local icon = icons.wbi(symb, size)
   icon:buttons(gears.table.join(awful.button({}, 1, command)))
   return icon
end

local create_btn_callback = function(on_play_cmd, on_pause_cmd)
   return function()
      local command = ""

      if not player_works and on_pause_cmd ~= nil then
         command = on_pause_cmd
      else
         command = on_play_cmd
      end

      awful.spawn.with_shell(command)
   end
end

return {

   create = function(symb, size, cmd, pause_cmd)
      return button(symb, size, create_btn_callback(cmd, pause_cmd))
   end
}

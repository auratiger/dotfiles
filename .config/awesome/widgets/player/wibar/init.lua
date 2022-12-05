local beautiful = require("beautiful")
local dpi       = beautiful.xresources.apply_dpi
local wibox     = require("wibox")

local spotify  = require("common.spotify")
local controls = require("widgets.player.controls")

require("signals.playerctl_signal")

player_works = true

local make_ctr_margin = function(content)
   return {
      content,
      widget = wibox.container.margin,
      left   = dpi(5),
      right  = dpi(5),
      bottom = dpi(1),
      top    = dpi(1),
   }
end


local text_player = wibox.widget {
   text    = "Nothing is played",
   align   = "center",
   opacity = 1,
   font    = beautiful.font .. " ExtraBold 10",
   widget  = wibox.widget.textbox,
}

local prv_btn = controls.create("", 10, spotify.commands.cmdprev)
local tgl_btn = controls.create("", 10, spotify.commands.cmdtoggle)
local nxt_btn = controls.create("", 10, spotify.commands.cmdnext)


-- -- NOTE: Alternative style
--
-- local wibox_player = wibox.widget {
--    widget       = wibox.container.background,
--    forced_width = dpi(300),
--    visible      = true,
--    {
--       layout = wibox.layout.fixed.vertical,
--       {
--          {
--             layout        = wibox.container.scroll.horizontal,
--             max_size      = 200,
--             speed         = 100,
--             step_function = wibox.container.scroll.step_functions.nonlinear_back_and_forth,
--             text_player,
--          },
--          layout = wibox.container.place,
--          halign = 'center',
--       },
--       {
--          make_ctr_margin(prv_btn),
--          make_ctr_margin(tgl_btn),
--          make_ctr_margin(nxt_btn),
--          layout = wibox.layout.flex.horizontal,
--       }
--    }
-- }

local wibox_player = wibox.widget {
   widget       = wibox.container.background,
   forced_width = dpi(320),
   visible      = true,
   {
      layout = wibox.layout.fixed.horizontal,
      fill_space = true,
      {
         widget = wibox.container.margin,
         left   = dpi(10),
         {
            layout        = wibox.container.scroll.horizontal,
            step_function = wibox.container.scroll.step_functions.nonlinear_back_and_forth,
            forced_width  = dpi(200),
            speed         = 100,
            text_player,
         }
      },
      {
         make_ctr_margin(prv_btn),
         make_ctr_margin(tgl_btn),
         make_ctr_margin(nxt_btn),
         layout = wibox.layout.flex.horizontal,
      }
   }
}

awesome.connect_signal("player::metadata",
   function(status, title, album, artist, art_link)

      if status == nil then
         player_works = false
      elseif status:match("Paused") then
         tgl_btn.text = ""
      elseif status:match("Playing") then
         tgl_btn.text = ""
      end

      if player_works then
         text_player.text = title .. " - " .. artist
         wibox_player.visible = true
      else
         text_player.text = "Nothing is played"
         wibox_player.visible = false
      end
   end)

return wibox_player

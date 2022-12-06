local awful = require("awful")
local wibox = require("wibox")

-- awful.util.tasklist_buttons = my_table.join(
--    awful.button({}, 1, function(c)
--       if c == client.focus then
--          c.minimized = true
--       else
--          --c:emit_signal("request::activate", "tasklist", {raise = true})<Paste>

--          -- Without this, the following
--          -- :isvisible() makes no sense
--          c.minimized = false
--          if not c:isvisible() and c.first_tag then
--             c.first_tag:view_only()
--          end
--          -- This will also un-minimize
--          -- the client, if needed
--          client.focus = c
--          c:raise()
--       end
--    end),
--    awful.button({}, 3, function()
--       local instance = nil

--       return function()
--          if instance and instance.wibox.visible then
--             instance:hide()
--             instance = nil
--          else
--             instance = awful.menu.clients({ theme = { width = dpi(250) } })
--          end
--       end
--    end),
--    awful.button({}, 4, function() awful.client.focus.byidx(1) end),
--    awful.button({}, 5, function() awful.client.focus.byidx(-1) end)
-- )

local tasklist_buttons = my_table.join(
   awful.button({}, 1, function(c)
      if c == client.focus then
         c.minimized = true
      else
         c:emit_signal(
            "request::activate",
            "tasklist",
            { raise = true }
         )
      end
   end),

   awful.button({}, 3, function() awful.menu.client_list({ theme = { width = 250 } }) end),
   awful.button({}, 4, function() awful.client.focus.byidx(1) end),
   awful.button({}, 5, function() awful.client.focus.byidx(-1) end))

return {
   create = function(s)
      local name_section = {
         left   = 10,
         right  = 10,
         widget = wibox.container.margin,
         {
            layout        = wibox.container.scroll.horizontal,
            max_size      = 400,
            speed         = 300,
            step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
            {
               id     = 'text_role',
               widget = wibox.widget.textbox,
               align  = 'center',
               valign = 'center',
            }
         }
      }


      local widget_template = {
         name_section,
         shape  = shape_utils.default_frr_lg,
         widget = wibox.container.background,
      }

      return awful.widget.tasklist {
         screen          = s,
         filter          = awful.widget.tasklist.filter.focused,
         buttons         = tasklist_buttons,
         widget_template = widget_template
      }
   end
}

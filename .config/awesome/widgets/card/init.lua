local wibox     = require("wibox")
local beautiful = require("beautiful")

return {
   create = function(content, margin)
      return wibox.widget(widget_utils.make_margin({
         widget_utils.make_margin(content, margin),
         shape  = shape_utils.default_frr_lg,
         widget = wibox.container.background,
         bg     = beautiful.palette_c6,
      }, margin))
   end,

   create_with_header_placeholder = function(content, margin)
      return wibox.widget(widget_utils.make_margin({
         {
            forced_height = 10,
            shape         = shape_utils.rounded_rect_top,
            widget        = wibox.container.background,
            bg            = beautiful.palette_c6,
         },
         {
            widget_utils.make_margin(content, margin),
            shape  = shape_utils.rounded_rect_bottom,
            widget = wibox.container.background,
            bg     = beautiful.palette_c6,
         },
         layout = wibox.layout.align.vertical
      }, margin))
   end,

   create_with_header = function(header, content, margin)
      local header_name = {
         markup  = "<span foreground='" .. beautiful.fg_focus .. "'>" .. header .. "</span>",
         font    = beautiful.font_famaly .. '20',
         align   = "center",
         opacity = 1,
         widget  = wibox.widget.textbox,
      }

      return wibox.widget(widget_utils.make_margin({
         {
            widget_utils.make_margin(header_name, margin),
            shape  = shape_utils.rounded_rect_top,
            widget = wibox.container.background,
         },
         {
            widget_utils.make_margin(content, 5),
            shape  = shape_utils.rounded_rect_bottom,
            widget = wibox.container.background,
         },
         layout = wibox.layout.align.vertical
      }, margin))
   end
}

local wibox     = require("wibox")
local beautiful = require("beautiful")
local dpi       = beautiful.xresources.apply_dpi

-- TODO: Extract to utils
local function make_margin(content, margin)
   return {
      content,
      widget  = wibox.container.margin,
      margins = margin or dpi(10),
   }
end

return {
   create = function(content, margin)
      return wibox.widget(make_margin({
         make_margin(content, margin),
         shape  = shape_utils.default_frr,
         widget = wibox.container.background,
         bg     = beautiful.palette_c6,
      }, margin))
   end,

   create_with_header_placeholder = function(content, margin)
      return wibox.widget(make_margin({
         {
            forced_height = 10,
            shape         = shape_utils.partially_rounded_rect(true, true, false, false),
            widget        = wibox.container.background,
            bg            = beautiful.palette_c6,
         },
         {
            make_margin(content, margin),
            shape  = shape_utils.partially_rounded_rect(false, false, true, true),
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

      return wibox.widget(make_margin({
         {
            make_margin(header_name, margin),
            shape  = shape_utils.partially_rounded_rect(true, true, false, false),
            widget = wibox.container.background,
         },
         {
            make_margin(content, 5),
            shape  = shape_utils.partially_rounded_rect(false, false, true, true),
            widget = wibox.container.background,
         },
         layout = wibox.layout.align.vertical
      }, margin))
   end
}

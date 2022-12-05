-- Font Awesome icons creating over wibox textbox widget
local wibox     = require("wibox")
local beautiful = require("beautiful")

local icons = {}

-- wibox text icon
icons.wbi = function(glyph, size)
   local icon = wibox.widget {
      text    = glyph,
      align   = "center",
      opacity = 1,
      font    = beautiful.icons_font .. size,
      widget  = wibox.widget.textbox,
   }

   return icon
end

icons.wbic = function(glyph, size, fg_normal, fg_focus)

   if fg_normal == nil then
      fg_normal = beautiful.fg_normal
   end

   if fg_focus == nil then
      fg_focus = beautiful.fg_focus
   end

   local icon = wibox.widget {
      active  = false,
      markup  = "<span foreground='" .. fg_normal .. "'>" .. glyph .. "</span>",
      align   = "center",
      opacity = 1,
      font    = beautiful.icons_font .. size,
      widget  = wibox.widget.textbox,
   }

   icon.toggle = function()
      icon.active = not icon.active

      if icon.active then
         icon.markup = "<span foreground='" .. fg_focus .. "'>" .. glyph .. "</span>"
      else
         icon.markup = "<span foreground='" .. fg_normal .. "'>" .. glyph .. "</span>"
      end
   end

   return icon
end


-- wibox text icon with opacity change on focus decorator
icons.wbifo = function(icon, init_opacity, focus_opacity)
   icon.opacity = init_opacity
   icon:connect_signal('mouse::enter', function()
      icon.opacity = focus_opacity
   end)

   icon:connect_signal('mouse::leave', function()
      icon.opacity = init_opacity
   end)

   return icon
end


-- wibox text icon with client change decorator
icons.wbicc = function(icon, active_glyph, property, conditionF)
   local init_glyph = icon.text

   local function callback(c)
      local is_active = conditionF(c)
      if (is_active) then
         icon.text = active_glyph
      else
         icon.text = init_glyph
      end
   end

   client.connect_signal("manage", callback)
   client.connect_signal("property::" .. property, callback)

   return icon
end

return icons

local beautiful = require("beautiful")
local gears     = require("gears")

local shape_utils = {

   rounded_rect = function(radius)
      return function(cr, width, height)
         gears.shape.rounded_rect(cr, width, height, radius)
      end
   end,

   partially_rounded_rect = function(tl, tr, br, bl, radius)
      return function(cr, width, height)
         gears.shape.partially_rounded_rect(cr, width, height, tl, tr, br, bl, radius)
      end
   end,


   circle = function(radius)
      return function(cr, width, height)
         gears.shape.circle(cr, radius, radius)
      end
   end,


   pie_half_pi = function(size, angle_start, angle_end)
      return function(cr, width, height)
         gears.shape.pie(cr, size, size, angle_start, angle_end)
      end
   end,

}

shape_utils.default_frr_xsm = shape_utils.rounded_rect(beautiful.rounded_xsm)
shape_utils.default_frr_sm = shape_utils.rounded_rect(beautiful.rounded_sm)
shape_utils.default_frr = shape_utils.rounded_rect(beautiful.rounded_md)
shape_utils.default_frr_lg = shape_utils.rounded_rect(beautiful.rounded_lg)

shape_utils.default_circle = shape_utils.circle(beautiful.rounded_lg)

shape_utils.round_rect_top = shape_utils.partially_rounded_rect(true, true, false, false, beautiful.rounded_lg)
shape_utils.round_rect_bottom = shape_utils.partially_rounded_rect(false, false, true, true, beautiful.rounded_lg)

shape_utils.pie_half_left = function()
   local half_pi = math.pi / 2
   return shape_utils.pie_half_pi(20, half_pi, 0 - half_pi)
end

shape_utils.pie_half_right = function()
   local half_pi = math.pi / 2
   return shape_utils.pie_half_pi(20, 0 - half_pi, half_pi)
end

shape_utils.tags_shape = shape_utils.default_frr_lg

return shape_utils

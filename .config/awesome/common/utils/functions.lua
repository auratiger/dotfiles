local awful = require("awful")
local sqrt  = math.sqrt

utils = {
   arr_contains = function(arr, val)
      for index, value in ipairs(arr) do
         if value == val then
            return true
         end
      end

      return false
   end,

   copy = function(source)
      local result = {}

      for k, v in pairs(source) do
         result[k] = v
      end

      return result
   end,

   split = function(text, delimiter)
      local result = {};

      for match in text:gmatch("([^" .. delimiter .. "]+)") do
         table.insert(result, match);
      end

      return result;
   end,

   trim = function(s)
      return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
   end,

   clear = function(text, ptrn)
      return text:gsub(ptrn, '')
   end,

   is_file_exists = function(path)
      local f = io.open(path, "r")
      if f ~= nil then
         io.close(f)
         return true
      else
         return false
      end
   end,

   -- On the fly useless gaps change
   useless_gaps_resize = function(thatmuch, s, t)
      local scr = s or awful.screen.focused()
      local tag = t or scr.selected_tag
      tag.gap = tag.gap + tonumber(thatmuch)
      awful.layout.arrange(scr)
   end,

   -- Magnify a client: set it to "float" and resize it.
   magnify_client = function(c, width_f, height_f)
      if c and not c.floating then
         utils.magnified_client = c
         utils.mc(c, width_f, height_f)
      else
         utils.magnified_client = nil
         c.floating = false
      end
   end,

   -- https://github.com/lcpz/lain/issues/195
   mc = function(c, width_f, height_f)
      c = c or utils.magnified_client
      if not c then return end

      c.floating   = true
      local s      = awful.screen.focused()
      local mg     = s.workarea
      local g      = {}
      local mwfact = width_f or s.selected_tag.master_width_factor or 0.5
      g.width      = sqrt(mwfact) * mg.width
      g.height     = sqrt(height_f or mwfact) * mg.height
      g.x          = mg.x + (mg.width - g.width) / 2
      g.y          = mg.y + (mg.height - g.height) / 2

      if c then c:geometry(g) end -- if c is still a valid object
   end

}

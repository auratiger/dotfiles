local awful = require("awful")

-- {{{ Mouse bindings
root.buttons(my_table.join(
   awful.button({}, 3, function() awful.util.mymainmenu:toggle() end),
   awful.button({}, 4, awful.tag.viewnext),
   awful.button({}, 5, awful.tag.viewprev)
))
-- }}}


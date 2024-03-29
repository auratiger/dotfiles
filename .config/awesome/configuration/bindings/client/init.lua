local awful = require("awful")

clientkeys = my_table.join(
   awful.key({ modkey, "Shift" }, "m", function()
      utils.magnify_client()
   end,
      { description = "magnify client", group = "client" }),
   awful.key({ modkey, }, "f",
      function(c)
         c.fullscreen = not c.fullscreen
         c:raise()
      end,
      { description = "toggle fullscreen", group = "client" }),
   awful.key({ modkey, }, "c", function(c) c:kill() end,
      { description = "close", group = "hotkeys" }),
   awful.key({ modkey, "Shift" }, "space", awful.client.floating.toggle,
      { description = "toggle floating", group = "client" }),
   -- TODO: what is the master client
   awful.key({ modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end,
      { description = "move to master", group = "client" }),
   -- awful.key({ modkey, "Shift" }, "Left", function(c) c:move_to_screen() end,
   --    { description = "move to screen", group = "client" }),
   -- awful.key({ modkey, "Shift" }, "Right", function(c) c:move_to_screen() end,
   --    { description = "move to screen", group = "client" }),
   awful.key({ modkey, }, "t", function(c) c.ontop = not c.ontop end,
      { description = "toggle keep on top", group = "client" }),
   awful.key({ modkey, "Shift" }, "t", function(c)
      c.ontop = not c.ontop
      c.maximized = not c.maximized
      awful.client.floating.toggle()
   end,
      { description = "toggle keep on top", group = "client" }),
   awful.key({ modkey, }, "n",
      function(c)
         -- The client currently has the input focus, so it cannot be
         -- minimized, since minimized clients can't have the focus.
         c.minimized = true
      end,
      { description = "minimize", group = "client" }),
   awful.key({ modkey, }, "m",
      function(c)
         c.maximized = not c.maximized
         c:raise()
      end,
      { description = "maximize", group = "client" })
)

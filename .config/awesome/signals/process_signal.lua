return {
   {
      command = [[
        zsh -c "top -b | head -14 | tail -7 | awk '{printf \"#\" $12 \"-\" $9 \"__\" $10 \" \"}'"
      ]],
      interval = 5,
      callback = function(widget, stdout)

         local ps_info = {}
         local index   = 1
         for w in stdout:gmatch("%S+") do
            local info = {}
            info.name = w:match("#(.+)-")
            info.cpu = w:match("-(.+)__")
            info.mem = w:match("__(.+)")
            ps_info[index] = info
            index = index + 1

         end
         awesome.emit_signal("sysstat::ps", ps_info)
      end
   }
}

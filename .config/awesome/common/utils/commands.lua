commands = {

   svol =
   [[
     zsh -c "amixer get Master | tail -1 | awk '{print $4}' | grep -o '[0-9]\+'"
   ]],

   brightness =
   [[
     zsh -c "brightnessctl i | head -2 | tail -1 | awk '{printf $4}' | grep -o '[0-9]\+'"
   ]],

   player_toggle =
   [[
     zsh -c "playerctl play-pause"
   ]],

   player_next =
   [[
     zsh -c "playerctl next"
   ]],

   player_prev =
   [[
     zsh -c "playerctl previous"
   ]],

   shutdown = 'sudo shutdown now',

   reboot = 'sudo reboot',

   set_svol = function(audio_val)
      return "amixer set Master " .. audio_val .. "%"
   end,

   mv = function(name1, name2)
      return "mv " .. name1 .. ' ' .. name2
   end,

   set_brightness = function(brightness_val)
      return "brightnessctl s " .. brightness_val .. "%"
   end,

   git_repos = function(scan_root)
      return "find " .. scan_root .. " -name '.git'"
   end,

   git_repo_info = function(path)
      return "git -C " .. path .. " remote show origin"
   end,

   get_files = function(path)
      return "ls -l " .. path .. " | awk '{print $NF}' | tail -n +2"
   end,

   get_files_watchdog = function(path)
      return 'zsh -c "ls -l ' .. path .. ' | awk \'{printf $9 \\"\\n\\"}\'"'
   end,


   delete_file = function(path)
      return "rm " .. path
   end,

   get_text = function(path)
      return "cat " .. path
   end,

   create_text_file = function(path)
      return "echo -n '' > " .. path
   end,

   append_text = function(path, text)
      return "echo -n '" .. text .. "' >> " .. path
   end,

   get_text_sorted = function(path, col, direction)
      local cmd = (direction and 'desc' == direction) and "sort -r -k " or "sort -k "
      return cmd .. tostring(col) .. ' ' .. path
   end

}

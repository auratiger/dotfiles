local caching = require("common.caching")

return {
   {
      command = [[
          zsh -c "docker ps -a --format '{{.ID}}|||{{.Image}}|||{{.Names}}|||{{.Ports}}|||{{.Status}}|||{{.RunningFor}}'"
        ]],
      interval = 20,
      callback = function(widget, stdout)

         awful.spawn.with_shell(commands.create_text_file(cfg.panels.docker.cache_file))

         stdout = stdout:gsub("||||||", "|||Noinfo|||")
         stdout = stdout:gsub(", ", "@")

         local lines = utils.split(stdout, '\n')

         local containers = {}
         for _, value in ipairs(lines) do
            if #value > 0 then
               value = utils.trim(value)
               table.insert(containers, value)
            end
         end

         caching.procedures.caching(cfg.panels.docker.cache_file, "sysstat::docker_container_add", containers,
            function(value, callback)

               local line_data = utils.split(utils.trim(value), "|||")

               line_data[5] = line_data[5]:match("^%w+")

               local time = line_data[6]:match("^%d+%s+%w+")
               if time == nil then
                  line_data[6] = line_data[6]:match("About%s+a%w*%s+(%w+)")
               else
                  line_data[6] = time
               end

               if line_data[6] ~= nil then
                  line_data[6] = line_data[6]:gsub("%s", "|||")
               end

               callback(line_data)
            end)
      end
   }
}

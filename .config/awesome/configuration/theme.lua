local beautiful = require("beautiful") -- Theme handling library

local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", home_folder, cfg.theme.name)
beautiful.init(theme_path)

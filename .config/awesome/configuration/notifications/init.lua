local dpi     = require("beautiful").xresources.apply_dpi
local naughty = require("naughty")

naughty.persistence_enabled = true
naughty.config.defaults['icon_size'] = 100
naughty.config.defaults.ontop = true
naughty.config.defaults.timeout = 5
naughty.config.defaults.title = "Alert"
naughty.config.defaults.position = "top_right"

require("configuration.notifications.rules")
require("configuration.notifications.connections")

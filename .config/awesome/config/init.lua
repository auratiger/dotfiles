local gears = require("gears") --Utilities such as color parsing and objects
local awful = require("awful") --Everything related to window managment

local shape_utils = require("common.shape")
local naughty     = require("naughty")

my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

-- NOTE: Awesomewm loads before zsh, and thus reads it's env variables from the /etc/profile config.
-- A workaround to this is to source your zsh files from the /etc/profile file so they get loaded at
-- the correct time.
home_folder = os.getenv("HOME")
user        = os.getenv("USER")

-- {{{ Variable definitions
--
-- modkey or mod4 = super key
modkey = "Mod4"
altkey = "Mod1"

-- personal variables
--change these variables if you want
browser1       = "vivaldi-stable"
browser2       = "firefox"
browser3       = "chromium -no-default-browser-check"
terminal       = "alacritty"
editor         = os.getenv("EDITOR") or "nvim"
editor_cmd     = terminal .. " -e " .. editor
editorgui      = "code"
filemanager    = "thunar"
mailclient     = "evolution"
mediaplayer    = "vlc"
musicplayer    = "spotify"
virtualmachine = "virtualbox"
chat           = "discord"


cfg = {
   theme = {
      name = "neon-dream-v2",
      cache_file = home_folder .. '/.cache/awesome/themes',
   },
   tags = {
      -- names = { "web", "dev", "misc" },
      -- names = { "➊", "➋", "➌", "➍", "➎", "➏", "➐", "➑", "➒" },
      -- names = { "⠐", "⠡", "⠲", "⠵", "⠻", "⠿" },
      -- names = { "⌘", "♐", "⌥", "ℵ" },
      -- names = { "www", "edit", "gimp", "inkscape", "music" },
      -- Use this : https://fontawesome.com/cheatsheet
      names = { "", "", "", "", "", "", "" },
      shape = shape_utils.default_frr
   },
   panels = {
      packages = {
         enabled = true,
         names = {
            'git', 'lua', 'awesome-git',
            'alacritty', 'zsh', 'neovim',
            'rofi', 'yay', 'pacman', 'alsa-lib',
            'spotify', 'spicetify-cli', 'systemd',
            'sudo', 'ttf-jetbrains-mono', 'ttf-font-awesome',
            'ranger', 'python', 'pulseaudio', 'playerctl', 'picom'
         },
         cache_file = home_folder .. '/.cache/awesome/packages',
         pagination_defaults = {
            size          = 12, -- items per page,
            order         = 'asc', -- asc or desc
            sort_property = 1, -- 1-Name, 3-Current Version, 6-Available version

         },
         style = {
            card_margin = 7,
         }
      },
      git = {
         --[[
				Packages Required:
				1. git
			]]     --
         enabled             = false,
         scan_root_path      = home_folder,
         cache_file          = home_folder .. '/.cache/awesome/repos',
         pagination_defaults = {
            size          = 12, -- items per page,
            order         = 'asc', -- asc or desc
            sort_property = 3, -- 2-Path, 3-Name, 4-Remote URL
         },
         style               = {
            card_margin = 5,
         },
         exclude_paths       = {
            home_folder .. '/.cache/yay/',
            home_folder .. '/.local/share/nvim/'
         }
      },
      docker = {
         --[[
				Packages Required:
				1. docker
			]]     --
         enabled = false,
         cache_file = home_folder .. '/.cache/awesome/docker_containers',
         pagination_defaults = {
            size          = 10, -- items per page,
            order         = 'asc', -- asc or desc
            sort_property = 3, -- 1-ID, 2-Image, 3-Name, 4-Ports, 5-Status
         },
         style = {
            card_margin = 5,
         }
      },
      stats = {
         enabled = true,
      },
      user = {
         --[[
				Packages Required:
				1. spotify
				2. alsa-utils
				3. pulseaudio
				4. amixer
				5. playerctl
				5. brightnessctl

				Action Required:
				1. Setup Weather
					1. Go to www.weatherapi.com and create your account
					2. Export API Key into environment variable WEATHER_API_COM_API_KEY in .profile file
					3. Export Your city location into environment variable WEATHER_API_COM_CITY in .profile file
			]]     --
         enabled = true,
      }
   },


   widgets = {

      todo = {
         path = home_folder .. '/.cache/awesome/todo/'
      },

      calendar = {
         week_started_on_sunday = true,
         weekend_days_indexes   = { 5, 6 },
      }
   }
}

naughty.persistence_enabled = true
naughty.config.defaults.ontop = true
naughty.config.defaults.timeout = 5
naughty.config.defaults.title = "Alert"
naughty.config.defaults.position = "top_right"

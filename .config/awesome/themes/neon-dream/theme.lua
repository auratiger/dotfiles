--[[

     Multicolor Awesome WM theme 2.0
     github.com/lcpz

--]]

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")

local dpi = xresources.apply_dpi
local os = os

local theme = {}

theme.confdir = os.getenv("HOME") .. "/.config/awesome/themes/custom"
--theme.wallpaper                                 = theme.confdir .. "/wallpaper.jpg"
--theme.wallpaper                                 = "/usr/share/backgrounds/arcolinux/arco-wallpaper.jpg"
--theme.wallpaper                                 = "/usr/share/archlinux-tweak-tool/data/wallpaper/wallpaper.png"

theme.font_famaly = "JetBrains Mono "
theme.font_size   = 13
theme.font        = theme.font_famaly .. tostring(theme.font_size)
-- theme.font                                      = "Noto Sans Regular 11"
-- theme.taglist_font                              = "Noto Sans Regular 13"

theme.palette_c1 = "#ff77ff"
theme.palette_c2 = "#88ffff"
theme.palette_c3 = "#1e1e2c"
theme.palette_c4 = "#ffaaff"
theme.palette_c5 = "#333170"
theme.palette_c6 = "#2a2939"
theme.palette_c7 = "#33334a"
theme.col_transparent = "#00000000"
theme.palette_positive = "#88ffbb"
theme.palette_negative = "#b84f48"


theme.bg_normal   = theme.palette_c3
theme.bg_focus    = theme.palette_c3
theme.bg_urgent   = theme.palette_c1
theme.bg_minimize = "#444444"
theme.bg_systray  = theme.bg_normal
theme.fg_normal   = theme.palette_c2
theme.fg_focus    = theme.palette_c4
theme.fg_urgent   = "d61ff0"
theme.fg_minimize = "#ffffff"

theme.normal_opacity = 1
theme.focus_opacity  = 0.6
theme.useless_gap    = dpi(5)
theme.border_width   = dpi(2)
theme.border_normal  = theme.col_transparent
theme.border_focus   = theme.palette_c2
theme.border_marked  = "#91231c"


-- -- Progreess bar widget settings
theme.pbar_heigth       = 30
theme.pbar_width        = 30
theme.pbar_margin       = 5
theme.pbar_active_color = theme.palette_c1
theme.pbar_bg_color     = theme.palette_c5
theme.pbar_icon_size    = 16

-- -- Battery indicator widget settings
theme.battery_opacity   = 1
theme.battery_alignment = "center"
theme.battery_size      = 60
-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
-- theme.taglist_fg_focus  = "#ff0000"

-- Generate taglist squares:
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
   taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
   taglist_square_size, theme.fg_normal
)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

theme.menu_submenu_icon = theme.confdir .. "/icons/submenu.png"
theme.menu_border_width = 0
theme.menu_height       = dpi(25)
theme.menu_width        = dpi(260)
theme.menu_fg_normal    = "#aaaaaa"
theme.menu_fg_focus     = "#ff8c00"
theme.menu_bg_normal    = "#050505dd"
theme.menu_bg_focus     = "#050505dd"

theme.icons_font = "Font Awesome 6 Free "

theme.rounded = dpi(20)

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
   theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

theme.widget_temp        = theme.confdir .. "/icons/temp.png"
theme.widget_uptime      = theme.confdir .. "/icons/ac.png"
theme.widget_cpu         = theme.confdir .. "/icons/cpu.png"
theme.widget_weather     = theme.confdir .. "/icons/dish.png"
theme.widget_fs          = theme.confdir .. "/icons/fs.png"
theme.widget_mem         = theme.confdir .. "/icons/mem.png"
theme.widget_netdown     = theme.confdir .. "/icons/net_down.png"
theme.widget_netup       = theme.confdir .. "/icons/net_up.png"
theme.widget_mail        = theme.confdir .. "/icons/mail.png"
theme.widget_batt        = theme.confdir .. "/icons/bat.png"
theme.widget_clock       = theme.confdir .. "/icons/clock.png"
theme.widget_vol         = theme.confdir .. "/icons/spkr.png"
theme.widget_music       = theme.confdir .. "/icons/note.png"
theme.widget_music_on    = theme.confdir .. "/icons/note.png"
theme.widget_music_pause = theme.confdir .. "/icons/pause.png"
theme.widget_music_stop  = theme.confdir .. "/icons/stop.png"

theme.taglist_squares_sel   = theme.confdir .. "/icons/square_a.png"
theme.taglist_squares_unsel = theme.confdir .. "/icons/square_b.png"

theme.tasklist_plain_task_name = true
theme.tasklist_disable_icon    = true

theme.layout_tile       = theme.confdir .. "/icons/tile.png"
theme.layout_tilegaps   = theme.confdir .. "/icons/tilegaps.png"
theme.layout_tileleft   = theme.confdir .. "/icons/tileleft.png"
theme.layout_tilebottom = theme.confdir .. "/icons/tilebottom.png"
theme.layout_tiletop    = theme.confdir .. "/icons/tiletop.png"
theme.layout_fairv      = theme.confdir .. "/icons/fairv.png"
theme.layout_fairh      = theme.confdir .. "/icons/fairh.png"
theme.layout_spiral     = theme.confdir .. "/icons/spiral.png"
theme.layout_dwindle    = theme.confdir .. "/icons/dwindle.png"
theme.layout_max        = theme.confdir .. "/icons/max.png"
theme.layout_fullscreen = theme.confdir .. "/icons/fullscreen.png"
theme.layout_magnifier  = theme.confdir .. "/icons/magnifier.png"
theme.layout_floating   = theme.confdir .. "/icons/floating.png"

theme.titlebar_close_button_normal              = theme.confdir .. "/icons/titlebar/close_normal.png"
theme.titlebar_close_button_focus               = theme.confdir .. "/icons/titlebar/close_focus.png"
theme.titlebar_minimize_button_normal           = theme.confdir .. "/icons/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus            = theme.confdir .. "/icons/titlebar/minimize_focus.png"
theme.titlebar_ontop_button_normal_inactive     = theme.confdir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = theme.confdir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = theme.confdir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = theme.confdir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_sticky_button_normal_inactive    = theme.confdir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = theme.confdir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = theme.confdir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = theme.confdir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_floating_button_normal_inactive  = theme.confdir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = theme.confdir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = theme.confdir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = theme.confdir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_maximized_button_normal_inactive = theme.confdir .. "/icons/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.confdir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = theme.confdir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = theme.confdir .. "/icons/titlebar/maximized_focus_active.png"

theme.profile_pic = home_folder .. "/.config/awesome/profile.png"

return theme

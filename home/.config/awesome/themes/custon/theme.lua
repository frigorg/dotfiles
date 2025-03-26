------------------------------
-- Material Black Pistachio --
------------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local themes_path = string.format("%s/.config/awesome/themes/", os.getenv("HOME"))

local theme = {}

-- Color palette
-- #090909 - background
-- #0F1010 - background
-- #1A1C1E - background
-- #545454 - foreground
-- #C1C1C1 - foreground
-- #234D4A - highlighting
-- #38B7AB - highlighting
-- #B73844 - Highlighting complementary red
-- #B7AB38 - Highlighting complementary yellow

theme.titlebars_enabled = false

theme.font          = "Fira code bold 9"

theme.bg_normal     = "#0F1010"
theme.bg_focus      = "#545454"
theme.bg_urgent     = "#B73844"
theme.bg_minimize   = "#090909"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#C1C1C1"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.border_normal = "#1A1C1E"
theme.border_focus  = "#38B7AB"
theme.border_marked = "#B73844"

theme.taglist_bg_focus = "#234D4A"
theme.font_color_l = "#545454"
theme.font_color_h = "#C1C1C1"

theme.systray_icon_spacing = dpi(8)

theme.useless_gap   = dpi(2)
theme.border_width  = dpi(2)
theme.screen_padding = { top = dpi(0),
                         right = dpi(0),
                         bottom = dpi(0),
                         left = dpi(0),}

theme.movement_offset = 10
theme.floating_resize_amount = 20
theme.tiling_resize_factor = 0.05

-- theme.wibar_height = dpi(25)

-- Generate taglist squares:
local taglist_square_size = dpi(4)
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

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

theme.wallpaper = themes_path.."custon/background.jpg"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil


return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80

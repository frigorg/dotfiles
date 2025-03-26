-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Wibox handling library
local wibox = require("wibox")

-- Custom Local Library: Common Functional Decoration
local deco = {
  wallpaper = require("deco.wallpaper"),
  taglist   = require("deco.taglist"),
  tasklist  = require("deco.tasklist")
}

local taglist_buttons  = deco.taglist()
local tasklist_buttons = deco.tasklist()

local systats = require("widgets.systats-widget.systats")

local logout_menu_widget = wibox.widget.textbox('X')
local volume_widget = wibox.widget.textbox('X')
local cw = wibox.widget.textbox('X')

if pcall(function () 
    logout_menu_widget = require("awesome-wm-widgets.logout-menu-widget.logout-menu")
    volume_widget = require("awesome-wm-widgets.volume-widget.volume")
    local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")
    cw = calendar_widget({
                                theme = 'nord',
                                placement = 'top_right',
                                start_sunday = true,
                                radius = 8,
                                previous_month_button = 1,
                                next_month_button = 3,})
end ) == false then
    error("Awesome-wm-widgets repository is needed.")
end

local separator = wibox.widget {
    widget = wibox.widget.separator,
    orientation = 'vertical',
    forced_width = 15,
    forced_height = 2,
}

local _M = {}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock(' %d/%m/%y | %H:%M ')

mytextclock:connect_signal("button::press",
    function(_, _, _, button)
       if button == 1 then cw.toggle() end
    end)

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({ }, 1, function () awful.layout.inc( 1) end),
    awful.button({ }, 3, function () awful.layout.inc(-1) end),
    awful.button({ }, 4, function () awful.layout.inc( 1) end),
    awful.button({ }, 5, function () awful.layout.inc(-1) end)
  ))

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    buttons = taglist_buttons
  }

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist {
    screen  = s,
    filter  = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons
  }

  -- Create the wibox
  s.mywibox = awful.wibar({ position = "top", screen = s })

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      logout_menu_widget {
        onlock = function()
            awful.spawn.with_shell('i3lock-fancy')
            end
      },
      s.mytaglist,
      s.mypromptbox,
    },
    s.mytasklist, -- Middle widget
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      -- mykeyboardlayout,
      wibox.widget.systray(),
      separator,
      systats,
      separator,
      mytextclock,
      -- volume_widget{widget_type = 'icon_and_text'},
      s.mylayoutbox,
    },
  }
end)
-- }}}

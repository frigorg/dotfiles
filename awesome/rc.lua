pcall(require, "luarocks.loader")

-- PROGRAMS NEEDED TO RUN PROPERLY MY WITH MY CONFIGS
-- numlockx
-- pulsemixer
-- pavucontrol
-- playerctl
-- xclip
-- maim
-- xfce4-screenshooter
-- ibus
-- i3lock

local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")
local create_rules = require("rules").create
local keys = require("keys")

-- Widgets
local systats = require("widgets/systats-widget/systats")
local logout_menu_widget = require("awesome-wm-widgets.logout-menu-widget.logout-menu")
local volume_widget = require('awesome-wm-widgets.volume-widget.volume')

local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")
local cw =
    calendar_widget({theme = 'dark', placement = 'top_right', radius = 8})

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    })
end


-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err)
        })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions

-- screen padding (uses 0 for each side when not defined)
local sp = beautiful.screen_padding

local programs = {
    terminal = "alacritty",
    filemanager = "nautilus",
    calculator = "gnome-calculator",
    browser = "google-chrome",
    launcher = "dmenu_run"
}

editor = os.getenv("EDITOR") or "gvim"
editor_cmd = programs.terminal .. " -e " .. editor

local globalkeys = keys.globalkeys(programs)
local clientkeys = keys.clientkeys()
local clientbuttons = keys.clientbuttons()

local theme = "custon"
-- local theme = "froggy"
-- local theme = "default"
-- local theme = "gtk"
-- local theme = "sky"
-- local theme = "xresources"
-- local theme = "zenburn"

-- Themes define colours, icons, font and wallpapers.
local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua",
                                 os.getenv("HOME"), theme)
beautiful.init(theme_path)

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.spiral, -- awful.layout.suit.spiral.dwindle
    awful.layout.suit.floating
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.tile,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- }}}

-- {{{ Rules
awful.rules.rules = create_rules(clientkeys, clientbuttons)
-- }}}

-- {{{ Wibar

-- Create a wibox for each screen and add it
-- Mouse keybindings for taglist widget
local taglist_buttons = gears.table.join(
                            awful.button({}, 1, function(t) t:view_only() end),
                            awful.button({modkey}, 1, function(t)
        if client.focus then client.focus:move_to_tag(t) end
    end), awful.button({}, 3, awful.tag.viewtoggle),
                            awful.button({modkey}, 3, function(t)
        if client.focus then client.focus:toggle_tag(t) end
    end), awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
                            awful.button({}, 5, function(t)
        awful.tag.viewprev(t.screen)
    end))

-- Mouse keybindings for tasklist (app list on taskbar) widget
local tasklist_buttons = gears.table.join(
                             awful.button({}, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal("request::activate", "tasklist", {raise = true})
        end
    end), awful.button({}, 4, function() awful.client.focus.byidx(1) end),
                             awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
    end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then wallpaper = wallpaper(s) end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

-- Create a textclock widget
mytextclock = wibox.widget {
    {
        {
            {widget = wibox.widget.textclock("%R"), align = "center"},
            top = 3,
            bottom = 3,
            widget = wibox.container.margin
        },
        shape = function(cr, width, height)
            gears.shape.rectangle(cr, width, height)
        end,
        bg = beautiful.bg_widget,
        widget = wibox.container.background
    },
    layout = wibox.layout.fixed.horizontal
}
mytextclock:connect_signal("button::press", function(_, _, _, button)
    if button == 1 then cw.toggle() end
end)

local separator = wibox.widget {
    widget = wibox.widget.separator,
    orientation = 'vertical',
    forced_width = 15,
    forced_height = 2,
}

local systray = wibox.widget.systray()

-- callback function for each screen creation
awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({"1", "2", "3", "4", "5", "6", "7", "8"}, s,
              awful.layout.layouts[1])

    awful.tag.add("9",  {
                        screen = s,
                        layout = awful.layout.layouts[2],
                        })

    -- Set screen padding
    if not sp then sp = {top = 0, right = 0, bottom = 0, right = 0} end
    s.padding = beautiful.screen_padding

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                              awful.button({}, 1,
                                           function() awful.layout.inc(1) end),
                              awful.button({}, 3,
                                           function()
            awful.layout.inc(-1)
        end), awful.button({}, 4, function() awful.layout.inc(1) end),
                              awful.button({}, 5,
                                           function()
            awful.layout.inc(-1)
        end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({position = "top", screen = s})

    -- Add widgets to the wibox
    s.mywibox:setup{
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            s.mylayoutbox,
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mypromptbox
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            separator,
            systray,
            separator,
            systats,
            separator,
            volume_widget{
                widget_type = 'icon_and_text'
            },
            separator,
            mytextclock,
            separator,
            logout_menu_widget {
                onlock = function()
                    awful.spawn.with_shell('i3lock -ub -c 000000')
                end
            }
        }
    }
end)
-- }}}

-- {{{ Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and not c.size_hints.user_position and
        not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    else
        -- Every new client will be slave, not master
        awful.client.setslave(c)
    end
end)

-- Enable sloppy focus, so that focus follows mouse.
--[[
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)
--]]
client.connect_signal("focus",
                      function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus",
                      function(c) c.border_color = beautiful.border_normal end)
-- }}}

--- Lower nenory consumption
collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)

-- Startup commands/programs
do
    local cmds =
    {
        -- Set my mouse acceleration
        "xinput --set-prop 'Logitech Gaming Mouse G402' 'libinput Accel Speed' -0.8255",
        -- applet for NetworkManager
        "nm_applet",
        "numlockx on"
    }

    for _,i in pairs(cmds) do
        awful.util.spawn(i)
    end
end


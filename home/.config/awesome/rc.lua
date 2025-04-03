-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")

RC = {} -- global namespace, on top before require any modules
RC.vars = require("main.user-variables")

local startup_programs = require("main.startup-programs")

-- {{{ Error handling -- }}}
require("main.error-handling")

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
local theme = "custon"
-- local theme = "froggy"
-- local theme = "default"
-- local theme = "gtk"
-- local theme = "sky"
-- local theme = "xresources"
-- local theme = "zenburn"

local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), theme)
beautiful.init(theme_path)
-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.wallpaper = RC.vars.wallpaper

modkey = RC.vars.modkey

-- Custom Local Library
local main = {
  layouts = require("main.layouts"),
  tags    = require("main.tags"),
  rules   = require("main.rules"),
}

-- Custom Local Library: Keys and Mouse Binding
local binding = {
  globalbuttons = require("binding.globalbuttons"),
  clientbuttons = require("binding.clientbuttons"),
  globalkeys    = require("binding.globalkeys"),
  bindtotags    = require("binding.bindtotags"),
  clientkeys    = require("binding.clientkeys")
}
-- }}}
--
-- {{{ Layouts
-- Table of layouts to cover with awful.layout.inc, order matters.
-- a variable needed in main.tags, and statusbar
-- awful.layout.layouts = { ... }
RC.layouts = main.layouts()
awful.layout.layouts = RC.layouts
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
-- a variable needed in rules, tasklist, and globalkeys
RC.tags = main.tags()
-- }}}

-- {{{ Mouse and Key bindings
RC.globalkeys = binding.globalkeys()
RC.globalkeys = binding.bindtotags(RC.globalkeys)

-- Set root
root.buttons(binding.globalbuttons())
root.keys(RC.globalkeys)
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Statusbar: Wibar
require("deco.statusbar")
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = main.rules(
  binding.clientkeys(),
  binding.clientbuttons()
)
-- }}}

-- {{{ Signals
require("main.signals")
-- }}}


-- {{{ Startup programs
awful.util.spawn("numlockx on")
for _,i in pairs(startup_programs) do
    -- check if the program is already running
    local s = string.format("ps -e | grep %s",i)
    if os.execute(s) ~= 0 then
        awful.util.spawn(i)
    end
end
-- }}}

awful.util.spawn("xrandr --output HDMI-0 --mode 1920x1080 --pos 1366x0 --rotate normal --output DP-1 --mode 1366x768 --pos 0x50 --left-of HDMI-0 --rotate normal")

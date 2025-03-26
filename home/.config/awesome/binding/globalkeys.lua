local gears = require("gears")
local awful = require("awful")
-- local hotkeys_popup = require("awful.hotkeys_popup").widget
local hotkeys_popup = require("awful.hotkeys_popup")
-- Menubar library
local menubar = require("menubar")

-- Theme handling library
local beautiful = require("beautiful")

-- Resource Configuration
local modkey = RC.vars.modkey
local terminal = RC.vars.terminal
local filemanager = RC.vars.filemanager
local calculator = RC.vars.calculator
local browser = RC.vars.browser
local launcher = RC.vars.launcher

local function move_client(c, direction)
    if c then
        if c.floating or
            (awful.layout.get(mouse.screen) == awful.layout.suit.floating) then
            local workarea = awful.screen.focused().workarea
            local padding = awful.screen.focused().padding
            local border = beautiful.border_width
            local gap = beautiful.useless_gap

            if direction == "up" then
                c:geometry({
                    x = workarea.x + padding.left + gap * 2,
                    y = workarea.y + padding.top + gap * 2,
                    height = workarea.height / 2 -
                        (padding.top + padding.bottom + gap * 3 + border * 2),
                    width = workarea.width -
                        (padding.left + padding.right + gap * 3 + border * 3)
                })
            elseif direction == "right" then
                c:geometry({
                    x = workarea.width / 2 + padding.left + gap,
                    y = workarea.y + padding.top + gap * 2,
                    height = workarea.height -
                        (padding.top + padding.bottom + gap * 3 + border * 3),
                    width = workarea.width / 2 -
                        (padding.left + padding.right + gap * 3 + border * 2)
                })
            elseif direction == "down" then
                c:geometry({
                    x = workarea.x + padding.left + gap * 2,
                    y = workarea.height / 2 + padding.top + gap * 4 + border * 4,
                    height = workarea.height / 2 -
                        (padding.top + padding.bottom + gap * 3 + border * 2),
                    width = workarea.width -
                        (padding.left + padding.right + gap * 3 + border * 3)
                })
            elseif direction == "left" then
                c:geometry({
                    x = workarea.x + padding.left + gap * 2,
                    y = workarea.y + padding.top + gap * 2,
                    height = workarea.height -
                        (padding.top + padding.bottom + gap * 3 + border * 3),
                    width = workarea.width / 2 -
                        (padding.left + padding.right + gap * 3 + border * 2)
                })
            end
        end
    end
end

local _M = {}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get()
  local globalkeys = gears.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),

    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Tag browsing
    awful.key({ modkey,           }, ",",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),

    awful.key({ modkey,           }, ".",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),

    awful.key({ "Mod1",           }, "Tab", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "Tab", 
        --TODO improve box style
        function() 
        awful.menu.client_list({theme = {width = 250}}) 
    end, {description = "Open a navigation box", group = "tag"}),

    awful.key({ modkey,           }, "j", function () awful.client.focus.byidx( 1) end,
        {description = "focus next by index", group = "client"}),
    awful.key({ modkey,           }, "l", function () awful.client.focus.byidx( 1) end,
        {description = "focus next by index", group = "client"}),

    awful.key({ modkey,           }, "k", function () awful.client.focus.byidx(-1) end,
        {description = "focus previous by index", group = "client"}),
    awful.key({ modkey,           }, "h", function () awful.client.focus.byidx(-1) end,
        {description = "focus previous by index", group = "client"}),

    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),

    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),

    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),

    awful.key({ modkey, "Control" }, "l", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),

    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),

    awful.key({ modkey, "Control" }, "h", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),

    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),

    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Standard program
    awful.key({ modkey,           }, "c", function() awful.spawn(calculator) end,
              {description = "open a calculator", group = "launcher"}),
    awful.key({ modkey,           }, "p", function() awful.spawn(filemanager) end,
              {description = "open a file manager", group = "launcher"}),
    awful.key({ modkey,           }, "t", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({modkey,            }, "b", function() awful.spawn(browser) end,
              {description = "open an internet browser", group = "launcher"}),
    awful.key({modkey,            }, "Return", function() awful.spawn(launcher) end,
              {description = "open a launcher", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Layout manipulation
    awful.key({ modkey,           }, "space", 
        function () 
            local t = client.focus and client.focus.first_tag or nil
            if t then
                local clts = t:clients()
                for _, c in pairs(clts) do
                    if c.maximized then c.maximized = false end
                end
            end
            awful.layout.inc( 1)
        end,
              {description = "select next", group = "layout"}),

    awful.key({ modkey, "Shift"   }, "space", 
        function () 
            local t = client.focus and client.focus.first_tag or nil
            if t then
                local clts = t:clients()
                for _, c in pairs(clts) do
                    if c.maximized then c.maximized = false end
                end
            end
            awful.layout.inc(-1)
        end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Prompt
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),

    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Resize
    --awful.key({ modkey, "Control" }, "Left",  function () awful.client.moveresize( 20,  20, -40, -40) end),
    --awful.key({ modkey, "Control" }, "Right", function () awful.client.moveresize(-20, -20,  40,  40) end),
    awful.key({ modkey, "Control" }, "Down",  
              function () awful.client.moveresize( 0, 0, 0,  20) end),
    awful.key({ modkey, "Control" }, "Up",    
              function () awful.client.moveresize( 0, 0, 0, -20) end),
    awful.key({ modkey, "Control" }, "Left",  
              function () awful.client.moveresize( 0, 0, -20, 0) end),
    awful.key({ modkey, "Control" }, "Right", 
              function () awful.client.moveresize( 0, 0,  20, 0) end),

    -- Move
    awful.key({ modkey, "Shift"   }, "Down",  
              function () awful.client.moveresize(  0,  20,   0,   0) end),
    awful.key({ modkey, "Shift"   }, "Up",    
              function () awful.client.moveresize(  0, -20,   0,   0) end),
    awful.key({ modkey, "Shift"   }, "Left",  
              function () awful.client.moveresize(-20,   0,   0,   0) end),
    awful.key({ modkey, "Shift"   }, "Right", 
              function () awful.client.moveresize( 20,   0,   0,   0) end),

    awful.key({ modkey,           }, "Up", function() move_client(client.focus, "up") end, 
              {description = "Move floating client to the upper edge", group = "client"}),
    awful.key({ modkey,           }, "Right", function() move_client(client.focus, "right") end, 
              {description = "Move floating client to the right edge", group = "client"}),
    awful.key({ modkey,           }, "Down", function() move_client(client.focus, "down") end,
              {description = "Move floating client to the botton edge", group = "client"}),
    awful.key({ modkey,           }, "Left", function() move_client(client.focus, "left") end,
              {description = "Move floating client to the left edge", group = "client"}),

    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Multimediakeys
    awful.key({}, "XF86Tools", 
              function()
                 -- pacmd set-card-profile 0 output:hdmi-stereo-extra1
                 -- pacmd set-card-profile 0 output:analog-stereo+input:analog-stereo
              end, 
              {description = "Change audio device", group = "multimedia"}),

    awful.key({}, "XF86AudioPlay", function() awful.spawn("playerctl play-pause") end, 
              {description = "plays or pause current music player", group = "multimedia"}), 

    awful.key({}, "XF86AudioNext", function() awful.spawn("playerctl next") end,
              {description = "plays next music", group = "multimedia"}), 

    awful.key({}, "XF86AudioPrev", function() awful.spawn("playerctl previous") end,
              {description = "plays previous music", group = "multimedia"}), 
    
    awful.key({}, "XF86AudioStop", function() awful.spawn("playerctl stop") end, 
              {description = "stops the music", group = "multimedia"}), 

    awful.key({}, "XF86AudioRaiseVolume", 
              function() 
                  awful.spawn("amixer sset Master 5%+") 
                  awesome.emit_signal("volume_change") 
              end,
              {description = "raise system volume", group = "multimedia"}),

    awful.key({}, "XF86AudioLowerVolume", 
              function()
                 awful.spawn("amixer sset Master 5%-")
                 awesome.emit_signal("volume_change")
              end,
              {description = "lower system volume", group = "multimedia"}),

    awful.key({}, "XF86AudioMute", 
              function()
                 awful.spawn("amixer -D pulse set Master toggle")
                 awesome.emit_signal("volume_change")
              end, 
              {description = "mute system audio", group = "multimedia"})
  )

  return globalkeys
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })

local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")

local keys = {}

-- {{{ Variable definitions

local movement_offset = 10
local floating_resize_amount = 20
local tiling_resize_factor = 0.05

-- Default modkey.
modkey = "Mod4"

-- screen padding (uses 0 for each side when not defined)
sp = beautiful.screen_padding

-- }}} Variable definitions

-- TODO Need to fix the useless spaces to be perfect
-- Move given client to the edge of screen
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

local function maximize_client(c)
    if c then
        if c.floating or
            (awful.layout.get(mouse.screen) == awful.layout.suit.floating) then
            local workarea = awful.screen.focused().workarea
            local padding = awful.screen.focused().padding
            local border = beautiful.border_width
            local gap = beautiful.useless_gap

            c:geometry({
                x = workarea.x + padding.left + gap * 2,
                y = workarea.y + padding.top + gap * 2,
                height = workarea.height -
                    (padding.top + padding.bottom + gap * 3 + border * 3),
                width = workarea.width -
                    (padding.left + padding.right + gap * 3 + border * 3)
            })
        end
    end
end

local function shift_client(c, direction)
    if awful.layout.get(mouse.screen) == awful.layout.suit.floating or
        (c and c.floating) then
        if direction == "up" then
            c:relative_move(0, -movement_offset, 0, 0)
        elseif direction == "down" then
            c:relative_move(0, movement_offset, 0, 0)
        elseif direction == "left" then
            c:relative_move(-movement_offset, 0, 0, 0)
        elseif direction == "right" then
            c:relative_move(movement_offset, 0, 0, 0)
        end
    end
end

-- [[ credits: https://github.com/WillPower3309/awesome-dotfiles/blob/master/awesome/keys.lua

local function resize_client(c, direction)
    if awful.layout.get(mouse.screen) == awful.layout.suit.floating or
        (c and c.floating) then
        if direction == "up" then
            c:relative_move(0, 0, 0, -floating_resize_amount)
        elseif direction == "down" then
            c:relative_move(0, 0, 0, floating_resize_amount)
        elseif direction == "left" then
            c:relative_move(0, 0, -floating_resize_amount, 0)
        elseif direction == "right" then
            c:relative_move(0, 0, floating_resize_amount, 0)
        end
    else -- This part does not work
        if direction == "up" then
            awful.client.incwfact(-tiling_resize_factor)
        elseif direction == "down" then
            awful.client.incwfact(tiling_resize_factor)
        elseif direction == "left" then
            awful.tag.incmwfact(-tiling_resize_factor)
        elseif direction == "right" then
            awful.tag.incmwfact(tiling_resize_factor)
        end
    end
end

-- ]] /credits

-- {{{ Key bindings
function keys.globalkeys(programs)
    local out = gears.table.join( -- {{{ View
    -- Screen related
    awful.key({modkey}, "F12", function()
        awful.spawn.with_shell(
            "maim -us ~/Pictures/Screenshot/$(date +%d-%m-%y_%H-%M-%S-%N).png",
            false)
    end, {description = "take a screenshot all screen", group = "screen"}),
    awful.key({modkey, "Control"}, "j",
              function() awful.screen.focus_relative(1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({modkey, "Control"}, "k",
              function() awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({modkey, "Control"}, "l",
              function() awful.screen.focus_relative(1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({modkey, "Control"}, "h",
              function() awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),

    awful.key({modkey}, "d",
              function() awful.tag.viewnone(awful.screen.focused()) end,
              {description = "show no tags", group = "tag"}), -- Tag related
    awful.key({modkey}, ",", awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({modkey}, ".", awful.tag.viewnext,
              {description = "view next", group = "tag"}),

    awful.key({modkey, "Shift"}, ",", 
    function()
            if client.focus then
                local tag = client.focus.screen.tags[client.focus.first_tag.index - 1]
                if tag then client.focus:move_to_tag(tag) end
            end
        end,
              {description = "move client to previous tag", group = "client"}),
    awful.key({modkey, "Shift"}, ".", 
    function()
            if client.focus then
                local tag = client.focus.screen.tags[client.focus.first_tag.index + 1]
                if tag then client.focus:move_to_tag(tag) end
            end
        end,
              {description = "move client to next tag", group = "client"}),

    awful.key({modkey}, "Tab",
              function() awful.menu.client_list({theme = {width = 250}}) end,
              {description = "go back", group = "tag"}),
    awful.key({modkey}, "space", function()
        local t = client.focus and client.focus.first_tag or nil
        if t then
            local clts = t:clients()
            for _, c in pairs(clts) do
                if c.maximized then c.maximized = false end
            end
        end
        awful.layout.inc(1)
    end, {description = "select next", group = "layout"}),
    awful.key({modkey, "Shift"}, "space", function()
        local t = client.focus and client.focus.first_tag or nil
        if t then
            local clts = t:clients()
            for _, c in pairs(clts) do
                if c.maximized then c.maximized = false end
            end
        end
        awful.layout.inc(-1)
    end, {description = "select previous", group = "layout"}),

    -- Client related
    awful.key({modkey}, "j", function() awful.client.focus.byidx(1) end,
              {description = "focus next by index", group = "client"}),
    awful.key({modkey}, "k", function() awful.client.focus.byidx(-1) end,
              {description = "focus previous by index", group = "client"}),

    awful.key({modkey}, "l", function() awful.client.focus.byidx(1) end,
              {description = "focus next by index", group = "client"}),
    awful.key({modkey}, "h", function() awful.client.focus.byidx(-1) end,
              {description = "focus previous by index", group = "client"}),

    awful.key({modkey}, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),

    awful.key({modkey, "Control"}, "space", awful.client.floating.toggle,
              {description = "toggle floating", group = "client"}),

    awful.key({modkey, "Shift"}, "n", function()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
            c:emit_signal("request::activate", "key.unminimize", {raise = true})
        end
    end, {description = "restore minimized", group = "client"}), -- }}} /View
    -- {{{ Movement/position
    -- Client related
    awful.key({modkey, "Shift"}, "j", function() awful.client.swap.byidx(1) end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({modkey, "Shift"}, "k",
              function() awful.client.swap.byidx(-1) end, {
        description = "swap with previous client by index",
        group = "client"
    }),

    awful.key({modkey}, "Up", function() move_client(client.focus, "up") end, {
        description = "Move floating client to the upper edge",
        group = "client"
    }),
    awful.key({modkey}, "Right",
              function() move_client(client.focus, "right") end, {
        description = "Move floating client to the right edge",
        group = "client"
    }),
    awful.key({modkey}, "Down",
              function() move_client(client.focus, "down") end, {
        description = "Move floating client to the botton edge",
        group = "client"
    }),
    awful.key({modkey}, "Left",
              function() move_client(client.focus, "left") end, {
        description = "Move floating client to the left edge",
        group = "client"
    }), awful.key({modkey, "Shift"}, "Up",
                  function() shift_client(client.focus, "up") end,
                  {description = "Move floating client", group = "client"}),
    awful.key({modkey, "Shift"}, "Right",
              function() shift_client(client.focus, "right") end,
              {description = "Move floating client", group = "client"}),
    awful.key({modkey, "Shift"}, "Down",
              function() shift_client(client.focus, "down") end,
              {description = "Move floating client", group = "client"}),
    awful.key({modkey, "Shift"}, "Left",
              function() shift_client(client.focus, "left") end,
              {description = "Move floating client", group = "client"}),
    -- }}} /Movement

    -- {{{ Form
    -- Client related
    awful.key({modkey}, "equal", function() awful.tag.incgap(2, nil) end, {
        description = "increment gaps size for the current tag",
        group = "layout"
    }),
    awful.key({modkey}, "minus", function() awful.tag.incgap(-2, nil) end, {
        description = "decrement gap size for the current tag",
        group = "layout"
    }), -- }}} /Position/Form
    -- {{{ Multimediakeys
    awful.key({}, "XF86Tools", function()
        -- pacmd set-card-profile 0 output:hdmi-stereo-extra1
        -- pacmd set-card-profile 0 output:analog-stereo+input:analog-stereo
    end, {description = "Change audio device", group = "multimedia"}),

    awful.key({}, "XF86AudioPlay", function() end, {
        description = "plays or pause current music player",
        group = "multimedia"
    }), awful.key({}, "XF86AudioRaiseVolume", function()
        awful.spawn("pamixer -i 5")
        awesome.emit_signal("volume_change")
    end, {description = "raise system volume", group = "multimedia"}),

    awful.key({}, "XF86AudioLowerVolume", function()
        awful.spawn("pamixer -d 5")
        awesome.emit_signal("volume_change")
    end, {description = "lower system volume", group = "multimedia"}),

    awful.key({}, "XF86AudioMute", function()
        awful.spawn("pamixer -t")
        awesome.emit_signal("volume_change")
    end, {description = "mute system audio", group = "multimedia"}),

    -- }}} /Multimediakeys

    -- {{{ Programs
    awful.key({modkey}, "c", function() awful.spawn(programs.calculator) end,
              {description = "open a calculator", group = "launcher"}),
    awful.key({modkey}, "p", function() awful.spawn(programs.filemanager) end,
              {description = "open a file manager", group = "launcher"}),
    awful.key({modkey, "Control"}, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({modkey, "Shift"}, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({modkey}, "t", function() awful.spawn(programs.terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({modkey}, "Return", function() awful.spawn(programs.launcher) end,
              {description = "runs a launcher", group = "launcher"}),
    awful.key({modkey}, "r",
              function() awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),
    awful.key({modkey}, "x", function()
        awful.prompt.run {
            prompt = "Run Lua code: ",
            textbox = awful.screen.focused().mypromptbox.widget,
            exe_callback = awful.util.eval,
            history_path = awful.util.get_cache_dir() .. "/history_eval"
        }
    end, {description = "lua execute prompt", group = "awesome"}),
    -- }}} /Programs

    -- {{{ Misc
    awful.key({modkey}, "s", hotkeys_popup.show_help,
              {description = "show help", group = "awesome"}) -- {{{ /Misc
    )

    -- Bind all key numbers to tags.
    -- Be careful: we use keycodes to make it work on any keyboard layout.
    -- This should map on the top row of your keyboard, usually 1 to 9.
    for i = 1, 9 do
        out = gears.table.join(out, -- View tag only.
        awful.key({modkey}, "#" .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then tag:view_only() end
        end, {description = "view tag #" .. i, group = "tag"}),
        -- Toggle tag display.
                               awful.key({modkey, "Control"}, "#" .. i + 9,
                                         function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then awful.tag.viewtoggle(tag) end
        end, {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
                               awful.key({modkey, "Shift"}, "#" .. i + 9,
                                         function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then client.focus:move_to_tag(tag) end
            end
        end, {description = "move focused client to tag #" .. i, group = "tag"}),
        -- Toggle tag on focused client.
                               awful.key({modkey, "Control", "Shift"},
                                         "#" .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then client.focus:toggle_tag(tag) end
            end
        end, {
            description = "toggle focused client on tag #" .. i,
            group = "tag"
        }))
    end

    return out

end

function keys.clientkeys()
    return gears.table.join(awful.key({modkey}, "q", function(c) c:kill() end,
                                      {description = "close", group = "client"}),

                            awful.key({modkey}, "f", function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end, {description = "toggle fullscreen", group = "client"}),

                            awful.key({modkey, "Control"}, "Up", function(c)
        resize_client(client.focus, "up")
    end, {description = "resize client", group = "client"}),
                            awful.key({modkey, "Control"}, "Right", function(c)
        resize_client(client.focus, "right")
    end, {description = "resize client", group = "client"}),
                            awful.key({modkey, "Control"}, "Down", function(c)
        resize_client(client.focus, "down")
    end, {description = "resize client", group = "client"}),
                            awful.key({modkey, "Control"}, "Left", function(c)
        resize_client(client.focus, "left")
    end, {description = "resize client", group = "client"}),

                            awful.key({modkey, "Shift"}, "t",
                                      function(c) c.ontop = not c.ontop end, {
        description = "toggle keep on top",
        group = "client"
    }), awful.key({modkey}, "m", function(c)
        c.maximized = not c.maximized
        -- c:raise()
        if c.maximized then maximize_client(c) end
    end, {description = "(un)maximize", group = "client"}),

                            awful.key({modkey}, "n",
                                      function(c) c.minimized = true end, {
        description = "minimize",
        group = "client"
    }))
end

function keys.clientbuttons()
    return gears.table.join(awful.button({}, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end), awful.button({modkey}, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        if not c.floating then awful.client.floating.toggle() end
        awful.mouse.client.move(c)
    end), awful.button({modkey, "Control"}, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.client.floating.toggle()
    end), awful.button({modkey}, 3, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end))
end

return keys

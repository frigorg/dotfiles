local gears = require("gears")
local awful = require("awful")
-- Custom Local Library
-- local titlebar = require("anybox.titlebar")

-- Theme handling library
local beautiful = require("beautiful")

local _M = {}
local modkey = RC.vars.modkey

-- Alternative function to maximize client keeping the border and gaps around the client
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
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get()
  local clientkeys = gears.table.join(
    awful.key({ modkey,           }, "equal", function() awful.tag.incgap(2, nil) end,
              {description = "increment gaps size for the current tag", group = "layout"}),

    awful.key({ modkey,           }, "minus", function() awful.tag.incgap(-2, nil) end,
              {description = "decrement gap size for the current tag", group = "layout"}),

    awful.key({ modkey,           }, "f",
      function (c)
        c.fullscreen = not c.fullscreen
        c:raise()
      end,
      {description = "toggle fullscreen", group = "client"}),

    awful.key({ modkey,           }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),

    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),

    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),

    awful.key({ modkey, "Control" }, ".", function()
        if client.focus then
            client.focus:move_to_screen() 
        end
    end, {description = "move client to next screen", group = "client"}),

    awful.key({ modkey, "Control" }, ",", function()
        if client.focus then
            client.focus:move_to_screen(client.focus.screen.index-1) 
        end
    end, {description = "move client to previous screen", group = "client"}),

    awful.key({ modkey, "Shift"  }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),

    awful.key({ modkey,          }, "n",
      function (c)
        -- The client currently has the input focus, so it cannot be
        -- minimized, since minimized clients can't have the focus.
        c.minimized = true
      end ,
      {description = "minimize", group = "client"}),

    awful.key({ modkey,           }, "m",
      function (c)
        c.maximized = not c.maximized
        -- c:raise()
        if c.maximized then maximize_client(c) end
      end ,
      {description = "(un)maximize", group = "client"})
  )

  return clientkeys
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })

local awful = require("awful")
local beautiful = require("beautiful")

local rules = {}

-- Rules to apply to new clients (through the "manage" signal).
function rules.create(clientkeys, clientbuttons)
    return {
        -- All clients will match this rule.
        {
            rule = {},
            properties = {
                border_width = beautiful.border_width,
                border_color = beautiful.border_normal,
                focus = awful.client.focus.filter,
                raise = true,
                screen = awful.screen.preferred,
                placement = awful.placement.no_overlap +
                    awful.placement.no_offscreen +
                    awful.placement.centered,
                keys = clientkeys,
                buttons = clientbuttons,
                gap_single_client = false
            }
        }, -- Floating clients.
        {
            rule_any = {
                instance = {
                    "DTA", -- Firefox addon DownThemAll.
                    "copyq", -- Includes session name in class.
                    "pinentry"
                },
                class = {
                    "Arandr", "Blueman-manager", "Gpick", "Kruler", "xpad", "pavucontrol", "com.github.jmoerman.go-for-it",
                    "MessageWin", -- kalarm.
                    "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                    "Wpa_gui", "veromix", "xtightvncviewer"
                },

                -- Note that the name property shown in xprop might be set slightly after creation of the client
                -- and the name shown there might not match defined rules here.
                name = {
                    "Go For It!",
                    "Volume Control",
                    "Event Tester" -- xev.
                },
                role = {
                    "AlarmWindow", -- Thunderbird's calendar.
                    "ConfigManager", -- Thunderbird's about:config.
                    "pop-up" -- e.g. Google Chrome's (detached) Developer Tools.
                }
            },
            properties = {floating = true}
        },
        {
            rule_any = {
                name = {"Go For It!"},
                class = {"goforit"}
            },
            properties = {
                tag = "9"
            }
        }
    }
end

return rules

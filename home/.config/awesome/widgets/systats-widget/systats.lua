local awful = require("awful")
local wibox = require("wibox")
local vicious = require("vicious")

local icons_path = string.format("%s/.config/awesome/widgets/systats-widget/icons/", os.getenv("HOME"))

local widget_font = "Fira code 12"
local color_normal = "#C1C1C1"
local color_alert = "#B7AB38"
local color_warning = "#B73844"

local cpu_icon = icons_path .. "indicator-cpufreq.svg"
local mem_icon = icons_path .. "indicator-sensors-chip.svg"
local net_icon = icons_path .. "down-up.png"

function icon_wrapper(icon_path, vicious_widget, spacing) 
    return {{{ image         = icon_path,
              forced_height = 14,
              forced_width  = 14,
              resize        = true,
              widget        = wibox.widget.imagebox },
              valign = "center",
              widget = wibox.container.place
        },
            vicious_widget,
            spacing = spacing,
            layout = wibox.layout.fixed.horizontal
        }
end


volwidget = awful.widget.watch('bash -c "pamixer --get-volume-human"', 5, function(widget, stdout) 

    local volume = tonumber(stdout:match("(%d+)"))
    local volume_status = ""

    if not volume then
        volume_status = 'muted'
    else 
        if(volume >= 80) then
            volume_status = "high"
        elseif (volume >= 50) then
            volume_status = "mid"
        elseif (volume >= 1) then
            volume_status = "low"
        else
            volume_status = "muted"
        end
    end

    widget:set_text(volume_status)
end)

memwidget = wibox.widget.textbox()
memwidget.font = widget_font
vicious.cache(vicious.widgets.mem)
vicious.register(memwidget, vicious.widgets.mem, function(widget, args)
    local mem_value = tonumber(args[1])
    if mem_value <= 50 then
        return ('<span color="%s">%s%%</span>'):format(color_normal, mem_value)
    elseif mem_value <= 80 then
        return ('<span color="%s">%s%%</span>'):format(color_alert, mem_value)
    else
        return ('<span color="%s">%s%%</span>'):format(color_warning, mem_value)
    end
end, 5)

cpuwidget = wibox.widget.textbox()
cpuwidget.font = widget_font
vicious.cache(vicious.widgets.cpu)
vicious.register(cpuwidget, vicious.widgets.cpu,function(widget, args) 
    local cpu_value = tonumber(args[1])
    if cpu_value <= 50 then
        return ('<span color="%s">%s%%</span>'):format(color_normal, cpu_value)
    elseif cpu_value <= 80 then
        return ('<span color="%s">%s%%</span>'):format(color_alert, cpu_value)
    else
        return ('<span color="%s">%s%%</span>'):format(color_warning, cpu_value)
    end
end, 5)

netwidget = wibox.widget.textbox()
netwidget.font = widget_font
vicious.cache(vicious.widgets.net)
vicious.register(netwidget, vicious.widgets.net, "${eno1 down_kb}kb/${eno1 up_kb}kb", 5)

weatherwidget = wibox.widget.textbox()
weatherwidget.font = widget_font
vicious.cache(vicious.widgets.weather())
vicious.register(weatherwidget, vicious.widgets.weather, "${tempc}°C", 60, "SBYS")

return wibox.widget {
    {
        icon_wrapper(net_icon, netwidget, 2),
        icon_wrapper(cpu_icon, cpuwidget, 2),
        icon_wrapper(mem_icon, memwidget, 2),
        spacing = 8,
        layout = wibox.layout.fixed.horizontal
    },
    widget = wibox.container.background
}


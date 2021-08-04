local awful = require("awful")
local wibox = require("wibox")


status_widget = awful.widget.watch('bash -c "xprop -root | grep ^WM_NAME"', 5, function(widget, stdout)
    
    if (stdout == nil or stdout == '') then
        widget:set_text("N/A")
        return 
    end

    ram = stdout:match('RAM:(%d+)')
    cpu = stdout:match('CPU:(%d+)')
    up = stdout:match('UP:(%d+.%d+)')
    down = stdout:match('DOWN:(%d+.%d+)')
    
    widget.font = "Fira coda 10"
    widget:set_text('⬇ '..down..' ⬆ '..up..' | CPU: '..cpu..'% | RAM: '..ram..'%')
    widget.forced_width = 250
    widget.align = "center"
    return
end)


return {status=status_widget}

-------------------
----- HYPRBAR -----
-------------------

hl.config({
    plugin = {
        hyprbars = {
	    enabled = false,
            bar_height = 32,
            on_double_click = "hyprctl dispatch fullscreen 1",
	    bar_text_size = 12,
	    bar_text_font = "Inter",
	    bar_text_weight = "medium",
	    bar_precedence_over_border = true,
	    --bar_blur = true,
	    bar_buttons_alignment = "left",
	    bar_color = require("noctalia").colors.surface,
	    bar_part_of_window = true,
        },
    },
})

hl.plugin.hyprbars.add_button({
    bg_color = "rgb(ff4040)",
    fg_color = "rgb(ffffff)",
    size = 12,
    icon = "X",
    action = "hyprctl dispatch 'hl.dsp.window.close()'",
})

hl.plugin.hyprbars.add_button({
    bg_color = "rgb(eeee11)",
    fg_color = "rgb(000000)",
    size = 12,
    icon = "_",
    action = [[hyprctl dispatch 'hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" })']],
})

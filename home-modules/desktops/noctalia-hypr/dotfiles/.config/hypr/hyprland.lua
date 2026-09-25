--------------------
----- HYPRLAND -----
--------------------

require("env")
require("autostart")
require("input")
require("output")
require("keybinds")
require("rules")
require("appearance")
require("animations")

hl.config({
    general = {
        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = true,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        -- Niri-like layout
        layout = "scrolling",
    },

    binds = {
        scroll_event_delay = 0,
        --drag_center_window = false,
    },
    
    render = {
        new_render_scheduling = true,
    },

    misc = {
        force_default_wallpaper = 0,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(
        disable_splash_rendering = true,
	    font_family = "Inter",
	    focus_on_activate = true, -- Discord is causing focus loss
	    disable_autoreload = true,
	    vrr = 2,
        middle_click_paste = false,
    },

    opengl = {
        nvidia_anti_flicker = false,
    },

    xwayland = {
	force_zero_scaling = true,
    },

    scrolling = {
        fullscreen_on_one_column = true,
    },
})

--require("hyprbar")

-- For Noctalia Color templates
require("noctalia").apply_theme()

require("noctalia-injection")

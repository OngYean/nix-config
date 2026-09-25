-----------------
----- INPUT -----
-----------------

hl.config({
    input = {
        -- Keyboard
        kb_layout  = "us",
	    numlock_by_default = true,
	    repeat_delay = 250,

        follow_mouse = 2,

        -- Mouse
        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
	    accel_profile = "flat",

	-- MacBook ahh touchpad
        scroll_method = "2fg",
        touchpad = {
            natural_scroll = true,
            drag_3fg = 1,
	    scroll_factor = 0.5,
        },

	-- Tablet
	tablet = {
	    output = "current",
	},
    },

    cursor = {
	    no_warps = true,
    },
})

hl.gesture({
    fingers = 4,
    direction = "vertical",
    action = "workspace"
})

hl.gesture({
    fingers = 4,
    direction = "horizontal",
    action = "scroll_move"
})

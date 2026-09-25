------------------
----- RULES  -----
------------------

-- Disable Noctalia shell animations since it is using its own
hl.layer_rule({
    name = "noctalia",
    match = {
        namespace = "^noctalia-(bar-.+|notification|panel|attached-panel|osd|window-switcher)$",
    },

    no_anim = true,
    ignore_alpha = 0.25,
    blur = true,
    blur_popups = true,
})

--hl.layer_rule({
--  name = "blur-dock",
--  match = {
--    namespace = "^noctalia-dock$"
--  },
--
--  blur = false,
--  --ignore_alpha = 0,
--})

hl.window_rule({
    name  = "suppress-maximize",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.window_rule({
    name  = "floating-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

hl.window_rule({
    name = "floating-screen-share-picker",
    match = { title = "Select what to share" },

    float = true,
})

hl.window_rule({
    name = "floating-vlc",
    match = { class = "vlc" },

    float = true,
})

hl.window_rule({
    name = "floating-kdeconnect-daemon",
    match = { class = "org.kde.kdeconnect.daemon" },

    float = true,
})

hl.window_rule({
    name = "floating-kdialog",
    match = { class = "org.kde.kdialog" },

    float = true,
})

hl.window_rule({
    name = "floating-scrcpy",
    match = { class = ".*scrcpy.*" },

    float = true,
    keep_aspect_ratio = true,
})

hl.window_rule({
    name = "floating-kcalc",
    match = { class = "org.kde.kcalc" },

    float = true,
    size = { 320, 480 },
})

hl.window_rule({
    name = "floating-noctalia-settings",
    match = { class = "dev.noctalia.Noctalia" },
    
    float = true,
    size = { 1080, 720 },
})

hl.on("window.title", function(w)
    if w ~= nil and w.title == "Bitwarden" then
        hl.dispatch(hl.dsp.window.float({ action = "set" }))
	hl.dispatch(hl.dsp.window.center({ action = "set" }))
    end
end)

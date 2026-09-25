--------------------
----- KEYBINDS -----
--------------------

local mainMod = "SUPER + "
local ipc = "noctalia msg "
local terminal = "alacritty"
local fileManager = "dolphin"

-- Hyprland core keybinds
hl.bind(mainMod .. "Q", hl.dsp.window.close())
hl.bind(mainMod .. "T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. "E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. "F", hl.dsp.window.float({ action = "toggle" }))

-- Move focus with mainMod + arrow keys, as well as WASD and HJKL keys
-- Note that up and down move between workspaces instead of changing focus on windows within a workspace
hl.bind(mainMod .. "left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. "right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. "up",    hl.dsp.focus({ workspace = "-1" }))
hl.bind(mainMod .. "down",  hl.dsp.focus({ workspace = "+1" }))
hl.bind(mainMod .. "A",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. "D", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. "W",    hl.dsp.focus({ workspace = "-1" }))
hl.bind(mainMod .. "S",  hl.dsp.focus({ workspace = "+1" }))
hl.bind(mainMod .. "H",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. "L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. "K",    hl.dsp.focus({ workspace = "-1" }))
hl.bind(mainMod .. "J",  hl.dsp.focus({ workspace = "+1" }))

-- Move window instead when paired with CTRL
hl.bind(mainMod .. "CTRL + left",  hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. "CTRL + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. "CTRL + up",    hl.dsp.window.move({ workspace = "-1" }))
hl.bind(mainMod .. "CTRL + down",  hl.dsp.window.move({ workspace = "+1" }))
hl.bind(mainMod .. "CTRL + A",  hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. "CTRL + D", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. "CTRL + W",    hl.dsp.window.move({ workspace = "-1" }))
hl.bind(mainMod .. "CTRL + S",  hl.dsp.window.move({ workspace = "+1" }))
hl.bind(mainMod .. "CTRL + H",  hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. "CTRL + L", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. "CTRL + K",    hl.dsp.window.move({ workspace = "-1" }))
hl.bind(mainMod .. "CTRL + J",  hl.dsp.window.move({ workspace = "+1" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + CTRL + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. "CTRL + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Scroll through existing workspaces with mainMod + scroll
-- Switch focus horizontally with mainMod + SHIFT + scroll
hl.bind(mainMod .. "mouse_down", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mainMod .. "mouse_up",   hl.dsp.focus({ workspace = "-1" }))
hl.bind(mainMod .. "SHIFT + mouse_down", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. "SHIFT + mouse_up",   hl.dsp.focus({ direction = "left" }))

-- Move active window up and down wokspaces with mainMod + CTRL + scroll
hl.bind(mainMod .. "CTRL + mouse_down", hl.dsp.window.move({ workspace = "+1" }))
hl.bind(mainMod .. "CTRL + mouse_up",   hl.dsp.window.move({ workspace = "-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. "mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. "mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Noctalia core keybinds
hl.bind(mainMod .. "SUPER_L", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"), { release = true })
hl.bind(mainMod .. "C", hl.dsp.exec_cmd(ipc .. "panel-toggle control-center"))
hl.bind(mainMod .. "comma", hl.dsp.exec_cmd(ipc .. "settings-toggle"))
hl.bind(mainMod .. "V", hl.dsp.exec_cmd(ipc .. "panel-toggle clipboard"))
hl.bind(mainMod .. "ALT + L", hl.dsp.exec_cmd(ipc .. "session lock"))
hl.bind(mainMod .. "SHIFT + S", hl.dsp.exec_cmd(ipc .. "screenshot-region")) 
hl.bind("Print", hl.dsp.exec_cmd(ipc .. "screenshot-fullscreen"))
hl.bind("ALT + Tab", hl.dsp.exec_cmd(ipc .. "window-switcher"))

-- Custom window control keybinds
hl.bind(mainMod .. "U", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

-- Classic Windows Task Manager keybind
hl.bind(mainMod .. "Escape", hl.dsp.exec_cmd("resources"))
hl.bind("CTRL + SHIFT + Escape", hl.dsp.exec_cmd("resources"))

-- Workaround for Dolphin showing empty application list
hl.bind(mainMod .. "ALT + K", hl.dsp.exec_cmd("XDG_MENU_PREFIX=arch- kbuildsycoca6 --noincremental"))

-- Media keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. "volume-up"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. "volume-down"), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. "volume-mute"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. "brightness-up"), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. "brightness-down"), { repeating = true })
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd(ipc .. "media next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(ipc .. "media toggle"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd(ipc .. "media toggle"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd(ipc .. "media previous"),   { locked = true })
hl.bind("XF86Calculator", hl.dsp.exec_cmd("kcalc"))


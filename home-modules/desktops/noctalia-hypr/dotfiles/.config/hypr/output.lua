------------------
----- OUTPUT -----
------------------

-- Laptop's built-in screen
hl.monitor({
    output = "eDP-1",
    mode = "highres highrr",
    position = "1920x0",
    scale = "1.25",
    --disabled = true,
})

-- External screen (via AMDGPU)
hl.monitor({
    output   = "DP-2",
    mode     = "highres highrr",
    position = "0x0",
    scale    = "1",
})

-- External screen (via NVIDIA)
hl.monitor({
    output   = "HDMI-A-1",
    mode     = "highres highrr",
    position = "0x0",
    scale    = "1",
})

-- Fallback monitor settings
hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1,
})


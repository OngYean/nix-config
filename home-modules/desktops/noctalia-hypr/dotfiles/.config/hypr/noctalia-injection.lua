------------------------------
----- NOCTALIA INJECTION -----
------------------------------

-- Injection to make border color semi-transparent

local colors = require("noctalia").colors
local alpha = "40"

local primary = string.gsub(string.gsub(colors.primary, "rgb", "rgba"), "%)", alpha .. ")")
local surface = string.gsub(string.gsub(colors.surface, "rgb", "rgba"), "%)", alpha .. ")")
local secondary = string.gsub(string.gsub(colors.secondary, "rgb", "rgba"), "%)", alpha .. ")") 
local error = string.gsub(string.gsub(colors.error, "rgb", "rgba"), "%)", alpha .. ")") 

hl.config({
    general = {
        col = {
            active_border = primary,
            inactive_border = surface,
        },
    },

    group = {
        col = {
            border_active = secondary,
            border_inactive = surface,
            border_locked_active = error,
            border_locked_inactive = surface,
        },

        groupbar = {
            col = {
                active = secondary,
                inactive = surface,
                locked_active = error,
                locked_inactive = surface,
            },
        },
    },
})

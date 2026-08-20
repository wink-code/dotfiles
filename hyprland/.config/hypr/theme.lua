-- theme.lua - colors + general + decoration (visual theme)
local C = {
    cyan     = "rgba(33ccffee)",
    green    = "rgba(00ff99ee)",
    inactive = "rgba(595959aa)",
    shadow   = "rgba(1a1a1aee)",
}

hl.config({
    general = {
        gaps_in     = 5,
        gaps_out    = 8,
        border_size = 2,
        col = {
            active_border   = { colors = { C.cyan, C.green }, angle = 45 },
            inactive_border = C.inactive,
        },
        resize_on_border = false,
        allow_tearing    = false,
        layout           = "scrolling",
    },

    decoration = {
        rounding         = 10,
        rounding_power   = 2,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = C.shadow,
        },
        blur = {
            enabled           = true,
            size              = 3,
            passes            = 1,
            new_optimizations = true,
            vibrancy          = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

return C

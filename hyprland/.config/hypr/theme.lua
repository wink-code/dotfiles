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
        gaps_out    = 2,
        border_size = 1,
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
        -- Hyprland 0.57 window wobble (spring: stiffness/mass/damping).
        -- Lower damping = more ringing, higher intensity = bigger deformation.
        wobble = {
            enabled   = true,
            intensity = 0.25,  -- default 0.2
            stiffness = 180,   -- default 200
            mass      = 1.0,   -- default 1.0
            damping   = 16,    -- default 12 (higher = settles faster)
            mesh      = 12,    -- vertices per edge; raise for smoother, costlier
        },
    },

    animations = {
        enabled = true,
    },
})

return C

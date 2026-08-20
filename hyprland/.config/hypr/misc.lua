-----------------------
--------- MISC ---------
-----------------------

hl.config({
    misc = {
        force_default_wallpaper    = 0,
        disable_hyprland_logo      = true,
        disable_splash_rendering   = true,
        mouse_move_enables_dpms    = true,
        enable_swallow             = true,
        swallow_regex              = "^(mpv|imv|feh|viewnior|eog|qview|sxiv|nsxiv)$",
        vrr                        = 2,
        initial_workspace_tracking = 0,
        allow_session_lock_restore = true,
    },

    xwayland = {
        force_zero_scaling   = true,
        use_nearest_neighbor = false,
    },

    debug = {
        disable_logs = true,
        disable_time = false,
    },
})

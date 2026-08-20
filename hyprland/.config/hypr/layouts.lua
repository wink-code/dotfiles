hl.config({
    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status        = "master",
        allow_small_split = true,
        mfact             = 0.5,
        smart_resizing    = true,
    },

    scrolling = {
        fullscreen_on_one_column = false,
        column_width             = 0.8,
        focus_fit_method         = 0,
        follow_focus             = true,
        follow_min_visible       = 0.4,
        explicit_column_widths   = "0.4, 0.6, 0.8, 1.0",
        direction                = "right",
    },
})

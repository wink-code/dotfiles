------------------------
----- WINDOW RULES -----
------------------------

hl.window_rule({
    name  = "suppress-maximize-events",
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
    name  = "hyprland-run",
    match = { class = "^(hyprland-run)$" },
    float = true,
})

hl.window_rule({
    name  = "waybar-opacity",
    match = { class = "^(waybar)$" },
    opacity = "0.85", -- string form (window-rule opacity effect is a string)
})

hl.window_rule({
    name  = "wofi-float",
    match = { class = "wofi" },
    pin = true,
})

hl.window_rule({
    name  = "matplotlib-float",
    match = { title = "^Figure.*" },
    float = true,
})

hl.window_rule({
    name  = "pinentry-float",
    match = { title = "^PIN entry.*$" },
    float  = true,
    center = true,
})

hl.window_rule({
    name  = "pinentry-gtk-float",
    match = { class = "^pinentry-gtk-2$" },
    float  = true,
    center = true,
})

hl.window_rule({
    name  = "pinentry-qt-float",
    match = { class = "^pinentry-qt$" },
    float  = true,
    center = true,
})

hl.window_rule({
    name  = "steam-float",
    match = { title = "^Steam$" },
    float = true,
})

hl.window_rule({
    name  = "steam-settings",
    match = { title = "^(Settings|Steam Settings)$" },
    float = true,
})

hl.window_rule({
    name  = "bluetooth-float",
    match = { title = "^Bluetooth.*$" },
    float  = true,
    center = true,
    size   = { 600, 500 },
})

hl.window_rule({
    name  = "pavucontrol-float",
    match = { class = "^pavucontrol$" },
    float = true,
})

hl.window_rule({
    name  = "firefox-pip",
    match = {
        class = "^firefox$",
        title = "^(Picture-in-Picture|PiP).*$",
    },
    float     = true,
    pin       = true,
    workspace = "special:magic",
})

hl.window_rule({
    name  = "gtk-dialog-center",
    match = { class = "^GtkFileChooserDialog$" },
    center = true,
})

hl.window_rule({
    name  = "kitty-float-rule",
    match = { class = "^(kitty-float)$" },
    float  = true,
    center = true,
    size   = "75% 70%", -- percentages must be string form (numbers use { 600, 500 })
})

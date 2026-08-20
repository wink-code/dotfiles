-- Hyprland Lua config - migrated from hyprland.conf (Hyprland 0.56.1)
-- https://wiki.hypr.land/Configuring/

------------------------
-------- MONITOR -------
------------------------

-- monitor=,preferred,auto,1
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})

------------------------
------ MY PROGRAMS -----
------------------------

local terminal    = "kitty"
local fileManager = "thunar"
local menu        = "hyprlauncher"
local browser     = "firefox"

------------------------
------- AUTOSTART ------
------------------------

hl.on("hyprland.start", function()
    hl.exec_cmd(terminal)
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("~/scripts/wallpaper-restore.sh")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprlauncher --daemon")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP DISPLAY XDG_SESSION_TYPE XDG_SESSION_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP DISPLAY")
    hl.exec_cmd("dunst")
    hl.exec_cmd("fcitx5")
    hl.exec_cmd("/home/johnwink/.local/bin/hyprexpose --no-preview")
end)

------------------------
-- ENVIRONMENT VARIABLES
------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XMODIFIERS", "@im=fcitx")
hl.env("QT_IM_MODULE", "fcitx")
hl.env("SDL_IM_MODULE", "fcitx")
hl.env("TERMINAL", "kitty")
hl.env("LOCK_CMD", "hyprlock")

------------------------
------ LOOK & FEEL -----
------------------------

hl.config({
    general = {
        gaps_in     = 5,
        gaps_out    = 8,
        border_size = 2,
        col = {
            active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
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
            color        = "rgba(1a1a1aee)",
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

-- Bezier curves (source uses bezier only - NO springs)
hl.curve("easeOutQuint",   { type = "bezier", points = { { 0.23, 1 },    { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear",         { type = "bezier", points = { { 0, 0 },       { 1, 1 } } })
hl.curve("almostLinear",   { type = "bezier", points = { { 0.5, 0.5 },   { 0.75, 1 } } })
hl.curve("quick",          { type = "bezier", points = { { 0.15, 0 },    { 0.1, 1 } } })

-- Animations (windows/windowsIn use easeOutQuint, faithfully from source)
hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true, speed = 7,    bezier = "quick" })

------------------------
-------- LAYOUTS -------
------------------------

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
        fullscreen_on_one_column = true,
        column_width             = 0.8,
        focus_fit_method         = 0,
        follow_focus             = true,
        follow_min_visible       = 0.4,
        explicit_column_widths   = "0.333, 0.5, 0.667, 1.0",
        direction                = "right",
    },
})

------------------------
--------- MISC ---------
------------------------

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
})

hl.config({
    xwayland = {
        force_zero_scaling   = true,
        use_nearest_neighbor = false,
    },

    debug = {
        disable_logs = true,
        disable_time = false,
    },
})

------------------------
--------- INPUT --------
------------------------

hl.config({
    input = {
        kb_layout   = "us",
        follow_mouse = 0,
        sensitivity = 0,
        touchpad = {
            natural_scroll = false,
        },
    },

    cursor = {
        inactive_timeout    = 3,
        no_hardware_cursors = false,
    },
})

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

------------------------
------ KEYBINDINGS -----
------------------------

local mainMod = "SUPER"

hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))

-- Floating quick-launch
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd("kitty --class kitty-float"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("hyprlauncher --toggle"))
hl.bind(mainMod .. " + grave", hl.dsp.exec_cmd("/home/johnwink/.local/bin/hyprexpose-toggle"))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("obsidian"))

-- Scrolling layout controls
hl.bind(mainMod .. " + i",            hl.dsp.layout("colresize +conf"))
hl.bind(mainMod .. " + SHIFT + i",    hl.dsp.layout("colresize -conf"))
hl.bind(mainMod .. " + bracketleft",  hl.dsp.layout("orientationleft"))
hl.bind(mainMod .. " + bracketright", hl.dsp.layout("orientationright"))
hl.bind(mainMod .. " + semicolon",    hl.dsp.layout("orientationnext"))

hl.bind(mainMod .. " + SHIFT + x", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + X",         hl.dsp.exec_cmd("~/.local/bin/wlogout-toggle"))
hl.bind(mainMod .. " + b",         hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + SHIFT + w", hl.dsp.exec_cmd("~/scripts/wallpaper-cycle.sh"))
hl.bind(mainMod .. " + U",         hl.dsp.exec_cmd("killall -SIGUSR1 waybar"))

-- Window cycling
hl.bind(mainMod .. " + Tab",         hl.dsp.window.cycle_next())
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.window.cycle_next({ next = false }))

-- Vim-style focus
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Vim-style resize (SUPER+CTRL, repeating)
hl.bind(mainMod .. " + CTRL + h", hl.dsp.window.resize({ x = -40, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + l", hl.dsp.window.resize({ x = 40,  y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + k", hl.dsp.window.resize({ x = 0,   y = -40, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + j", hl.dsp.window.resize({ x = 0,   y = 40, relative = true }), { repeating = true })

-- Vim-style move (SUPER+ALT, repeating)
hl.bind(mainMod .. " + ALT + h", hl.dsp.window.move({ x = -80, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + l", hl.dsp.window.move({ x = 80,  y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + k", hl.dsp.window.move({ x = 0,   y = -80, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + j", hl.dsp.window.move({ x = 0,   y = 80, relative = true }), { repeating = true })

-- Vim-style swap (SUPER+SHIFT)
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.swap({ direction = "down" }))

-- Arrow-key focus
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Workspace switching (1-10, 10 -> key 0)
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + s", hl.dsp.exec_cmd("~/.local/bin/screenshot area"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("~/.local/bin/move-to-magic"))

-- Scroll through workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Mouse resize (bindm)
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimedia keys (locked + repeating)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("~/.local/bin/brightness-up"),                     { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("~/.local/bin/brightness-down"),                  { locked = true, repeating = true })

-- Custom volume/brightness
hl.bind("CTRL + ALT + equal",         hl.dsp.exec_cmd("~/.local/bin/vol-up"))
hl.bind("CTRL + ALT + minus",         hl.dsp.exec_cmd("~/.local/bin/vol-down"))
hl.bind("CTRL + ALT + SHIFT + equal", hl.dsp.exec_cmd("~/.local/bin/brightness-up"))
hl.bind("CTRL + ALT + SHIFT + minus", hl.dsp.exec_cmd("~/.local/bin/brightness-down"))

hl.bind(mainMod .. " + F10", hl.dsp.exec_cmd("~/.local/bin/vol-down"))
hl.bind(mainMod .. " + F11", hl.dsp.exec_cmd("~/.local/bin/vol-up"))
hl.bind(mainMod .. " + F12", hl.dsp.exec_cmd("~/.local/bin/brightness-up"))
hl.bind(mainMod .. " + F9",  hl.dsp.exec_cmd("~/.local/bin/brightness-down"))

-- Screenshot
hl.bind(mainMod .. " + SHIFT + f", hl.dsp.exec_cmd("~/.local/bin/screenshot full"))

-- Playerctl (locked)
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

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

-- autostart.lua - env + exec-once (needs vars)
local vars = require("vars")

-----------------------
-- ENVIRONMENT VARIABLES
-----------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XMODIFIERS", "@im=fcitx")
hl.env("QT_IM_MODULE", "fcitx")
hl.env("SDL_IM_MODULE", "fcitx")
hl.env("TERMINAL", "kitty")
hl.env("LOCK_CMD", "hyprlock")

-----------------------
------- AUTOSTART ------
-----------------------

hl.on("hyprland.start", function()
    hl.exec_cmd(vars.terminal)
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

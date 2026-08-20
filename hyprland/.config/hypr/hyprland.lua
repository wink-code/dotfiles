-- Hyprland Lua config - modular (Hyprland 0.56.1)
-- https://wiki.hypr.land/Configuring/
-- Modules are required in dependency order; `require` resolves against this
-- file's directory (symlink-aware). Machines load LAST so machine config wins.
require("autostart")    -- env + exec-once (needs vars)
require("theme")        -- colors + general + decoration
require("animations")   -- bezier curves + animations
require("layouts")      -- dwindle / master / scrolling
require("misc")         -- misc + xwayland + debug
require("input")        -- input + cursor + gesture
require("keybinds")     -- keybindings (needs vars)
require("windowrules")  -- window rules
require("machines")     -- hostname detection + machine-specific config

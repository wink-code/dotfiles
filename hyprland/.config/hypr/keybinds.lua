-----------------------
------ KEYBINDINGS -----
-----------------------

local vars = require("vars")
local mainMod = vars.mainMod

-- Floating windows: raise the newly focused window to the top.
-- Tiled windows are left alone on purpose: raising them reorders the stack,
-- which messes up column order in the scrolling layout (see commit d4b8443).
local function raise_if_floating()
    local w = hl.get_active_window()
    if w and w.floating then
        hl.dispatch(hl.dsp.window.bring_to_top())
    end
end

local function focus_raise(direction)
    hl.dispatch(hl.dsp.focus({ direction = direction }))
    raise_if_floating()
end

hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(vars.terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(vars.fileManager))

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
hl.bind(mainMod .. " + b",         hl.dsp.exec_cmd(vars.browser))
hl.bind(mainMod .. " + SHIFT + w", hl.dsp.exec_cmd("~/scripts/wallpaper-cycle.sh"))
hl.bind(mainMod .. " + U",         hl.dsp.exec_cmd("killall -SIGUSR1 waybar"))

-- Power profile cycle (performance -> balanced -> power-saver)
hl.bind(mainMod .. " + SHIFT + p", hl.dsp.exec_cmd("~/scripts/power.sh cycle"))

-- Window cycling
hl.bind(mainMod .. " + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next())
    raise_if_floating()
end)
hl.bind(mainMod .. " + SHIFT + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next({ next = false }))
    raise_if_floating()
end)

-- Vim-style focus
hl.bind(mainMod .. " + h", function() focus_raise("left") end)
hl.bind(mainMod .. " + l", function() focus_raise("right") end)
hl.bind(mainMod .. " + k", function() focus_raise("up") end)
hl.bind(mainMod .. " + j", function() focus_raise("down") end)

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
hl.bind(mainMod .. " + left",  function() focus_raise("left") end)
hl.bind(mainMod .. " + right", function() focus_raise("right") end)
hl.bind(mainMod .. " + up",    function() focus_raise("up") end)
hl.bind(mainMod .. " + down",  function() focus_raise("down") end)

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

-- machines/sky_island.lua - "Sky Island" (laptop)
-- Key derived from /etc/hostname: "Sky Island" -> sky_island
local M = {}

local MAIN, EXT = "eDP-1", "HDMI-A-1"

-- Startup default is mirror; Super+Shift+D toggles mirror <-> extend at runtime.
M.mirrored = true

-- Existing workspaces only: moving a missing one just spams "Workspace not found".
local function move_ws(ws, monitor)
    if hl.get_workspace(ws) then
        pcall(function()
            hl.dispatch(hl.dsp.workspace.move({ workspace = ws, monitor = monitor }))
        end)
    end
end

-- Waybar crashes / drops the extra bar if it sees outputs appear/disappear,
-- so restart it around the change instead of letting it handle the hotplug.
local function restart_waybar()
    hl.exec_cmd("pkill -x waybar")
    hl.timer(function() hl.exec_cmd("waybar") end, { timeout = 400, type = "oneshot" })
end

function M.toggle_display()
    M.mirrored = not M.mirrored
    restart_waybar()

    if M.mirrored then
        -- Reclaim extra workspaces first: a mirrored output is not a valid
        -- move target, so they would stay on an invisible screen otherwise.
        for i = 6, 10 do move_ws(i, MAIN) end
        move_ws("special:magic", MAIN)
        for i = 1, 10 do
            hl.workspace_rule({ workspace = tostring(i), monitor = MAIN })
        end
        hl.monitor({ output = EXT, mode = "preferred", position = "auto", scale = 1, mirror = MAIN })
    else
        hl.monitor({ output = EXT, mode = "preferred", position = "auto-right", scale = 1, mirror = "" })
        for i = 6, 10 do
            hl.workspace_rule({ workspace = tostring(i), monitor = EXT })
        end
        -- A monitor rule only takes effect on the next frame, so move
        -- workspaces/switch screens after a short delay.
        local prev = hl.get_active_workspace()
        hl.timer(function()
            for i = 6, 10 do move_ws(i, EXT) end
            move_ws("special:magic", EXT)
            -- Put 6 on the second screen, then hand focus back to the main one
            -- unless the user was already on 6-10 (those just moved there).
            pcall(function() hl.dispatch(hl.dsp.focus({ workspace = 6 })) end)
            if prev and prev.id <= 5 then
                pcall(function() hl.dispatch(hl.dsp.focus({ workspace = prev.id })) end)
            end
        end, { timeout = 200, type = "oneshot" })
    end
end

function M.apply()
    hl.monitor({ output = MAIN, mode = "preferred", position = "0x0", scale = 1 })
    hl.monitor({
        output  =   EXT,
        mode    =   "preferred",
        position=   "auto",
        scale   =   1,
        mirror  =   MAIN,
    })
    hl.monitor({
        output  =   "",
        mode    =   "preferred",
        position=   "auto",
        scale   =   "1",
    })
    hl.device({ name = "epic-mouse-v1", sensitivity = -0.5 })
end
return M

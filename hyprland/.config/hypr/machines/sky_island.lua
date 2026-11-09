-- machines/sky_island.lua - "Sky Island" (laptop)
-- Key derived from /etc/hostname: "Sky Island" -> sky_island
local M = {}
function M.apply()
    hl.monitor({ output = "eDP-1", mode = "preferred", position = "0x0", scale = 1 })
    hl.monitor({
        output  =   "HDMI-A-1",
        mode    =   "preferred",
        position=   "auto",
        scale   =   1,
        mirror  =   "eDP-1",
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

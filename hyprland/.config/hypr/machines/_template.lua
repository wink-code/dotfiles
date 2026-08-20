-- machines/_template.lua - template for a new machine
-- 1. key = `cat /etc/hostname` normalized: lowercase, non-alnum -> _
--    e.g. "Sky Island" -> sky_island, "My-Desktop" -> my_desktop
-- 2. cp machines/_template.lua machines/<key>.lua
-- 3. edit apply() for that machine's monitors + devices
-- 4. hyprctl reload full-reset
local M = {}
function M.apply()
    -- hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@144", position = "0x0", scale = 1 })
    -- hl.device({ name = "some-mouse", sensitivity = -0.5 })
end
return M

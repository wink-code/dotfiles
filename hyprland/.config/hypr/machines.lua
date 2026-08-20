-- machines.lua - hostname-based machine detection
-- Reads /etc/hostname, normalizes to a require key, applies the matching
-- module under machines/. "File not found" -> graceful no-op.
-- A machine file that EXISTS but fails to load -> raises a visible error.
local function machine_key()
    local f = io.open("/etc/hostname", "r")
    if not f then return "" end
    local name = f:read("*l") or ""
    f:close()
    return name:lower():gsub("[^%w]", "_")
end
local key     = machine_key()
local machine = {}
if key ~= "" then
    local ok, mod = pcall(require, "machines." .. key)
    if ok then
        if type(mod) == "table" then machine = mod end
    elseif not tostring(mod):match("not found") then
        error("machines/" .. key .. ".lua failed to load: " .. tostring(mod))
    end
end
if type(machine.apply) == "function" then machine.apply() end
return machine

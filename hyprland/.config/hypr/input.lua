-----------------------
--------- INPUT --------
-----------------------

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

-- Keybinds
local mod = "SUPER"

-- Window management
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mod .. " + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))

-- Applications
hl.bind(mod .. " + T", hl.dsp.exec_cmd("kitty"))
hl.bind(mod .. " + Return", hl.dsp.workspace.toggle_special())
hl.bind(mod .. " + B", hl.dsp.exec_cmd("$BROWSER"))

-- Application launcher
hl.bind(mod .. " + space", hl.dsp.exec_cmd("dms ipc call spotlight toggle"))

-- Focus navigation (cycle through windows in layout order)
hl.bind(mod .. " + Left", hl.dsp.window.cycle_next({ next = false }))
hl.bind(mod .. " + Right", hl.dsp.window.cycle_next())
hl.bind(mod .. " + H", hl.dsp.window.cycle_next({ next = false }))
hl.bind(mod .. " + L", hl.dsp.window.cycle_next())

-- Focus workspace
hl.bind(mod .. " + Up", hl.dsp.focus({ workspace = "-1" }))
hl.bind(mod .. " + Down", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mod .. " + K", hl.dsp.focus({ workspace = "-1" }))
hl.bind(mod .. " + J", hl.dsp.focus({ workspace = "+1" }))

-- Move window
hl.bind(mod .. " + CTRL + Left", hl.dsp.window.move({ direction = "l" }))
hl.bind(mod .. " + CTRL + Right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mod .. " + CTRL + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(mod .. " + CTRL + L", hl.dsp.window.move({ direction = "r" }))
hl.bind(mod .. " + CTRL + Up", hl.dsp.window.move({ workspace = "-1" }))
hl.bind(mod .. " + CTRL + Down", hl.dsp.window.move({ workspace = "+1" }))
hl.bind(mod .. " + CTRL + K", hl.dsp.window.move({ workspace = "-1" }))
hl.bind(mod .. " + CTRL + J", hl.dsp.window.move({ workspace = "+1" }))
hl.bind(mod .. " + CTRL + U", hl.dsp.window.move({ direction = "d" }))
hl.bind(mod .. " + CTRL + I", hl.dsp.window.move({ direction = "u" }))

-- Workspace switching
for i = 1, 9 do
  hl.bind(mod .. " + " .. i, hl.dsp.focus({ workspace = i }))
end

-- Touchpad gestures (4-finger)
hl.gesture({
  fingers = 4,
  direction = "left",
  action = function()
    hl.dispatch(hl.dsp.window.cycle_next({ next = false }))
  end,
})
hl.gesture({
  fingers = 4,
  direction = "right",
  action = function()
    hl.dispatch(hl.dsp.window.cycle_next())
  end,
})
hl.gesture({
  fingers = 4,
  direction = "up",
  action = function()
    hl.dispatch(hl.dsp.focus({ workspace = "-1" }))
  end,
})
hl.gesture({
  fingers = 4,
  direction = "down",
  action = function()
    hl.dispatch(hl.dsp.focus({ workspace = "+1" }))
  end,
})

-- Resize window
hl.bind(mod .. " + SHIFT + Left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }))
hl.bind(mod .. " + SHIFT + Right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }))
hl.bind(mod .. " + SHIFT + H", hl.dsp.window.resize({ x = -10, y = 0, relative = true }))
hl.bind(mod .. " + SHIFT + L", hl.dsp.window.resize({ x = 10, y = 0, relative = true }))
hl.bind(mod .. " + SHIFT + Up", hl.dsp.window.resize({ x = 0, y = -10, relative = true }))
hl.bind(mod .. " + SHIFT + Down", hl.dsp.window.resize({ x = 0, y = 10, relative = true }))
hl.bind(mod .. " + SHIFT + K", hl.dsp.window.resize({ x = 0, y = -10, relative = true }))
hl.bind(mod .. " + SHIFT + J", hl.dsp.window.resize({ x = 0, y = 10, relative = true }))

-- Screen capture toolbar
hl.bind("Print", hl.dsp.exec_cmd("dms ipc call screenCaptureToolbar toggle"))

-- DMS modals
hl.bind(mod .. " + N", hl.dsp.exec_cmd("dms ipc call notifications toggle"))
hl.bind(mod .. " + P", hl.dsp.exec_cmd("dms ipc call notepad toggle"))
hl.bind(mod .. " + C", hl.dsp.exec_cmd("dms ipc call clipboard toggle"))
hl.bind(mod .. " + M", hl.dsp.exec_cmd("dms ipc call processlist toggle"))
hl.bind(mod .. " + X", hl.dsp.exec_cmd("dms ipc call powermenu toggle"))
hl.bind(mod .. " + COMMA", hl.dsp.exec_cmd("dms ipc call settings toggle"))
hl.bind(mod .. " + ALT + N", hl.dsp.exec_cmd("dms ipc call night toggle"), { locked = true })
hl.bind("SUPER + ALT + L", hl.dsp.exec_cmd("dms ipc call lock lock"))

-- Hardware media key for settings
hl.bind("XF86AudioMedia", hl.dsp.exec_cmd("dms ipc call settings toggle"), { locked = true })

-- Media keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("dms ipc call audio increment 3"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("dms ipc call audio decrement 3"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("dms ipc call audio mute"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("dms ipc call audio micmute"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("dms ipc call mpris playPause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("dms ipc call mpris previous"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("dms ipc call mpris next"), { locked = true })

-- Brightness
hl.bind(
  "XF86MonBrightnessUp",
  hl.dsp.exec_cmd("dms ipc call brightness increment 5"),
  { locked = true, repeating = true }
)
hl.bind(
  "XF86MonBrightnessDown",
  hl.dsp.exec_cmd("dms ipc call brightness decrement 5"),
  { locked = true, repeating = true }
)

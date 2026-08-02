-- Keybinds
local mod = "SUPER"

-- Window management
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mod .. " + ALT + F", hl.dsp.window.float({ action = "toggle" }))

-- Applications
hl.bind(mod .. " + T", hl.dsp.exec_cmd("kitty"))
hl.bind(mod .. " + Return", hl.dsp.workspace.toggle_special())
hl.bind(mod .. " + B", hl.dsp.exec_cmd("$BROWSER"))

-- Application launcher
hl.bind(mod .. " + space", hl.dsp.exec_cmd("dms ipc call spotlight toggle"))

-- Focus navigation (direction-based, follows visual layout order)
hl.bind(mod .. " + Left", hl.dsp.focus({ direction = "l" }))
hl.bind(mod .. " + Right", hl.dsp.focus({ direction = "r" }))
hl.bind(mod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mod .. " + Up", hl.dsp.focus({ direction = "u" }))
hl.bind(mod .. " + Down", hl.dsp.focus({ direction = "d" }))
hl.bind(mod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mod .. " + J", hl.dsp.focus({ direction = "d" }))

-- Focus workspace
hl.bind(mod .. " + ALT + Up", hl.dsp.focus({ workspace = "-1" }))
hl.bind(mod .. " + ALT + Down", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mod .. " + ALT + K", hl.dsp.focus({ workspace = "-1" }))
hl.bind(mod .. " + ALT + J", hl.dsp.focus({ workspace = "+1" }))

-- Move window (no re-layout)
hl.bind(mod .. " + CTRL + Left", hl.dsp.window.move({ direction = "l" }))
hl.bind(mod .. " + CTRL + Right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mod .. " + CTRL + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(mod .. " + CTRL + L", hl.dsp.window.move({ direction = "r" }))
hl.bind(mod .. " + CTRL + Up", hl.dsp.window.move({ direction = "u" }))
hl.bind(mod .. " + CTRL + Down", hl.dsp.window.move({ direction = "d" }))
hl.bind(mod .. " + CTRL + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(mod .. " + CTRL + J", hl.dsp.window.move({ direction = "d" }))

-- Resize window (100px steps, hold to repeat)
-- Grow toward direction
hl.bind(mod .. " + SHIFT + Left", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
hl.bind(mod .. " + SHIFT + Right", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })
hl.bind(mod .. " + SHIFT + Up", hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true })
hl.bind(mod .. " + SHIFT + Down", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), { repeating = true })
hl.bind(mod .. " + SHIFT + H", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
hl.bind(mod .. " + SHIFT + L", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })
hl.bind(mod .. " + SHIFT + K", hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true })
hl.bind(mod .. " + SHIFT + J", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), { repeating = true })

-- Shrink toward direction
hl.bind(mod .. " + ALT + SHIFT + Left", hl.dsp.window.resize({ x = 100, y = 0, relative = true }), { repeating = true })
hl.bind(
  mod .. " + ALT + SHIFT + Right",
  hl.dsp.window.resize({ x = -100, y = 0, relative = true }),
  { repeating = true }
)
hl.bind(mod .. " + ALT + SHIFT + Up", hl.dsp.window.resize({ x = 0, y = 100, relative = true }), { repeating = true })
hl.bind(
  mod .. " + ALT + SHIFT + Down",
  hl.dsp.window.resize({ x = 0, y = -100, relative = true }),
  { repeating = true }
)
hl.bind(mod .. " + ALT + SHIFT + H", hl.dsp.window.resize({ x = 100, y = 0, relative = true }), { repeating = true })
hl.bind(mod .. " + ALT + SHIFT + L", hl.dsp.window.resize({ x = -100, y = 0, relative = true }), { repeating = true })
hl.bind(mod .. " + ALT + SHIFT + K", hl.dsp.window.resize({ x = 0, y = 100, relative = true }), { repeating = true })
hl.bind(mod .. " + ALT + SHIFT + J", hl.dsp.window.resize({ x = 0, y = -100, relative = true }), { repeating = true })

-- Workspace switching
for i = 1, 9 do
  hl.bind(mod .. " + " .. i, hl.dsp.focus({ workspace = i }))
end

-- Touchpad gestures (4-finger)
hl.gesture({
  fingers = 4,
  direction = "left",
  action = function()
    hl.dispatch(hl.dsp.focus({ direction = "l" }))
  end,
})
hl.gesture({
  fingers = 4,
  direction = "right",
  action = function()
    hl.dispatch(hl.dsp.focus({ direction = "r" }))
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
-- Column width presets (scrolling layout, cycles explicit_column_widths)
hl.bind(mod .. " + R", hl.dsp.layout("colresize +conf"))

-- Screen capture toolbar
hl.bind("Print", hl.dsp.exec_cmd("dms ipc call screenCaptureToolbar toggle"))

-- DMS modals
hl.bind(mod .. " + N", hl.dsp.exec_cmd("dms ipc call notifications toggle"))
hl.bind(mod .. " + P", hl.dsp.exec_cmd("dms ipc call notepad toggle"))
hl.bind(mod .. " + V", hl.dsp.exec_cmd("dms ipc call clipboard toggle"))
hl.bind(mod .. " + M", hl.dsp.exec_cmd("dms ipc call processlist toggle"))
hl.bind(mod .. " + X", hl.dsp.exec_cmd("dms ipc call powermenu toggle"))
hl.bind(mod .. " + COMMA", hl.dsp.exec_cmd("dms ipc call settings toggle"))
hl.bind(mod .. " + ALT + N", hl.dsp.exec_cmd("dms ipc call night toggle"), { locked = true })
hl.bind(mod .. " + ALT + L", hl.dsp.exec_cmd("dms ipc call lock lock"))

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
  hl.dsp.exec_cmd('dms ipc call brightness increment 5 ""'),
  { locked = true, repeating = true }
)
hl.bind(
  "XF86MonBrightnessDown",
  hl.dsp.exec_cmd('dms ipc call brightness decrement 5 ""'),
  { locked = true, repeating = true }
)

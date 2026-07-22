-- DMS Include Configs
require("dms.layout")
require("dms.outputs")
require("dms.binds")
require("dms.binds-user")
require("dms.windowrules")
require("dms.cursor")

-- Startup
hl.on("hyprland.start", function()
  hl.exec_cmd("dms run")
end)

-- Environment
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("NIXOS_OZONE_WL", "1")
hl.env("QT_QPA_PLATFORMTHEME", "gtk3")
hl.env("QT_QPA_PLATFORMTHEME_QT6", "gtk3")

-- Keybinds
local mod = "SUPER"

-- Window management
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + SHIFT + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + SHIFT + V", hl.dsp.window.cycle_next({ floating = true }))

-- Applications
hl.bind(mod .. " + T", hl.dsp.exec_cmd("kitty"))
hl.bind(mod .. " + B", hl.dsp.exec_cmd("$BROWSER"))

-- Application launcher
hl.bind(mod .. " + space", hl.dsp.exec_cmd("dms ipc call spotlight toggle"))

-- Focus navigation (columns in scrolling layout)
hl.bind(mod .. " + Left", hl.dsp.focus({ direction = "l" }))
hl.bind(mod .. " + Right", hl.dsp.focus({ direction = "r" }))
hl.bind(mod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mod .. " + L", hl.dsp.focus({ direction = "r" }))

-- Focus workspace
hl.bind(mod .. " + Up", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mod .. " + Down", hl.dsp.focus({ workspace = "-1" }))
hl.bind(mod .. " + K", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mod .. " + J", hl.dsp.focus({ workspace = "-1" }))

-- Move window
hl.bind(mod .. " + CTRL + Left", hl.dsp.window.move({ direction = "l" }))
hl.bind(mod .. " + CTRL + Right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mod .. " + CTRL + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(mod .. " + CTRL + L", hl.dsp.window.move({ direction = "r" }))
hl.bind(mod .. " + CTRL + Up", hl.dsp.window.move({ direction = "u" }))
hl.bind(mod .. " + CTRL + Down", hl.dsp.window.move({ direction = "d" }))
hl.bind(mod .. " + CTRL + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(mod .. " + CTRL + J", hl.dsp.window.move({ direction = "d" }))

-- Workspace switching
for i = 1, 9 do
  hl.bind(mod .. " + " .. i, hl.dsp.focus({ workspace = i }))
end

-- Column width cycling (scrolling layout)
hl.bind(mod .. " + R", hl.dsp.layout("rollnext"))

-- Resize window
hl.bind(mod .. " + SHIFT + Left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }))
hl.bind(mod .. " + SHIFT + Right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }))
hl.bind(mod .. " + SHIFT + H", hl.dsp.window.resize({ x = -10, y = 0, relative = true }))
hl.bind(mod .. " + SHIFT + L", hl.dsp.window.resize({ x = 10, y = 0, relative = true }))
hl.bind(mod .. " + SHIFT + Up", hl.dsp.window.resize({ x = 0, y = -10, relative = true }))
hl.bind(mod .. " + SHIFT + Down", hl.dsp.window.resize({ x = 0, y = 10, relative = true }))
hl.bind(mod .. " + SHIFT + K", hl.dsp.window.resize({ x = 0, y = -10, relative = true }))
hl.bind(mod .. " + SHIFT + J", hl.dsp.window.resize({ x = 0, y = 10, relative = true }))

-- Screenshots
hl.bind("Print", hl.dsp.exec_cmd("grimblast copy area"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd("grimblast copy screen"))
hl.bind("ALT + Print", hl.dsp.exec_cmd("grimblast copy output"))

-- DMS modals
hl.bind(mod .. " + N", hl.dsp.exec_cmd("dms ipc call notifications toggle"))
hl.bind(mod .. " + P", hl.dsp.exec_cmd("dms ipc call notepad toggle"))
hl.bind(mod .. " + C", hl.dsp.exec_cmd("dms ipc call clipboard toggle"))
hl.bind(mod .. " + M", hl.dsp.exec_cmd("dms ipc call processlist toggle"))
hl.bind(mod .. " + X", hl.dsp.exec_cmd("dms ipc call powermenu toggle"))
hl.bind(mod .. " + COMMA", hl.dsp.exec_cmd("dms ipc call settings toggle"))
hl.bind(mod .. " + ALT + N", hl.dsp.exec_cmd("dms ipc call night toggle"))
hl.bind("SUPER + ALT + L", hl.dsp.exec_cmd("dms ipc call lock lock"))

-- Media keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("dms ipc call audio increment 3"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("dms ipc call audio decrement 3"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("dms ipc call audio mute"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("dms ipc call audio micmute"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("dms ipc call mpris playPause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("dms ipc call mpris previous"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("dms ipc call mpris next"), { locked = true })

-- Brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("dms ipc call brightness increment 5"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("dms ipc call brightness decrement 5"), { locked = true, repeating = true })

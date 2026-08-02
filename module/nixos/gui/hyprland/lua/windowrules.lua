-- Window rules (mirroring niri window-rules.nix)
-- Firefox PiP: float, pinned to bottom-right corner
hl.window_rule({
  match = { class = "^firefox$", initial_title = "^(Picture-in-Picture|画中画)$" },
  float = true,
  move = { "monitor_w - window_w", "monitor_h - window_h" },
})

hl.window_rule({
  match = { class = "^firefox$" },
  scrolling_width = 1.0,
})

hl.window_rule({
  match = { class = "^kitty$" },
  scrolling_width = 1.0,
  opacity = 0.9,
})

-- DMS spotlight: no animation
hl.layer_rule({
  match = { namespace = "dms:spotlight" },
  no_anim = true,
})

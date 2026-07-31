-- Window rules (mirroring niri window-rules.nix)
hl.window_rule({
  match = { class = "^firefox$", title = "^(Picture-in-Picture|画中画)$" },
  float = true,
  move = { 10, 10 },
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

-- Animation config (Apple-style: smooth springs, scale+fade windows, soft slides)

hl.curve("apple_spring", { type = "spring", mass = 1, stiffness = 120, dampening = 18 })
hl.curve("apple_soft", { type = "spring", mass = 1, stiffness = 90, dampening = 16 })

-- Window open/close: macOS zoom effect (scale up + fade in)
hl.animation({
  leaf = "windows",
  enabled = true,
  speed = 4,
  spring = "apple_spring",
  style = "popin 80%",
})

-- Window switch (alt-tab): gentle crossfade like macOS
hl.animation({ leaf = "fadeSwitch", enabled = true, speed = 3, spring = "apple_spring" })
hl.animation({ leaf = "fadeShadow", enabled = true, speed = 3, spring = "apple_spring" })

-- Layers (menus, panels): macOS-style slide
hl.animation({ leaf = "layers", enabled = true, speed = 5, spring = "apple_soft", style = "slide" })

-- Vertical slide for workspace switching (scrolling layout tape is horizontal)
hl.animation({
  leaf = "workspaces",
  enabled = true,
  speed = 4,
  spring = "apple_soft",
  style = "slidevert",
})

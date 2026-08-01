-- Misc: disable default wallpaper/splash to prevent flash before DMS
hl.config({
  general = {
    layout = "scrolling",
    gaps_in = 8,
    gaps_out = 8,
  },
  input = {
    accel_profile = "adaptive",
    follow_mouse = 1,
    touchpad = {
      natural_scroll = false,
      disable_while_typing = true,
      scroll_factor = 1.5,
      drag_3fg = 1,
    },
  },
  misc = {
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    middle_click_paste = false,
  },
})

-- Vertical slide for workspace switching (scrolling layout tape is horizontal)
hl.animation({
  leaf = "workspaces",
  enabled = true,
  speed = 2.5,
  bezier = "default",
  style = "slidevert",
})

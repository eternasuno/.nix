-- Misc: disable default wallpaper/splash to prevent flash before DMS
hl.config({
  general = {
    border_size = 1,
    gaps_in = 4,
    gaps_out = 4,
    layout = "scrolling",
    resize_on_border = true,
  },
  input = {
    accel_profile = "adaptive",
    follow_mouse = 1,
    touchpad = {
      disable_while_typing = true,
      drag_3fg = 1,
      natural_scroll = false,
      scroll_factor = 1.5,
      tap_and_drag = false,
    },
  },
  misc = {
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    middle_click_paste = false,
  },
})

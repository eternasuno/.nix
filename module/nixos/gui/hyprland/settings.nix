{
  vars,
  ...
}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        general = {
          layout = "scrolling";
          gaps_in = 5;
          gaps_out = 8;
          border_size = 0;
        };

        scrolling = {
          column_width = 0.6;
          fullscreen_on_one_column = false;
          focus_fit_method = 1;
          follow_focus = true;
          follow_min_visible = 0.4;
          explicit_column_widths = "0.4, 0.6, 1.0";
          direction = "right";
          wrap_focus = true;
          wrap_swapcol = true;
        };

        input = {
          touchpad = {
            natural_scroll = false;
            accel_profile = "adaptive";
            scroll_factor = 1.5;
          };
          mouse.natural_scroll = false;
        };

        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
        };

        decoration = {
          rounding = 12;
          inactive_opacity = 0.9;
        };
      };
    };
  };
}

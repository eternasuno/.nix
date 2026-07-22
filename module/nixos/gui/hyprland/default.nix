{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
      configType = "lua";

      #settings = {
      #  config = {
      #    input = {
      #      touchpad = {
      #        natural_scroll = false;
      #        scroll_factor = 1.5;
      #        disable_while_typing = true;
      #      };
      #      accel_profile = "adaptive";
      #      natural_scroll = false;
      #    };

      #    general = {
      #      layout = "scrolling";
      #      gaps_in = 4;
      #      gaps_out = 4;
      #      border_size = 2;
      #    };
      #    decoration = {
      #      rounding = 12;
      #      active_opacity = 1.0;
      #      inactive_opacity = 0.9;
      #      shadow = {
      #        enabled = true;
      #        range = 30;
      #        render_power = 5;
      #        color = "rgba(00000070)";
      #      };
      #    };
      #    misc = {
      #      disable_hyprland_logo = true;
      #      disable_splash_rendering = true;
      #    };
      #    scrolling = {
      #      direction = "right";
      #      column_width = 0.6;
      #    };
      #  };

      #  window_rule = [
      #    {
      #      match = {
      #        class = "^firefox$";
      #        title = "^(Picture-in-Picture|画中画)$";
      #      };
      #      float = true;
      #      border_size = 0;
      #      rounding = 12;
      #    }
      #    {
      #      match = {class = "^kitty$";};
      #      opacity = "0.9 0.9";
      #    }
      #  ];

      #  layer_rule = [
      #    {
      #      match = {namespace = "dms";};
      #      no_anim = true;
      #    }
      #    {
      #      match = {namespace = "^dms:blurwallpaper$";};
      #      no_anim = true;
      #    }
      #  ];
      #};

      extraConfig = builtins.readFile ./extra.lua;
    };
  };
}

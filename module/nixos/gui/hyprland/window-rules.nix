{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    wayland.windowManager.hyprland.extraConfig = ''
      -- Firefox PiP floating
      hl.window_rule({
        match = { class = "^firefox$", title = "^(Picture-in-Picture|画中画)$" },
        floating = true,
      })

      -- Firefox default column width in scrolling
      hl.window_rule({
        match = { class = "^firefox$" },
        scrolling_width = 0.5,
      })

      -- Kitty no borders
      hl.window_rule({
        match = { class = "^kitty$" },
        border_size = 0,
      })

      -- DMS shell windows floating
      hl.window_rule({
        match = { class = "^(org.quickshell)$" },
        floating = true,
      })
    '';
  };
}

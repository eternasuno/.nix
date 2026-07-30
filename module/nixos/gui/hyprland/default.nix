{vars, pkgs, ...}: let
  inherit (vars) username;
in {
  programs.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
  };

  home-manager.users.${username} = {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
      configType = "lua";
      extraConfig = builtins.readFile ./extra.lua;
    };
  };
}

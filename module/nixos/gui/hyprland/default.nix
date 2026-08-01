{vars, ...}: let
  inherit (vars) username;
in {
  imports = [
    ./programs.nix
  ];

  home-manager.users.${username} = {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
      configType = "lua";
      extraLuaFiles = {
        binds = ./lua/binds.lua;
        windowrules = ./lua/windowrules.lua;
        config = ./lua/config.lua;
        animation = ./lua/animation.lua;
      };
      extraConfig = builtins.readFile ./lua/hyprland.lua;
    };
  };
}

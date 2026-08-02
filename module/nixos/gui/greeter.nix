{
  vars,
  pkgs,
  ...
}: let
  inherit (vars) username;
in {
  programs.dconf.enable = true;

  services.displayManager.dms-greeter = {
    enable = true;
    compositor = {
      name = "hyprland";
      customConfig = ''
        hl.env("DMS_RUN_GREETER", "1")
        hl.config({
          misc = {
            disable_hyprland_logo = true,
            disable_splash_rendering = true,
          },
        })
        hl.monitor({ output = "eDP-1", scale = 1.6 })
      '';
    };
    configHome = "/home/${username}";
    quickshell.package = pkgs.quickshell;
  };
}

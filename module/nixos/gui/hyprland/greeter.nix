{vars, ...}: let
  inherit (vars) username;
in {
  programs = {
    dconf.enable = true;
    hyprland.enable = true;
  };

  services.displayManager.dux-greeter = {
    enable = true;
    compositor = {
      name = "hyprland";
      customConfig = ''
        hl.env("DMS_RUN_GREETER", "1")
        hl.env("HYPRLAND_NO_SD_TARGET", "1")
        hl.config({
          misc = {
            disable_hyprland_logo = true,
            disable_splash_rendering = true,
          },
        })
      '';
    };
    configHome = "/home/${username}";
  };
}

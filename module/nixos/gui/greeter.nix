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
    compositor.name = "hyprland";
    configHome = "/home/${username}";
    quickshell.package = pkgs.quickshell;
  };
}

{
  inputs,
  vars,
  pkgs,
  ...
}: let
  inherit (vars) username;
in {
  imports = [
    inputs.dankMaterialShell.nixosModules.greeter
  ];

  programs.dconf.enable = true;

  programs.niri = {
    enable = true;
  };

  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/${username}";
    quickshell.package = pkgs.quickshell;
  };
}

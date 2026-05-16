{ pkgs, vars, ... }:
let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    home.packages = [ pkgs.imv ];
    xdg.mimeApps.defaultApplications = {
      "image/*" = [ "imv.desktop" ];
    };
  };
}

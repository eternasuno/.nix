{ pkgs, vars, ... }:
let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    xdg.mimeApps.defaultApplications = {
      "video/*" = [ "mpv.desktop" ];
    };
  };
}

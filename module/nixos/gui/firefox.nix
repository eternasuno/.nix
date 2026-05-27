{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    home.sessionVariables = {
      BROWSER = "firefox";
    };
    xdg.mimeApps.defaultApplications = {
      "x-scheme-handler/about" = ["firefox.desktop"];
      "x-scheme-handler/http" = ["firefox.desktop"];
      "x-scheme-handler/https" = ["firefox.desktop"];
    };
  };
}

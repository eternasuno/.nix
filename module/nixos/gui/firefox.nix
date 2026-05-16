{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    home.sessionVariables = {
      BROWSER = "firefox";
    };
    xdg.mimeApps.defaultApplications = {
      "application/xhtml+xml" = ["firefox.desktop"];
      "text/html" = ["firefox.desktop"];
      "x-scheme-handler/about" = ["firefox.desktop"];
      "x-scheme-handler/http" = ["firefox.desktop"];
      "x-scheme-handler/https" = ["firefox.desktop"];
    };
  };
}

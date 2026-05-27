{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    xdg.mimeApps.defaultApplications = {
      "text/*" = ["neovim.desktop"];
      "application/json" = ["neovim.desktop"];
      "application/xhtml+xml" = ["neovim.desktop"];
    };
  };
}

{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {config, ...}: {
    xdg = {
      enable = true;
      mimeApps = {
        enable = true;
      };
      userDirs = {
        enable = true;
        setSessionVariables = true;
        desktop = "${config.home.homeDirectory}/Desktop";
        documents = "${config.home.homeDirectory}/Documents";
        download = "${config.home.homeDirectory}/Downloads";
        music = "${config.home.homeDirectory}/Music";
        pictures = "${config.home.homeDirectory}/Pictures";
        publicShare = "${config.home.homeDirectory}/Public";
        templates = "${config.home.homeDirectory}/Templates";
        videos = "${config.home.homeDirectory}/Videos";
      };
      portal = {
        enable = true;
      };
    };
  };
}

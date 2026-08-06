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
      };
      portal = {
        enable = true;
      };
    };
  };
}

{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    programs.dank-material-shell = {
      plugins = {
        dankHyprlandWindows.enable = true;
      };
    };
  };
}

{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    programs.nushell = {
      enable = true;
      settings = {
        show_banner = false;
      };
    };
  };
}

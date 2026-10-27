{
  pkgs,
  vars,
  ...
}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    home.packages = with pkgs; [
      devenv
      cachix
    ];

    programs.direnv = {
      enable = true;
    };
  };
}

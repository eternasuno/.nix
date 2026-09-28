{
  pkgs,
  vars,
  ...
}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    home.packages = [pkgs.bitwarden-desktop];
  };
}

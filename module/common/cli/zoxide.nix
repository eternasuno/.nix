{ vars, ... }:
let
  inherit (vars) username;
in
{
  home-manager.users.${username}.programs.zoxide = {
    enable = true;
    options = [
      "--cmd cd"
    ];
  };
}

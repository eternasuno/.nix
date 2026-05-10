{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username}.home.sessionVariables = {
    BROWSER = "firefox";
  };
}

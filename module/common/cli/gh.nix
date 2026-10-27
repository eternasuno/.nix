{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username}.programs.gh = {
    enable = true;
    settings = {
      aliases = {
        co = "pr checkout";
        create = "pr create";
      };
    };
  };
}

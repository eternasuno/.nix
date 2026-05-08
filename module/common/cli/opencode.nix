{
  vars,
  ...
}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    programs.opencode = {
      enable = true;
    };
  };
}

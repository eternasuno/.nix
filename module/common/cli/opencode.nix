{
  vars,
  pkgs,
  ...
}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    home.sessionVariables = {
      OPENCODE_EXPERIMENTAL_BACKGROUND_SUBAGENTS = "true";
    };

    programs.opencode = {
      enable = true;
      extraPackages = with pkgs; [
        bun
      ];
    };
  };
}

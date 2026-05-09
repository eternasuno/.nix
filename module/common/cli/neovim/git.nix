{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username}.programs.nvf.settings.vim = {
    git = {
      enable = true;
      gitsigns = {
        enable = true;
        codeActions.enable = true;
      };
    };
  };
}

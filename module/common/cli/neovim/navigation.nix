{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username}.programs.nvf.settings.vim = {
    binds.whichKey.enable = true;
    filetree.neo-tree.enable = true;
    git = {
      enable = true;
      gitsigns = {
        enable = true;
        codeActions.enable = true;
      };
    };
    telescope.enable = true;
  };
}

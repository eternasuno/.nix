{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username}.programs.nvf.settings.vim = {
    filetree.neo-tree.enable = true;
    telescope.enable = true;
    binds.whichKey.enable = true;
    git = {
      enable = true;
      gitsigns = {
        enable = true;
        codeActions.enable = true;
      };
    };
  };
}

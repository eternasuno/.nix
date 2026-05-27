{
  vars, 
  pkgs, 
  ...
}: let
  inherit (vars) username;
in {
  home-manager.users.${username}.programs.nvf.settings.vim = {
    binds.whichKey.enable = true;
    git = {
      enable = true;
      gitsigns = {
        enable = true;
        codeActions.enable = true;
      };
    };
    telescope = {
      enable = true;
      setupOpts.defaults = {
        path_display = ["smart" "shorten" "absolute"];
      };
      extensions = [
        {
          name = "file_browser";
          packages = [pkgs.vimPlugins.telescope-file-browser-nvim];
          setup.file_browser = {
            hijack_netrw = true;
          };
        }
      ];
    };
  };
}

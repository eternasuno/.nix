{
  pkgs,
  vars,
  ...
}: let
  inherit (vars) username;
in {
  home-manager.users.${username}.programs.nvf.settings.vim = {
    languages = {
      enableTreesitter = true;
      enableFormat = true;

      json.enable = true;
      lua.enable = true;
      nix.enable = true;
      yaml.enable = true;
    };

    lsp = {
      enable = true;
      formatOnSave = true;
    };

    treesitter.grammars = with pkgs.vimPlugins.nvim-treesitter.grammarPlugins; [purescript];
  };
}

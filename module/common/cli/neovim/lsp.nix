{
  pkgs,
  lib,
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

    lsp.servers = {
      "vscode-json-language-server" = {
        cmd = lib.mkForce [
          "${pkgs.vscode-json-languageserver}/bin/vscode-json-language-server"
          "--stdio"
        ];
      };
    };

    treesitter.grammars = with pkgs.vimPlugins.nvim-treesitter.grammarPlugins; [purescript];
  };
}

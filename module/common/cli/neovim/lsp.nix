{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username}.programs.nvf.settings.vim = {
    languages = {
      enableTreesitter = true;
      enableFormat = true;

      css.enable = true;
      html.enable = true;
      markdown.enable = true;
      nix.enable = true;
      purescript = {
        enable = true;
        lsp.settings = {
          addSpagoSources = true;
          addNpmPath = true;
          buildCommand = "spago build  --json-errors";
        };
      };
      typescript = {
        enable = true;
        format = {
          enable = true;
          type = ["biome"];
        };
        extraDiagnostics = {
          enable = true;
          types = ["biomejs"];
        };
        lsp = {
          enable = true;
          servers = ["typescript-language-server" "deno"];
        };
      };
      typst.enable = true;
      yaml.enable = true;
    };

    lsp = {
      enable = true;
      formatOnSave = true;
      presets = {
        tailwindcss-language-server.enable = true;
      };
    };
  };
}

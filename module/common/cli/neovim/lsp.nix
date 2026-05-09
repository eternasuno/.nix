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
        format.type = ["biome"];
      };
      typst.enable = true;
      yaml.enable = true;
    };

    lsp = {
      enable = true;
      formatOnSave = true;
    };

    keymaps = [
      {
        key = "<leader>da";
        mode = ["n"];
        action = "<cmd>Telescope diagnostics<CR>";
        silent = true;
        desc = "Show All Diagnostics";
      }
      {
        key = "<leader>dc";
        mode = ["n"];
        action = "<cmd>lua vim.diagnostic.open_float(nil, {scope = 'cursor'})<CR>";
        silent = true;
        desc = "Show Cursor Diagnostics";
      }
    ];
  };
}

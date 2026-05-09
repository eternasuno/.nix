{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (builtins) attrNames;
  inherit (lib) optionalAttrs;
  inherit (lib.meta) getExe;
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.options) literalExpression mkEnableOption mkOption;
  inherit (lib.nvim.types) mkGrammarOption;
  inherit (lib.types) attrsOf anything enum package;

  cfg = config.vim.languages.purescript;

  formatters = {
    none = null;
    purty = null;
    purs-tidy = null;
    pose = null;
  };

  lspSettings =
    cfg.lsp.settings
    // optionalAttrs cfg.format.enable {
      formatter = cfg.format.type;
    };
in {
  options.vim.languages.purescript = {
    enable = mkEnableOption "PureScript language support" // {default = true;};

    treesitter = {
      enable =
        mkEnableOption "PureScript treesitter"
        // {
          default = config.vim.languages.enableTreesitter;
          defaultText = literalExpression "config.vim.languages.enableTreesitter";
        };
      package = mkGrammarOption pkgs "purescript";
    };

    lsp = {
      enable =
        mkEnableOption "PureScript LSP support"
        // {
          default = config.vim.lsp.enable;
          defaultText = literalExpression "config.vim.lsp.enable";
        };
      package = mkOption {
        type = package;
        default = pkgs.purescript-language-server;
        description = "PureScript language server package.";
        example = literalExpression "pkgs.purescript-language-server-0_18_5";
      };
      settings = mkOption {
        type = attrsOf anything;
        default = {};
        description = "Settings passed to `purescriptls` under `settings.purescript`.";
      };
      flags = mkOption {
        type = attrsOf anything;
        default = {
          debounce_text_changes = 150;
        };
        description = "Flags passed to the PureScript LSP client configuration.";
      };
    };

    format = {
      enable =
        mkEnableOption "PureScript formatting support"
        // {
          default = cfg.lsp.enable && config.vim.languages.enableFormat;
          defaultText = literalExpression "config.vim.languages.enableFormat && config.vim.languages.purescript.lsp.enable";
        };
      type = mkOption {
        type = enum (attrNames formatters);
        default = "purs-tidy";
        description = "Formatter exposed through the PureScript language server.";
      };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      assertions = [
        {
          assertion = !cfg.format.enable || cfg.lsp.enable;
          message = "PureScript formatting requires `vim.languages.purescript.lsp.enable = true`.";
        }
      ];
    }

    (mkIf cfg.treesitter.enable {
      vim.treesitter = {
        enable = true;
        grammars = [cfg.treesitter.package];
      };
    })

    (mkIf cfg.lsp.enable {
      vim.lsp.servers.purescriptls = {
        enable = true;
        cmd = [(getExe cfg.lsp.package) "--stdio"];
        filetypes = ["purescript"];
        root_markers = [
          "bower.json"
          "flake.nix"
          "psc-package.json"
          "shell.nix"
          "spago.dhall"
          "spago.yaml"
        ];
        settings = {
          purescript = lspSettings;
        };
        flags = cfg.lsp.flags;
      };
    })
  ]);
}

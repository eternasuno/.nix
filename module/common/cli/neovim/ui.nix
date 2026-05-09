{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username}.programs.nvf.settings.vim = {
    highlight = {
      IblIndent = {
        fg = "#4b5363";
      };
      IblScope = {
        fg = "#7aa2f7";
      };
    };

    theme = {
      enable = true;
      name = "onedark";
      style = "deep";
      transparent = true;
    };

    statusline.lualine = {
      enable = true;
      theme = "onedark";
    };

    dashboard.alpha.enable = true;

    visuals = {
      indent-blankline = {
        enable = true;
        setupOpts = {
          indent.highlight = "IblIndent";
          scope = {
            enabled = true;
            highlight = "IblScope";
          };
        };
      };
      nvim-web-devicons.enable = true;
    };

    options = {
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      mouse = "a";
      number = true;
      relativenumber = true;
      cursorline = true;
    };

    autopairs.nvim-autopairs.enable = true;
    utility.multicursors.enable = true;

    terminal.toggleterm = {
      enable = true;
      lazygit.enable = true;
      setupOpts = {
        direction = "float";
        open_mapping = "[[<c-t>]]";
      };
    };

    clipboard = {
      enable = true;
      registers = "unnamedplus";
    };
  };
}

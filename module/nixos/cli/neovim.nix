{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    programs.nvf.settings.vim.luaConfigRC.clipboard = ''
      vim.g.clipboard = {
        name = 'dms-clipboard',
        copy = {
          ['+'] = 'dms clipboard copy',
          ['*'] = 'dms clipboard copy',
        },
        paste = {
          ['+'] = 'dms clipboard paste',
          ['*'] = 'dms clipboard paste',
        },
        cache_enable = true,
      }
    '';

    xdg.mimeApps.defaultApplications = {
      "text/*" = ["neovim.desktop"];
      "application/json" = ["neovim.desktop"];
      "application/xhtml+xml" = ["neovim.desktop"];
    };
  };
}

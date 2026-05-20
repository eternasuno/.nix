{
  pkgs,
  vars,
  ...
}: let
  inherit (vars) username;
in {
  home-manager.users.${username}.programs.nvf.settings.vim = {
    extraPlugins = with pkgs.vimPlugins; {
      config-local = {
        package = nvim-config-local;
        setup = ''
          require('config-local').setup {
            lookup_parents = true,
          }
        '';
      };
    };
  };
}

{
  pkgs,
  vars,
  ...
}: let
  settings = import ./yazi.nix;
  keymap = import ./keymap.nix;
  theme = import ./theme.nix;
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    programs.yazi = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      shellWrapperName = "yy";
      settings = settings;
      keymap = keymap;
      theme = theme;
      plugins = {
        lazygit = pkgs.yaziPlugins.lazygit;
        full-border = pkgs.yaziPlugins.full-border;
        git = pkgs.yaziPlugins.git;
        smart-enter = pkgs.yaziPlugins.smart-enter;
      };
      initLua = ''
        require("full-border"):setup()
        require("git"):setup()
        require("smart-enter"):setup {
          open_multi = true,
        }
      '';
    };

    home.shellAliases = {
      y = "yazi";
    };

    home.packages = with pkgs; [
      ffmpegthumbnailer
      unar
      jq
      poppler-utils
      fd
      ripgrep
      imagemagick
    ];
  };
}

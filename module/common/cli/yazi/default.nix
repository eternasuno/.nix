{
  pkgs,
  vars,
  ...
}: let
  inherit (vars) username;
in {
  imports = [
    ./settings.nix
    ./open.nix
    ./plugins.nix
    ./keymap.nix
    ./theme.nix
  ];

  home-manager.users.${username} = {
    programs.yazi = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      shellWrapperName = "yy";
    };

    home.shellAliases = {
      y = "yazi";
    };

    home.packages = with pkgs; [
      exiftool
      ffmpegthumbnailer
      fd
      file
      fzf
      imagemagick
      jq
      mediainfo
      p7zip
      poppler-utils
      ripgrep
      libarchive
    ];
  };
}

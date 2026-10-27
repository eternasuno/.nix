{
  pkgs,
  vars,
  ...
}: let
  inherit (vars) username;
in {
  imports = [
    ./open.nix
    ./plugins.nix
    ./keymap.nix
  ];

  home-manager.users.${username} = {
    programs.yazi = {
      enable = true;
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

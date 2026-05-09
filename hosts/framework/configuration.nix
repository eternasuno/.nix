{
  vars,
  inputs,
  ...
}: let
  inherit (vars) username version;
in {
  imports = [
    ../../module/common/cli/bash.nix
    ../../module/common/cli/bat.nix
    ../../module/common/cli/devenv.nix
    ../../module/common/cli/git.nix
    ../../module/common/cli/lazygit.nix
    ../../module/common/cli/neovim
    ../../module/common/cli/nh.nix
    ../../module/common/cli/nushell.nix
    ../../module/common/cli/opencode.nix
    ../../module/common/cli/starship.nix
    ../../module/common/cli/yazi
    ../../module/common/cli/zoxide.nix
    ../../module/common/core/fonts.nix
    ../../module/common/core/nix.nix
    ../../module/common/gui/firefox.nix
    ../../module/common/gui/kitty.nix
    ../../module/nixos/core/boot.nix
    ../../module/nixos/core/fonts.nix
    ../../module/nixos/core/networking.nix
    ../../module/nixos/core/security.nix
    ../../module/nixos/core/time.nix
    ../../module/nixos/core/users.nix
    ../../module/nixos/gui/fcitx5.nix
    ../../module/nixos/gui/firefox.nix
    ../../module/nixos/gui/gtk.nix
    ../../module/nixos/gui/kitty.nix
    ../../module/nixos/gui/niri
    ../../module/nixos/gui/greeter.nix
    ../../module/nixos/gui/xdg.nix
    ../../module/nixos/services/pipewire.nix
  ];

  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit vars inputs;};
    users.${username} = {
      home = {
        username = username;
        homeDirectory = "/home/${username}";
        stateVersion = version;
      };
    };
  };

  system.stateVersion = version;
}

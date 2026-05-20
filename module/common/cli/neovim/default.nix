{
  pkgs,
  vars,
  inputs,
  ...
}: let
  inherit (vars) username;
in {
  imports = [
    ./autocomplete.nix
    ./config-local.nix
    ./keymap.nix
    ./lsp.nix
    ./navigation.nix
    ./ui.nix
  ];

  home-manager.users.${username} = {
    imports = [inputs.nvf.homeManagerModules.default];

    home.packages = with pkgs; [
      ripgrep
      fd
    ];

    home.sessionVariables = {
      EDITOR = "nvim";
    };

    programs.nvf = {
      enable = true;
      settings = {
        vim = {
          viAlias = true;
          vimAlias = true;
        };
      };
    };
  };
}

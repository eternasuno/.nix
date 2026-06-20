{ inputs, vars, ... }: let
  inherit (vars) username;
in {
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  nix-homebrew = {
    enable = true;
    user = username;
  };

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
  };
}

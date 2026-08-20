{
  pkgs,
  vars,
  inputs,
  ...
}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    home.packages = [
      (inputs.maki.packages.${pkgs.stdenv.hostPlatform.system}.default)
    ];

    xdg.configFile = {
      "maki/init.lua".source = ./init.lua;
      "maki/providers.toml".source = ./providers.toml;
    };
  };
}

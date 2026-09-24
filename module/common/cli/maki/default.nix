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
      pkgs.obscura
    ];

    xdg.configFile = {
      "maki/init.lua".source = ./init.lua;
      "maki/mcp.toml".source = ./mcp.toml;
      "maki/providers.toml".source = ./providers.toml;
      "maki/permissions.toml".source = ./permissions.toml;
      "maki/skills".source = ./skills;
    };
  };
}

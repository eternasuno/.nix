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
      "maki/AGENTS.md".source = ./AGENTS.md;
      "maki/init.lua".source = ./init.lua;
      "maki/mcp.toml".source = ./mcp.toml;
      "maki/providers.toml".source = ./providers.toml;
      "maki/permissions.toml".source = ./permissions.toml;
      "maki/plugin.toml".source = ./plugin.toml;
      "maki/skills".source = ./skills;
    };
  };
}

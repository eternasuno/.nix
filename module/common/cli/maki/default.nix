{
  pkgs,
  vars,
  inputs,
  ...
}: let
  inherit (vars) username flakePath;
in {
  home-manager.users.${username} = {config, ...}: let
    link = name: config.lib.file.mkOutOfStoreSymlink "${flakePath}/module/common/cli/maki/${name}";
  in {
    home.packages = [
      (inputs.maki.packages.${pkgs.stdenv.hostPlatform.system}.default)
      pkgs.obscura
    ];

    xdg.configFile = {
      "maki/init.lua".source = link "init.lua";
      "maki/mcp.toml".source = link "mcp.toml";
      "maki/providers.toml".source = link "providers.toml";
      "maki/permissions.toml".source = link "permissions.toml";
      "maki/skills".source = link "skills";
    };
  };
}

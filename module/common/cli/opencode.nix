{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    programs.opencode = {
      enable = true;
      settings = {
        "$schema" = "https://opencode.ai/config.json";
        context7 = {
          enabled = true;
          type = "remote";
          url = "https://mcp.context7.com/mcp";
        };
        lsp = true;
        plugin = ["superpowers@git+https://github.com/obra/superpowers.git"];
      };
    };
  };
}

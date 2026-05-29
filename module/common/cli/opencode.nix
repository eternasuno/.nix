{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    programs.opencode = {
      enable = true;
      settings = {
        "$schema" = "https://opencode.ai/config.json";
        autoupdate = false;
        mcp = {
          context7 = {
            enabled = true;
            type = "remote";
            url = "https://mcp.context7.com/mcp";
          };
          exa = {
            enabled = true;
            type = "remote";
            url = "https://mcp.exa.ai/mcp";
          };
        };
        lsp = true;
        plugin = [
          "opencode-antigravity-auth@latest"
        ];
      };
    };
  };
}

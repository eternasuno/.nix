{
  vars,
  pkgs,
  ...
}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    home.sessionVariables = {
      OPENCODE_EXPERIMENTAL_BACKGROUND_SUBAGENTS = "true";
      OPENCODE_ENABLE_EXA = "true";
    };

    programs.opencode = {
      enable = true;
      extraPackages = with pkgs; [bun nodejs];
      settings = {
        mcp = {
          deepwiki = {
            type = "remote";
            url = "https://mcp.deepwiki.com/mcp";
            enabled = true;
          };
        };
        plugin = [
          "oh-my-opencode-slim"
          "@dietrichgebert/ponytail"
          "@cortexkit/opencode-magic-context@latest"
          "@cortexkit/opencode-antigravity-auth@latest"
        ];
        agent = {
          explore = {disable = true;};
          general = {disable = true;};
        };
        provider = {
          v2ex = {
            npm = "@ai-sdk/openai-compatible";
            name = "V2EX";
            options = {
              baseURL = "https://edge.v2ex.com/chat/v1";
            };
            models = {
              "coder-ds4-0731" = {
                name = "deepseek-v4-flash";
              };
            };
          };
        };
        lsp = true;
        compaction = {
          auto = false;
          prune = false;
        };
      };
      skills = ./skills;
    };

    xdg.configFile = {
      "cortexkit/magic-context.jsonc".source = ./magic-context.jsonc;
      "opencode/oh-my-opencode-slim.json".source = ./oh-my-opencode-slim.json;
      "opencode/tui.json".source = ./tui.json;
    };
  };
}

{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    programs.opencode = {
      enable = true;
      settings = {
        "$schema" = "https://opencode.ai/config.json";
        autoupdate = false;
        lsp = true;
        plugin = [
          "opencode-antigravity-auth@latest"
          "oh-my-opencode-slim@latest"
        ];
      };
    };

    xdg.configFile."opencode/oh-my-opencode-slim.json".text = builtins.toJSON {
      "$schema" = "https://unpkg.com/oh-my-opencode-slim@latest/oh-my-opencode-slim.schema.json";
      preset = "opencode-go";
      presets.opencode-go = {
        orchestrator = {
          model = "opencode-go/glm-5.1";
          skills = ["*"];
          mcps = ["*" "!context7"];
        };
        oracle = {
          model = "opencode-go/deepseek-v4-pro";
          variant = "max";
          skills = ["simplify"];
          mcps = [];
        };
        council = {
          model = "opencode-go/deepseek-v4-pro";
          variant = "high";
          skills = [];
          mcps = [];
        };
        librarian = {
          model = "opencode-go/minimax-m2.7";
          skills = [];
          mcps = ["websearch" "context7" "grep_app"];
        };
        explorer = {
          model = "opencode-go/minimax-m2.7";
          skills = [];
          mcps = [];
        };
        designer = {
          model = "opencode-go/kimi-k2.6";
          variant = "medium";
          skills = ["agent-browser"];
          mcps = [];
        };
        fixer = {
          model = "opencode-go/deepseek-v4-flash";
          variant = "high";
          skills = [];
          mcps = [];
        };
        observer = {
          model = "opencode-go/kimi-k2.6";
          skills = [];
          mcps = [];
        };
      };
      disabled_agents = [];
    };
  };
}

{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    home.sessionVariables = {
      OPENCODE_EXPERIMENTAL_BACKGROUND_SUBAGENTS = "true";
    };

    programs.opencode = {
      enable = true;
      settings = {
        "$schema" = "https://opencode.ai/config.json";
        autoupdate = false;
        lsp = true;
        plugin = [
          "@cortexkit/aft-opencode@latest"
          "@cortexkit/opencode-antigravity-auth@latest"
          "@cortexkit/opencode-magic-context@latest"
          "oh-my-opencode-slim@latest"
        ];
        compaction = {
          auto = false;
          prune = false;
        };
      };
    };

    xdg.configFile."opencode/oh-my-opencode-slim.json".text = builtins.toJSON {
      "$schema" = "https://unpkg.com/oh-my-opencode-slim@latest/oh-my-opencode-slim.schema.json";
      preset = "opencode-go";
      presets.opencode-go = {
        orchestrator = {
          model = "opencode-go/glm-5.1";
        };
        oracle = {
          model = "opencode-go/deepseek-v4-pro";
          variant = "max";
        };
        council = {
          model = "opencode-go/deepseek-v4-pro";
          variant = "high";
        };
        librarian = {
          model = "opencode-go/minimax-m2.7";
          mcps = ["websearch" "context7" "grep_app"];
        };
        explorer = {
          model = "opencode-go/minimax-m2.7";
        };
        designer = {
          model = "opencode-go/kimi-k2.6";
          variant = "medium";
        };
        fixer = {
          model = "opencode-go/deepseek-v4-flash";
          variant = "high";
        };
        observer = {
          model = "opencode-go/kimi-k2.6";
        };
      };
      disabled_agents = [];
    };

    xdg.configFile."opencode/magic-context.jsonc".text = builtins.toJSON {
      "$schema" = "https://raw.githubusercontent.com/cortexkit/magic-context/master/assets/magic-context.schema.json";
      enabled = true;
      historian = {
        model = "opencode-go/deepseek-v4-flash";
      };
      memory = {
        enabled = true;
        injection_budget_tokens = 4000;
        auto_promote = true;
      };
      embedding = {
        provider = "local";
      };
    };
  };
}

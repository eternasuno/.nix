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
        plugin = [
          "@dietrichgebert/ponytail"
          "oh-my-opencode-slim"
          "@cortexkit/opencode-magic-context@0.35.1"
          [
            "@omniroute/opencode-plugin"
            {
              providerId = "omniroute";
              baseURL = "https://omniroute.eternasuno.ddns.net";
              autoSyncIntervalMs = 0;
            }
          ]
        ];
        agent = {
          explore = {disable = true;};
          general = {disable = true;};
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

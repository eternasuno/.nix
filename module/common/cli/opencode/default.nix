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
    };

    programs.opencode = {
      enable = true;
      settings = {
        plugin = [
          "oh-my-opencode-slim"
          "@cortexkit/opencode-antigravity-auth@latest"
          "@cortexkit/opencode-magic-context@latest"
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

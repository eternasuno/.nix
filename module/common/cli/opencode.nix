{
  vars,
  ...
}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    programs.opencode = {
      enable = true;
      settings = {
        "$schema" = "https://opencode.ai/config.json";
        plugin = ["superpowers@git+https://github.com/obra/superpowers.git"];
        lsp = true;
      };
    };
  };
}
